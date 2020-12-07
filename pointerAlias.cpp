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

unordered_map<Instruction *, vector<Instruction *> > ptr_to_sub_mapping;

struct pointerAlias : public FunctionPass {
  static char ID;

  pointerAlias() : FunctionPass(ID) {}

  string convert_scev_to_string(const SCEV *scev_here){

    string scev_str;
    
    raw_string_ostream rso(scev_str);
    scev_here->print(rso);

    return rso.str();

  }

  

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<AAResultsWrapperPass>();
    AU.addPreserved<AAResultsWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addPreserved<ScalarEvolutionWrapperPass>();
    AU.setPreservesAll();
  }

 
  void display(){
    cout << "displaying ptr to sub array!!" << endl;

    for(auto it: ptr_to_sub_mapping){
      it.first->dump();
    }

  }

  bool check_key(unordered_map<Instruction *, vector<Instruction *> > m, Instruction * key) 
  { 
    // Key is not present 
    if (m.find(key) == m.end()) 
        return false; 
  
    return true; 
  }

  bool traceSubtrFromGEP(Instruction * I, Instruction * gep_inst ){

    int n;

    if(strcmp(I->getOpcodeName(), "sub") == 0){
      cout << "found sub!" << endl;

      if(!check_key(ptr_to_sub_mapping, I)){
        
        //create a new key and update it with the first GEP instruction
        cout << "adding key to ptr to sub mapping!" << endl;
        vector<Instruction *> trythis;
        trythis.push_back(gep_inst);
        ptr_to_sub_mapping.insert({I, trythis});

      }
      else{

        cout << "updating key!" << endl;
        ptr_to_sub_mapping[I].push_back(gep_inst);
      }

      return true; 
      
    }
    
    for(auto U : I->users()){  // U is of type User*
    
        //cast child user as instruction
        auto child_I = dyn_cast<Instruction>(U);

        child_I->dump();

        //if the next user is store, we need to obtain the destination operand of the store, then resume tracing
        if(strcmp(child_I->getOpcodeName(), "store") == 0){ 
          for (Use &dest_operand : child_I->operands()) {
            child_I = dyn_cast<Instruction>(dest_operand);
            child_I->dump();
          }          
        }

        // cin >> n;

        if(traceSubtrFromGEP(child_I, gep_inst))
          return true;
        
    }

  }

  bool runOnFunction(Function &F) override {

    unordered_map<Instruction *, vector<Instruction *> > ptr_to_sub_mapping;

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

          traceSubtrFromGEP(I, I); 

          no_of_gep++;
          gep_inst_arr.insert(I);
        }   

        if (strcmp(I->getOpcodeName(), "sub") == 0){
          cout << "found sub!" << endl;
          no_of_sub++;
          sub_inst_arr.insert(I);
        }    

        Inst_List.insert(I);
      }
    }
    
    // for (int i = 0; i < no_of_gep; i++)
    // {
    //   for (int j = i+1; j < no_of_gep; j++)
    //   {
    //     gep_inst_arr[i]->dump();
    //     gep_inst_arr[j]->dump();
    //     cout << AA->alias(gep_inst_arr[i], LocationSize::precise(sizeof(int)*2), gep_inst_arr[j], LocationSize::precise(sizeof(int)*2)) << endl;
    //   }
      
    // }
    // exit(0);
    
    
    for(auto it: ::ptr_to_sub_mapping){
      // it.first->dump();
      cout << it.second.size() << endl;

      if(it.second.size() == 2){ //single sub inst is associated with 2 GEPS, check the alias() between these 2 GEPS

      switch (AA->alias(it.second[0], LocationSize::precise(sizeof(int)*10), it.second[1], LocationSize::precise(sizeof(int)*10))) {
  
          case 0: //NoAlias
              errs() <<  *it.second[0] << " is No alias of " << *it.second[1]<< "; " << "\n*************************\n";
              break;
          case 1: //MayAlias
              errs() << *it.second[0] << " is May alias of " <<  *it.second[1] << "; " << "\n*************************\n";
              break;
          case 2: //PartialAlias
              errs() << *it.second[0] << " is Partial alias of " <<  *it.second[1] << "; " << "\n*************************\n";
              break;
          case 3: //MustAlias
              errs() << *it.second[0] << " is Must alias of " <<  *it.second[1] << "; " << "\n*************************\n";
              break;
      }

      }
    }

    exit(0);
    

    
    

    
    
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
