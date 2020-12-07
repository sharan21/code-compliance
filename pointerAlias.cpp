/* TO DO: 

1. Not working for pointers to multidim arrays
2. Only working for subtr between 2 pointers to an array, not working btw ptr and array base ref 
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

using namespace std;
using namespace llvm;

namespace {

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

  string convert_scev_to_string(const SCEV *scev_here){

    string scev_str;
    raw_string_ostream rso(scev_str);
    scev_here->print(rso);
    return rso.str();

  }

 
  void display_mapping(){
    cout << "displaying ptr to sub array!!" << endl;

    for(auto it: sub_to_gep_map){
      it.first->dump();
      // cout << ""
    }

  }

  bool check_key(unordered_map<Instruction *, vector<Instruction *> > m, Instruction * key) 
  { 
    // Key is not present 
    if (m.find(key) == m.end()) 
        return false; 
  
    return true; 
  }

  bool build_sub_mapping(Instruction * I, Instruction * gep_inst ){

    int n;

    if(strcmp(I->getOpcodeName(), "sub") == 0){
      // cout << "found sub!" << endl;

      if(!check_key(sub_to_gep_map, I)){
        
        //create a new key and update it with the first GEP instruction
        cout << "adding key to ptr to sub mapping!" << endl << endl;
        vector<Instruction *> trythis;
        trythis.push_back(gep_inst);
        sub_to_gep_map.insert({I, trythis});

      }
      else{

        cout << "updating key!" << endl << endl;
        sub_to_gep_map[I].push_back(gep_inst);
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
          for (Use &dest_operand : child_I->operands()) {
            next_I = dyn_cast<Instruction>(dest_operand);
            
          }
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

        // cin >> n;

        if(build_sub_mapping(child_I, gep_inst)) //check if DFS needs to be stopped
          return true;
        
    }

  }

  bool runOnFunction(Function &F) override {

    unordered_map<Instruction *, vector<Instruction *> > sub_to_gep_map;

    AAResults * AA = &(getAnalysis<AAResultsWrapperPass>().getAAResults());
    auto &SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();

    // Add all pointers from M to the initial list of pointers
    SetVector<Instruction *> Inst_List;
    SetVector<Instruction *> gep_inst_arr;
    SetVector<Instruction *> sub_inst_arr;
    int no_of_gep = 0;
    int no_of_sub = 0;

    for (Function::iterator Fit = F.begin(), Fend = F.end(); Fit != Fend;
         ++Fit) {
      BasicBlock &BB = *Fit;

      for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end();
           BBit != BBend; ++BBit) {

        Instruction *I = &*BBit;

        
        if (strcmp(I->getOpcodeName(), "getelementptr") == 0){

          cout << "found GEP!" << endl;
          I->dump();

          build_sub_mapping(I, I); 

          no_of_gep++;
          gep_inst_arr.insert(I);
        }   

        if (strcmp(I->getOpcodeName(), "sub") == 0){
          // cout << "found sub!" << endl;
          no_of_sub++;
          sub_inst_arr.insert(I);
        }    

        Inst_List.insert(I);
      }
    }
    cout << endl <<  "Results: " << endl;
    
    for(auto it: ::sub_to_gep_map){
    
      if(it.second.size() == 2){ //single sub inst is associated with 2 GEPS, check the alias() between these 2 GEPS

        switch (AA->alias(it.second[0], LocationSize::precise(sizeof(int)*10), it.second[1], LocationSize::precise(sizeof(int)*10))) {
    
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

    size_t n = Inst_List.size();

    for (unsigned i = 0; i < n; ++i) {
      auto Inst = Inst_List[i];

      // if (strcmp(inst_arr[i]->getOpcodeName(), "getelementptr") == 0) {

      if (Inst->getOpcodeName()[2] == 'd' || Inst->getOpcodeName()[1] == 'u') {
        // errs() << *Inst << "\n";

        auto I1 = (dyn_cast<Instruction>(Inst->getOperand(0)))->getOperand(0);
        auto I2 = (dyn_cast<Instruction>(Inst->getOperand(1)))->getOperand(0);

      
        switch (AA->alias(I1, LocationSize::precise(1), I2, LocationSize::precise(1))) {
  
          case 0: //NoAlias
              errs() << *I1 << " is No alias of " << *I2 << "; " << "\n*************************\n";
              break;
          case 1: //MayAlias
              errs() << *I1 << " is May alias of " << *I2 << "; " << "\n*************************\n";
              break;
          case 2: //PartialAlias
              errs() << *I1 << " is Partial alias of " << *I2 << "; " << "\n*************************\n";
              break;
          case 3: //MustAlias
              errs() << *I1 << " is Must alias of " << *I2 << "; " << "\n*************************\n";
              break;
        }
      }

    }

    return false;
  }
};
} // namespace

char pointerAlias::ID = 10;
static RegisterPass<pointerAlias> Y("pointerAlias", "pointerAlias pass ", false, false);
