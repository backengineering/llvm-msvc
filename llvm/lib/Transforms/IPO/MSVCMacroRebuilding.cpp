#include "llvm/Transforms/IPO/MSVCMacroRebuilding.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Analysis/ModuleSummaryAnalysis.h"
#include "llvm/Demangle/Demangle.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PrintPasses.h"
#include "llvm/IRPrinter/IRAutoGeneratorPass.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"
#include <fstream>
#include <iostream>
#include <regex>

using namespace llvm;

// Implementation of the run() function for the MSVCMacroRebuildingPass
// class
PreservedAnalyses MSVCMacroRebuildingPass::run(Module &M,
                                               ModuleAnalysisManager &AM) {
  bool Changed = false;

  // Construct the regular expression used to match the
  // macro marker and the file name with escaped backslashes and line number.
  std::string RegexStr__FUNCTION__ =
      MSVCMacroRebuildingPass::get__FUNCTION__MarkerName().str() +
      std::regex_replace(M.getSourceFileName(), std::regex("\\\\"), "\\\\") +
      "\\(Line:\\d+\\)";

  // Iterate over all global variables in the input module.
  for (GlobalVariable &GV : M.globals()) {
    // Skip the variable if it does not have an initializer.
    if (!GV.hasInitializer())
      continue;

    // Check if the initializer is a constant data array of strings.
    ConstantDataArray *CDA = dyn_cast<ConstantDataArray>(GV.getInitializer());
    if (!CDA)
      continue;
    if (!CDA->isString())
      continue;

    // Get the original string value of the constant data array.
    std::string OriginalStr = CDA->getAsCString().str();
    if (OriginalStr.empty())
      continue;
    if (OriginalStr.length() < 20)
      continue;

    // Check the marker name.
    if (CDA->getAsCString().str().find(
            MSVCMacroRebuildingPass::get__FUNCTION__MarkerName().str()) ==
        std::string::npos)
      continue;

    // Iterate over all users of the global variable and check if it is an
    // instruction in a function.
    SmallVector<std::pair<Instruction *, unsigned int>, 32> Users;
    for (auto UserIt = GV.users().begin(); UserIt != GV.users().end();
         ++UserIt) {
      if (Instruction *I = dyn_cast<Instruction>(*UserIt)) {
        if (!I->getParent())
          continue;
        Function *F = I->getParent()->getParent();
        if (!F)
          continue;
        for (unsigned int OperandIndex = 0; OperandIndex < I->getNumOperands();
             OperandIndex++) {
          if (I->getOperand(OperandIndex) == &GV) {
            Users.push_back({I, OperandIndex});
            break;
          }
        }
      }
    }

    for (auto &Pair : Users) {
      Instruction *I = Pair.first;
      unsigned int OperandIndex = Pair.second;
      Function &F = *I->getParent()->getParent();

      // Replace '__FUNCTION__'
      std::string NewStr =
          std::regex_replace(OriginalStr, std::regex(RegexStr__FUNCTION__),
                             demangleGetFunctionName(F.getName()));

      if (NewStr.empty())
        continue;

      // Create a new GV to replace the old one.
      std::string NewGVName =
          MSVCMacroRebuildingPass::get__FUNCTION__MarkerName().str() + NewStr;
      GlobalVariable *NewGV = M.getNamedGlobal(NewGVName);
      if (!NewGV) {
        Constant *NewCDA = ConstantDataArray::getString(M.getContext(), NewStr);
        NewGV =
            new GlobalVariable(M, NewCDA->getType(), true,
                               GlobalValue::PrivateLinkage, NewCDA, NewGVName);
      }
      I->setOperand(OperandIndex, NewGV);
      Changed = true;
    }
  }

  /**
   * This statement returns a PreservedAnalyses object based on whether there
   * were any changes during the pass execution. If `Changed` is true,
   * indicating that changes occurred, it returns
   * `llvm::PreservedAnalyses::none()`. This means that some analyses may not be
   * preserved and should be re-run as the pass has potentially invalidated
   * their results. If `Changed` is false, indicating that no changes occurred,
   * it returns `llvm::PreservedAnalyses::all()`. This means that all analyses
   * are preserved and their results are still valid after the pass execution.
   */
  return (Changed ? llvm::PreservedAnalyses::none()
                  : llvm::PreservedAnalyses::all());
}
