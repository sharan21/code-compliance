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

using namespace llvm;

namespace {

struct pointerAlias : public FunctionPass {
  static char ID;

  pointerAlias() : FunctionPass(ID) {}

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<AAResultsWrapperPass>();
    AU.setPreservesAll();
  }

  bool runOnFunction(Function &F) override {
    auto AA = &(getAnalysis<AAResultsWrapperPass>().getAAResults());

    // Add all pointers from M to the initial list of pointers
    SetVector<Value *> initial_list_pointers;

    errs() << "Hello!" << "\n";

    for (Function::iterator Fit = F.begin(), Fit != F.end(); ++Fit) {
      BasicBlock &BB = *Fit;

      for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end();
           BBit != BBend; ++BBit) {
        Instruction *I = &*BBit;
        initial_list_pointers.insert(I);
      }
    }

    size_t n = initial_list_pointers.size();

    Value *p[2];

    for (unsigned i = 0; i < n; ++i) {
      p[0] = initial_list_pointers[i];

      for (unsigned j = i + 1; j < n; ++j) {
        p[1] = initial_list_pointers[j];
        switch (AA->alias(p[0], p[1])) {
        case MayAlias:
        case PartialAlias:
        case MustAlias:
          errs() << p[0]->getName() << " is alias of " << p[1]->getName() << "; " << AA->alias(p[0], p[1]) << "\n";

          break;
        case NoAlias:
          break;
        }
      }
    }

    return false;
  }
};
} // namespace

char pointerAlias::ID = 10;
static RegisterPass<pointerAlias> Y("pointerAlias", "pointerAlias pass ", false,
                                    false);
