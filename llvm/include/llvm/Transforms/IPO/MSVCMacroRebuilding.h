#ifndef LLVM_MSVC_MACRO_REBUILDING_PASS_H
#define LLVM_MSVC_MACRO_REBUILDING_PASS_H

#include "llvm/IR/PassManager.h"
#include <string>

namespace llvm {
// Forward declarations of classes used in the implementation of the pass.
class raw_ostream;
class Function;
class Module;
class GlobalVariable;
class ConstantDataArray;
class Pass;

class MSVCMacroRebuildingPass : public PassInfoMixin<MSVCMacroRebuildingPass> {

private:
  // Replace '__FUNCTION__'
  bool replace__FUNCTION__(GlobalVariable &GV, ConstantDataArray *CDA,
                           StringRef FunctionName);

public:
  MSVCMacroRebuildingPass() {}

  // Run the pass on the given module, and return the results as a set of
  // preserved analyses.
  PreservedAnalyses run(Module &M, AnalysisManager<Module> &);

  // Check whether this pass is required for correctness. This should always
  // return true.
  static bool isRequired() { return true; }

  // Return the name of marker for '__FUNCTION__'.
  static StringRef get__FUNCTION__MarkerName() {
    return "llvm_msvc__FUNCTION__E94550C93CD70FE748E6982B3439AD3B_";
  }
};

} // namespace llvm
#endif
