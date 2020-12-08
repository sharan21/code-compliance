/* TO DO: 

0. array data type size is hardcoded
2. Only working for subtr between 2 pointers to an array, not working btw ptr and array base ref (e.g. diff = p1-a1)
3. Not working for subtr btw 2 interprocedural pts

*/ 



#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/IntEqClasses.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/MemoryLocation.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include <iostream>
#include <unordered_map>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

using namespace std;
using namespace llvm;

namespace 
{

  unordered_map<Instruction *, vector<Instruction *> > sub_to_gep_map;
  int n_d = 2; //write code to automatically get the dim of array!

  struct pointerAlias : public FunctionPass {
    static char ID;

    pointerAlias() : FunctionPass(ID) {}


    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.addRequired<AAResultsWrapperPass>();
      AU.addPreserved<AAResultsWrapperPass>();
      AU.addRequired<ScalarEvolutionWrapperPass>();
      AU.addPreserved<ScalarEvolutionWrapperPass>();
      AU.setPreservesAll();
    }

    string convertScevToString(const SCEV *scev_here){

      string scev_str;
      raw_string_ostream rso(scev_str);
      scev_here->print(rso);
      return rso.str();

    }

    // void get_bitlength_from_type(const Type *T){

    //   // string str;
    //   // raw_string_ostream rso(str);
    //   // T->print(rso);
    //   // // return rso.str();
    //   // T->getScalarSizeInBits();

    //   // cout << atoi(rso.str().c_str());

    //   // exit(0);
    //   // // return atoi(rso);

    // }

  
    void displayPtrMap(){
      cout << "displaying ptr to sub array!" << endl;

      for(auto it: sub_to_gep_map){
        it.first->dump();
        cout << "Is referenced by: " << endl;
        for(auto itt: it.second)
          itt->dump();
      }

    }

    bool isKeyInMap_2(Instruction * key) //maybe we dont need this? just map each gep instruction -> bool to indicate if already added or not
    { 
      
      for(auto it: ::sub_to_gep_map){
        if(it.second[0]->isIdenticalTo(key))
          return true;
        if(it.second.size() == 2 && it.second[1]->isIdenticalTo(key))
          return true;
      }
      return false; 
    }

    bool isKeyInMap(unordered_map<Instruction *, vector<Instruction *> > m, Instruction * key) 
    { 
      if (m.find(key) == m.end()) 
        return false; 
      return true; 
    }

    bool BuildSubtrToPtrMapping(Instruction * I, Instruction * gep_inst, unordered_map<Instruction *, bool> &gep_status){

      //Explores Tree of Users with GEP intr as root node and finds sub instr associated with GEP to create mapping 

      int n;
      Instruction * rootGepNode = gep_inst;

      if(strcmp(I->getOpcodeName(), "sub") == 0){
        // cout << "found sub!" << endl;

        if(!isKeyInMap(sub_to_gep_map, I)){
          cout << "adding key to ptr to sub mapping!" << endl << endl;
          gep_status[rootGepNode] = true; //update gep status to true
          vector<Instruction *> temp;
          temp.push_back(rootGepNode);
          sub_to_gep_map.insert({I, temp});
          // displayPtrMap();
        }
        else{
          cout << "updating key!" << endl << endl;
          sub_to_gep_map[I].push_back(rootGepNode);
        }
        return false; //continue DFS and build mapping 
      }
      
      for(auto U : I->users()){  // U is of type User*
      
          //cast child user as instruction
          auto child_I = dyn_cast<Instruction>(U);
          Instruction * next_I;

          cout << "child is:" << endl;
          child_I->dump();

          //if the next user is store, we need to obtain the destination instruction * of the store op, then resume tracing
          if(strcmp(child_I->getOpcodeName(), "store") == 0){ 
            
            // cout << "child is store! checking for circular loop!" << endl;
            //get the destination operand and cast to instruction
            for (Use &dest_operand : child_I->operands()) 
              next_I = dyn_cast<Instruction>(dest_operand);
              
            // cout << "stores next child is: " << endl;
            //check to see if next user is the previous instruction itself to avoid circular loop
            if(next_I->isIdenticalTo(I)){
              cout << "Loop present!" << endl;
              return true; //stop the DFS
            }
            else{
              // cout << "Loop not present, continue tracing..." << endl;
              child_I = next_I;
            }         
          }
          else if(strcmp(child_I->getOpcodeName(), "getelementptr") == 0){
            Instruction * next_I = dyn_cast<Instruction>(child_I->getOperand(0));
            
            if(next_I->isIdenticalTo(rootGepNode)){ //this GEP is part of same pointer declaration, update the root gep
              cout << "updated root gep node and updating gep status list!" << endl;
              gep_status[next_I] = true;
              rootGepNode = child_I;
            }
          }

          cin >> n;

          if(BuildSubtrToPtrMapping(child_I, rootGepNode)) //check if DFS needs to be stopped
            return true;
          
      }

    }

