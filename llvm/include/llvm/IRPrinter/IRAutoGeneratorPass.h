// This code defines the header file for a pass that generates LLVM IR
// automatically.
#ifndef LLVM_IR_AUTO_GENERATOR_PASS_H
#define LLVM_IR_AUTO_GENERATOR_PASS_H

#include "llvm/IR/PassManager.h"
#include <string>

namespace llvm {
// Forward declarations of classes used in the implementation of the pass.
class raw_ostream;
class Function;
class Module;
class Pass;

// This class defines a pre-pass that generates LLVM IR automatically based on
// the input.
class IRAutoGeneratorPrePass : public PassInfoMixin<IRAutoGeneratorPrePass> {
  bool Enable;
  StringRef FolderName;

public:
  explicit IRAutoGeneratorPrePass(bool Enable, StringRef FolderName)
      : Enable(Enable), FolderName(FolderName) {}

  // Run the pass on the given module, and return the results as a set of
  // preserved analyses.
  PreservedAnalyses run(Module &M, AnalysisManager<Module> &);

  // Check whether this pass is required for correctness. This should always
  // return true.
  static bool isRequired() { return true; }
};

// This class defines a post-pass that generates LLVM IR automatically based on
// the input.
class IRAutoGeneratorPostPass : public PassInfoMixin<IRAutoGeneratorPostPass> {
  bool Enable;
  StringRef FolderName;

public:
  explicit IRAutoGeneratorPostPass(bool Enable, StringRef FolderName)
      : Enable(Enable), FolderName(FolderName) {}

  // Run the pass on the given module, and return the results as a set of
  // preserved analyses.
  PreservedAnalyses run(Module &M, AnalysisManager<Module> &);

  // Check whether this pass is required for correctness. This should always
  // return true.
  static bool isRequired() { return true; }
};
} // namespace llvm

#endif