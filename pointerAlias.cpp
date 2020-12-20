
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/IntEqClasses.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/DataLayout.h"
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
#include <set>
#include <math.h>

using namespace std;
using namespace llvm;

int height = 0;


namespace 
{

  unordered_map<Instruction *, vector<Instruction *> > sub_to_gep_map;
  
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

    int getArraySizeFromGep(Instruction * I){
      Type *T = cast<PointerType>(cast<GetElementPtrInst>(I)->getPointerOperandType())->getElementType();
      int no_of_elements = cast<ArrayType>(T)->getNumElements();
      return no_of_elements;
    }

  
    void displayPtrMap(){
      cout << endl << "displaying ptr to sub array!" << endl;
      for(auto it: sub_to_gep_map){
        cout << endl;
        it.first->dump();
        cout << "Is referenced by: " << endl;
        for(auto itt: it.second)
          itt->dump();
      }
      cout << endl << endl;
    }

    bool isKeyInMap(unordered_map<Instruction *, vector<Instruction *> > m, Instruction * key) 
    { 
  
      if (m.find(key) == m.end()) 
        return false; 
      return true; 
    }

    Instruction * getAffectedPtrFromGEP(Instruction * I){
      //takes a GEP instruction and determines which pointer it computers the RHS for

      for(auto U : I->users()){ //improve this code! dont use for loop 
        
        Instruction * inst = dyn_cast<Instruction>(U); 
        
        if(strcmp(inst->getOpcodeName(), "store") == 0)
          return dyn_cast<Instruction>(inst->getOperand(1)); 
        else{
          assert(strcmp(inst->getOpcodeName(), "ptrtoint") == 0);
          return nullptr;
        }
      }  
  
    }

    void BuildSubtrToPtrMapping(Instruction * I, Instruction * gep_inst, set<Instruction *> &processedGeps_here){
      //Explores Tree of Users with GEP intr as root node and finds sub instr associated with GEP to create mapping 

      
      
      
      Instruction * rootGepNode = gep_inst;

      if(strcmp(I->getOpcodeName(), "sub") == 0){ //we found the target sub instruction!
      
        if(!isKeyInMap(sub_to_gep_map, I)){ //check to see if this target sub has been added before

          // cout << "adding key to ptr to sub mapping!" << endl << endl;
          vector<Instruction *> temp;
          temp.push_back(rootGepNode);
          sub_to_gep_map.insert({I, temp});
          // rootGepNode->dump();
        }
        else{
          bool updated = false;
          for(int i = 0; i < sub_to_gep_map[I].size(); i++){
            //check if we need to update a GEP or add a new one
            // cout << "checking if update needed..." << endl;
      
            if(doGepsPointToSameArray(sub_to_gep_map[I][i], gep_inst)){
              // cout << "updating with latest GEP!" << endl;
              sub_to_gep_map[I][i] = gep_inst;
              updated = true;
              break;
            }
          }
          if(!updated)
            sub_to_gep_map[I].push_back(rootGepNode);
          
        }
        //continue DFS and build mapping 
        processedGeps_here.insert(rootGepNode);
        return ; 
      }
      
      for(auto U : I->users()){  
      
          //cast child user as instruction
          Instruction * child_I = dyn_cast<Instruction>(U);
          Instruction * next_I;
        
          // cout << "child at height: " <<height<<" is:" << endl;
          // child_I->dump();

          //if the next user is store, we need to obtain the destination instruction * of the store op, then resume tracing
          if(strcmp(child_I->getOpcodeName(), "store") == 0){ 
            
            //get the destination operand and cast to instruction
            for (Use &dest_operand : child_I->operands()) 
              next_I = dyn_cast<Instruction>(dest_operand);
              
            //check to see if next user is the previous instruction itself to avoid circular loop
            if(next_I->isIdenticalTo(I)){
              // cout << "Loop present!" << endl;
              return; 
            }
            else{
              child_I = next_I;
            }         
          }
          if(strcmp(child_I->getOpcodeName(), "getelementptr") == 0){
            Instruction * next_I = dyn_cast<Instruction>(child_I->getOperand(0));
            
            //if this GEP is part of same pointer declaration, update the root gep
            if(next_I->isIdenticalTo(rootGepNode)){ 
              // cout << "updated root gep node" << endl;
              rootGepNode = child_I;
              processedGeps_here.insert(next_I);
            }
          }
          BuildSubtrToPtrMapping(child_I, rootGepNode, processedGeps_here); //check if DFS needs to be stopped
        
      }
    }

