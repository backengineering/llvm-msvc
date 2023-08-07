#ifndef LLVM_WELCOME_TO_LLVM_MSVC_PASS_H
#define LLVM_WELCOME_TO_LLVM_MSVC_PASS_H

#include "llvm/IR/PassManager.h"
#include <string>

namespace llvm {
// Forward declarations of classes used in the implementation of the pass.
class raw_ostream;
class Function;
class Module;
class Pass;

class WelcomeToLLVMMSVCPass : public PassInfoMixin<WelcomeToLLVMMSVCPass> {
  bool Enable;

public:
  WelcomeToLLVMMSVCPass(bool Enable) : Enable(Enable) {}

  // Run the pass on the given module, and return the results as a set of
  // preserved analyses.
  PreservedAnalyses run(Module &M, AnalysisManager<Module> &);

  // Check whether this pass is required for correctness. This should always
  // return true.
  static bool isRequired() { return true; }

  // Return the name of marker global variable.
  static StringRef getMarkerGVName() {
    return "llvm_msvc_marker_GV_fae0b27c451c728867a567e8c1bb4e53";
  }
};

} // namespace llvm
#endif
