#include "llvm/IR/Constants.h"
#include "llvm/ADT/IntEqClasses.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/CallSite.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/CommandLine.h"

using namespace llvm;

namespace {

    struct aliasset : public FunctionPass {
        static char ID;

        aliasset() : FunctionPass(ID) {}

        // void getAnalysisUsage(AnalysisUsage &AU) const override {
        //     AU.addRequired<AAResultsWrapperPass>();
        //     AU.setPreservesAll();
        // }

        bool runOnFunction(Function &F) override {
            //auto AA = &(getAnalysis<AAResultsWrapperPass>().getAAResults());
            // Add all pointers from M to the initial list of pointers
            SetVector<Instruction *> Inst_List;

            for (Function::iterator Fit = F.begin(), Fend = F.end(); Fit != Fend; ++Fit) {
                BasicBlock &BB = *Fit;

                for (BasicBlock::iterator BBit = BB.begin(), BBend = BB.end(); BBit != BBend; ++BBit) {
                    Instruction *I = &*BBit;
                    Inst_List.insert(I);
                }
            }


            size_t n = Inst_List.size();

            for (unsigned i = 0; i < n; ++i) {
                auto Inst = Inst_List[i];

                if(Inst->getOpcodeName()[2]=='b' && Inst->getOpcodeName()[1]=='u'){
                    errs() << *Inst << "\n";
                    //I1 - I2
                    auto I1 = dyn_cast<Instruction>(Inst->getOperand(0));
                    auto I2 = dyn_cast<Instruction>(Inst->getOperand(1));


                    auto op1 = I1, op2 = I2;
                    while(op1 && (op1->getOpcodeName()[0]!='a' || op1->getOpcodeName()[1]!='l')) {
                        if(op1->getOpcodeName()[0]=='g' && op1->getOpcodeName()[3]=='e')
                            break;
                        op1 = dyn_cast<Instruction>(op1->getOperand(0));
                    }
                    while(op2 && (op2->getOpcodeName()[0]!='a' || op2->getOpcodeName()[1]!='l')) {
                        if(op2->getOpcodeName()[0]=='g' && op2->getOpcodeName()[3]=='e')
                            break;
                        op2 = dyn_cast<Instruction>((op2)->getOperand(0));
                    }

                    auto gep1 = I1, gep2 = I2;
                    I1 = dyn_cast<Instruction>(dyn_cast<Instruction>(I1->getOperand(0)));
                    I2 = dyn_cast<Instruction>(dyn_cast<Instruction>(I2->getOperand(0)));
                    //errs() << "*********   " << *I1 << "     ********\n";
                    //errs() << "*********   " << *I2 << "     ********\n";

                    if(op1->getOpcodeName()[0]!='g' || op1->getOpcodeName()[3]!='e') {
                        bool flag = false;
                        for (User *U : (dyn_cast<Value>(op1))->users()) {
                            if (Instruction *Inst = dyn_cast<Instruction>(U)) {
                                if(Inst == I1) {
                                    flag = true;
                                }
                                if(flag && Inst->getOpcodeName()[0]=='s' && Inst->getOpcodeName()[1]=='t') {
                                //errs() << "op1 is used in instruction:\n";
                                    gep1 = dyn_cast<Instruction>(Inst->getOperand(0));
                                    while(1) {
                                        auto buff = dyn_cast<Instruction>(gep1->getOperand(0));
                                        if(buff->getOpcodeName()[0]=='g' && buff->getOpcodeName()[2]=='t')
                                            gep1 = buff;
                                        else
                                            break;
                                    }
                                    break;
                                }
                            }
                        }
                    }
                    else {
                        gep1 = op1;
                    }

                    if(op2->getOpcodeName()[0]!='g' || op2->getOpcodeName()[3]!='e') {
                        bool flag = false;
                        for (User *U : (dyn_cast<Value>(op2))->users()) {
                            if (Instruction *Inst = dyn_cast<Instruction>(U)) {
                                if(Inst == I2) {
                                    flag = true;
                                }
                                if(flag && Inst->getOpcodeName()[0]=='s' && Inst->getOpcodeName()[1]=='t') {
                                //errs() << "op1 is used in instruction:\n";
                                    gep2 = dyn_cast<Instruction>(Inst->getOperand(0));
                                    while(1) {
                                        auto buff = dyn_cast<Instruction>(gep2->getOperand(0));
                                        if(buff->getOpcodeName()[0]=='g' && buff->getOpcodeName()[2]=='t')
                                            gep2 = buff;
                                        else
                                            break;
                                    }
                                    break;
                                }
                            }
                        }
                    }
                    else {
                        gep2 = op2;
                    }
                    errs() << *gep1 << "\n" << *gep2 << "\n**********************\n";

                    if(gep1->getOperand(0) == gep2->getOperand(0)) {
                        errs() << "This is OK!\n";
                    }
                    else
                        errs() << "This is NOT OK!\n";
                    
                    
                    //auto I1 = (dyn_cast<Instruction>(P1))->getOperand(0);
                    //auto I2 = (dyn_cast<Instruction>(P2))->getOperand(0);

                    
                    // errs() << *gep1 << " is alias of " << *gep2 << ";\n";
                    // switch (AA->alias(gep1, gep2)) {
                    //     case MayAlias:
                    //     case PartialAlias:
                    //     case MustAlias:
                    //         errs() << *gep1 << " is alias of " << *gep2
                    //                 << "; " << AA->alias(gep1, gep2)
                    //                  << "\n*************************\n";

                    //         break;
                    //     case NoAlias:
                    //         break;
                    // }

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
}

char aliasset::ID = 10;
static RegisterPass<aliasset> Y("myalias", "Alias Set pass ", false, false);