    Instruction * getRootGepFromFinalGep(Instruction * currentGEPInstr){
      //Recursive algo to traverse tree from final GEP associated with the RHS of a pointer to its first GEP declared
        Instruction * parentGEP = dyn_cast<Instruction>(currentGEPInstr->getOperand(0));
        
        if(strcmp(parentGEP->getOpcodeName(), "getelementptr") != 0)
          return currentGEPInstr;
        else
          return getRootGepFromFinalGep(parentGEP);
         
    }

    int getArraySizeFromGEP(Instruction * I, DataLayout DL_here){
      //returns total size of array associated with a GEP instr in Bytes
      Type *T = cast<PointerType>(cast<GetElementPtrInst>(I)->getPointerOperandType())->getElementType();
      return DL_here.getTypeSizeInBits(T)/8;
    }

    bool doGepsPointToSameArray(Instruction * firstGep, Instruction * secondGep){
      //takes 2 geps and sees if they reference the same array
      
      Instruction * firstArray = getAffectedPtrFromGEP(firstGep);    
      Instruction * secondArray = getAffectedPtrFromGEP(secondGep);
      return(firstArray == secondArray);
    }

    bool runOnFunction(Function &F) override {
    
      unordered_map<Instruction *, vector<Instruction *> > sub_to_gep_map;
      set<Instruction *> processedGeps;

      Module * thisModule = F.getParent();
      DataLayout DL = thisModule->getDataLayout();
      AAResults * AA = &(getAnalysis<AAResultsWrapperPass>().getAAResults());
      // auto &SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();      
      
      for (Function::iterator Fit = F.begin(), Fend = F.end(); Fit != Fend; ++Fit) {
        BasicBlock &BB = *Fit;

        for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end(); BBit != BBend; ++BBit) {
          Instruction *I = &*BBit;
          
          if (strcmp(I->getOpcodeName(), "getelementptr") == 0){
 
            // cout << "found GEP!" << endl;
            // I->dump();

            //check if this GEP has already been processed before
            if(processedGeps.find(I) != processedGeps.end()){
              // cout << "this gep is alreayd processed! skipping..." << endl;
              continue;
            }

            processedGeps.insert(I);           
            height = 0;
            BuildSubtrToPtrMapping(I, I, processedGeps); 
          
          }   
        }
      }

      // displayPtrMap();


      // cout << endl <<  "Results: " << endl;

      int firstObjSize, secondObjSize;

      for(auto it: ::sub_to_gep_map){

  
        
        //single sub inst is associated with 2 GEPS, check the alias() between these 2 GEPS
        if(it.second.size() == 2){ 
          
          firstObjSize = getArraySizeFromGEP(getRootGepFromFinalGep(it.second[0]), DL);
          secondObjSize = getArraySizeFromGEP(getRootGepFromFinalGep(it.second[1]), DL);

          assert(firstObjSize == secondObjSize);

          switch (AA->alias(it.second[0], LocationSize::precise(firstObjSize), it.second[1], LocationSize::precise(secondObjSize))) 
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
                it.first->dump();
                cout << "is a valid ptr diff op" << endl;
                // errs() << *it.second[0] << " is Must alias of " <<  *it.second[1] << "; " << "\n*************************\n";
                break;
          }
        }
      }
      exit(0);  
      return false;
    }
  };
} // namespace
char pointerAlias::ID = 10;
static RegisterPass<pointerAlias> Y("pointerAlias", "pointerAlias pass ", false, false);