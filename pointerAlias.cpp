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

using namespace std;
using namespace llvm;

namespace {

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

  bool runOnFunction(Function &F) override {
    auto AA = &(getAnalysis<AAResultsWrapperPass>().getAAResults());
    auto &SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();
    // Add all pointers from M to the initial list of pointers
    SetVector<Instruction *> Inst_List;
    SetVector<Instruction *> gep_inst_arr;
    SetVector<Instruction *> ptrtoint_inst_arr;
    int no_of_gep = 0;
    int no_of_ptrtoint = 0;

    for (Function::iterator Fit = F.begin(), Fend = F.end(); Fit != Fend;
         ++Fit) {
      BasicBlock &BB = *Fit;

      for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end();
           BBit != BBend; ++BBit) {

        Instruction *I = &*BBit;

        if (strcmp(I->getOpcodeName(), "getelementptr") == 0){

          cout << "found GEP!" << endl;
          // auto scev_expression = SE.getSCEV(I);
          // string trythis = convert_scev_to_string(scev_expression);

          // cout << trythis << endl;
          no_of_gep++;
          gep_inst_arr.insert(I);
        }   
        if (strcmp(I->getOpcodeName(), "sub") == 0){
          cout << "found sub!" << endl;

          auto scev_expression = SE.getSCEV(I);
          string trythis = convert_scev_to_string(scev_expression);
          cout << trythis << endl;
          
          no_of_ptrtoint++;
          ptrtoint_inst_arr.insert(I);
        }    

        
        Inst_List.insert(I);
      }
    }
    // size_t  = Inst_List.size();

    cout << no_of_gep << endl;
    cout << no_of_ptrtoint << endl;

    exit(0);

    //compare nC2 gep instructions
    // for (int i = 0; i < no_of_gep; i++)
    // {
    //   for (int j = i; j < no_of_gep; j++)
    //   {
    //     if(i == j)
    //       continue;

    //     cout << i << " " << j << endl;

    //     switch (AA->alias(gep_inst_arr[i], LocationSize::precise(sizeof(int)*10), gep_inst_arr[j], LocationSize::precise(sizeof(int)*10))) {
  
    //       case 0: //NoAlias
    //           errs() << *gep_inst_arr[i] << " is No alias of " << *gep_inst_arr[j] << "; " << "\n*************************\n";
    //           break;
    //       case 1: //MayAlias
    //           errs() << *gep_inst_arr[i] << " is May alias of " << *gep_inst_arr[j] << "; " << "\n*************************\n";
    //           break;
    //       case 2: //PartialAlias
    //           errs() << *gep_inst_arr[i] << " is Partial alias of " << *gep_inst_arr[j] << "; " << "\n*************************\n";
    //           break;
    //       case 3: //MustAlias
    //           errs() << *gep_inst_arr[i] << " is Must alias of " << *gep_inst_arr[j] << "; " << "\n*************************\n";
    //           break;
    //       }
        
    //   }
      
    // }

    // compare nC2 gep instructions
    for (int i = 0; i < no_of_gep; i++)
    {
      for (int j = 0; j < no_of_ptrtoint; j++)
      {
        // if(i == j)
          // continue;

        // cout << i << " " << j << endl;

        switch (AA->alias(gep_inst_arr[i], LocationSize::precise(sizeof(int)*10), ptrtoint_inst_arr[j], LocationSize::precise(sizeof(int)*10))) {
  
          case 0: //NoAlias
              errs() << *gep_inst_arr[i] << " is No alias of " << *ptrtoint_inst_arr[j] << "; " << "\n*************************\n";
              break;
          case 1: //MayAlias
              errs() << *gep_inst_arr[i] << " is May alias of " << *ptrtoint_inst_arr[j] << "; " << "\n*************************\n";
              break;
          case 2: //PartialAlias
              errs() << *gep_inst_arr[i] << " is Partial alias of " << *ptrtoint_inst_arr[j] << "; " << "\n*************************\n";
              break;
          case 3: //MustAlias
              errs() << *gep_inst_arr[i] << " is Must alias of " << *ptrtoint_inst_arr[j] << "; " << "\n*************************\n";
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

        // auto P1 = (dyn_cast<Instruction>(I1))->getOperand(0);
        // auto P2 = (dyn_cast<Instruction>(I2))->getOperand(0);

        // cout << AA->alias(I1, I2) << endl;
        // cout << AA->isMustAlias(I1, I2) << endl;

        // cout << LocationSize::precise(64).getValue();
        // exit(0);
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

      // for (unsigned j = i + 1; j < n; ++j) {
      //     p[1] = Inst_List[j];
      //     switch (AA->alias(p[0], p[1])) {
      //     case MayAlias:
      //     case PartialAlias:
      //     case MustAlias:
      //         errs() << *p[0] << " is alias of " << *p[1]
      //                 << "; " << AA->alias(p[0], p[1]) << "\n";

      //         break;
      //     case NoAlias:
      //         break;
      //     }
      // }
    }

    return false;
  }
};
} // namespace

char pointerAlias::ID = 10;
static RegisterPass<pointerAlias> Y("pointerAlias", "pointerAlias pass ", false, false);