    int getArraySizeFromGep(Instruction * I){

      Type *T = cast<PointerType>(cast<GetElementPtrInst>(I)->getPointerOperandType())->getElementType();
      int no_of_elements = cast<ArrayType>(T)->getNumElements();
      return no_of_elements;
    
    }

    bool runOnFunction(Function &F) override {

      unordered_map<Instruction *, vector<Instruction *> > sub_to_gep_map;

      AAResults * AA = &(getAnalysis<AAResultsWrapperPass>().getAAResults());
      auto &SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();

      unordered_map<Instruction *, bool> gep_inst_arr; //keeps track of what geps have already been added in mapping
      SetVector<Instruction *> Inst_List;
      SetVector<Instruction *> sub_inst_arr;

      int no_of_gep = 0;
      int no_of_sub = 0;

      for (Function::iterator Fit = F.begin(), Fend = F.end(); Fit != Fend; ++Fit) {
        BasicBlock &BB = *Fit;

        for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end(); BBit != BBend; ++BBit) {
          Instruction *I = &*BBit;
          
          if (strcmp(I->getOpcodeName(), "getelementptr") == 0)
            gep_inst_arr.insert({I, false});
        
      }

      for(auto it: gep_inst_arr){

        Instruction * I = it.first;
        I->dump();
        displayPtrMap();

        if(isKeyInMap_2(I)){
          cout << "already mapped this GEP! skipping..." << endl;
          continue;
        }
        
        BuildSubtrToPtrMapping(I, I, gep_inst_arr); 
        gep_inst_arr.insert(I);
      
      }

      // for (Function::iterator Fit = F.begin(), Fend = F.end(); Fit != Fend; ++Fit) {
      //   BasicBlock &BB = *Fit;

      //   for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end(); BBit != BBend; ++BBit) {
      //     Instruction *I = &*BBit;
          
      //     if (strcmp(I->getOpcodeName(), "getelementptr") == 0){

      //       cout << "found GEP!" << endl;
            
      //   }
      // }
      // cout << endl <<  "Results: " << endl;

      // displayPtrMap();

      // // exit(0);
      
      
      for(auto it: ::sub_to_gep_map){
      
        if(it.second.size() == 2){ //single sub inst is associated with 2 GEPS, check the alias() between these 2 GEPS

          int size_of_arr = getArraySizeFromGep(it.second[0]); //im assuming that both geps array to same array
          assert(size_of_arr == getArraySizeFromGep(it.second[1])); //just to make sure

          
          switch (AA->alias(it.second[0], LocationSize::precise(sizeof(float)*pow(size_of_arr, n_d)), it.second[1], LocationSize::precise(sizeof(float)*pow(size_of_arr, n_d)))) 
          {
      
            case 0: //NoAlias
                it.first->dump();
                cout << "is not a valid ptr diff op!" << endl;
                // errs() <<  *it.second[0] << " is No alias of " << *it.second[1]<< "; " << "\n*************************\n";
                break;
            case 1: //MayAlias
                errs() << *it.second[0] << " is May alias of " <<  *it.second[1] << "; " << "\n*************************\n";
                break;
            case 2: //PartialAlias
                it.first->dump();
                cout << "is a valid ptr diff op" << endl;
                // errs() << *it.second[0] << " is Partial alias of " <<  *it.second[1] << "; " << "\n*************************\n";
                break;
            case 3: //MustAlias
                errs() << *it.second[0] << " is Must alias of " <<  *it.second[1] << "; " << "\n*************************\n";
                break;
          }

        }
      }
      
      exit(0);
      return false;
      
    }
  };
}; // namespace

char pointerAlias::ID = 10;
static RegisterPass<pointerAlias> Y("pointerAlias", "pointerAlias pass ", false, false);