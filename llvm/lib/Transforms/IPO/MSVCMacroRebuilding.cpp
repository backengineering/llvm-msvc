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

// Replace '__FUNCTION__'
bool MSVCMacroRebuildingPass::replace__FUNCTION__(std::string &RegexStr,
                                                  GlobalVariable &GV,
                                                  ConstantDataArray *CDA,
                                                  StringRef FunctionName) {

  // Get the original string value of the constant data array.
  std::string OriginalStr = CDA->getAsCString().str();
  // Replace the macro marker and file name in the original string with
  // the name of the function containing the instruction.
  std::string ReplacedStr =
      std::regex_replace(OriginalStr, std::regex(RegexStr), FunctionName.str());

  // If the replaced string is the same as the original string, skip the
  // variable.
  if (ReplacedStr == OriginalStr)
    return false;

  // Demangle the replaced string and extract the function name.
  std::string DemangledReplacedStr = demangle(ReplacedStr);
  size_t StartIndex = DemangledReplacedStr.find("(");
  if (StartIndex != std::string::npos) {
    size_t EndIndex = DemangledReplacedStr.rfind(" ", StartIndex);
    if (EndIndex != std::string::npos) {
      DemangledReplacedStr =
          DemangledReplacedStr.substr(EndIndex + 1, StartIndex - EndIndex - 1);
    }
  }

  // Create a new constant data array containing the demangled function
  // name and set it as the initializer of the global variable.
  Constant *NewStr = ConstantDataArray::getString(GV.getParent()->getContext(),
                                                  DemangledReplacedStr);
  GV.setInitializer(NewStr);

  return true;
}

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
    if (ConstantDataArray *CDA =
            dyn_cast<ConstantDataArray>(GV.getInitializer())) {
      if (!CDA->isString())
        continue;

      // Iterate over all users of the global variable and check if it is an
      // instruction in a function.
      for (auto UserIt = GV.users().begin(); UserIt != GV.users().end();
           ++UserIt) {
        if (Instruction *I = dyn_cast<Instruction>(*UserIt)) {
          if (!I->getParent())
            continue;

          Function *F = I->getParent()->getParent();
          if (!F)
            continue;

          // Replace '__FUNCTION__'
          Changed |=
              replace__FUNCTION__(RegexStr__FUNCTION__, GV, CDA, F->getName());
        }
      }
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
