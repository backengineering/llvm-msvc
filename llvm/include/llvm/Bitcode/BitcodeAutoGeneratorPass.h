// This code defines the header file for a pass that generates LLVM bitcode
// automatically.
#ifndef LLVM_LIB_BITCODE_AUTO_GENERATOR_H
#define LLVM_LIB_BITCODE_AUTO_GENERATOR_H

#include "llvm/IR/PassManager.h"

namespace llvm {

// Generate and save LLVM IR bitcode files before the IR analysis
class BitcodeAutoGeneratorPrePass
    : public PassInfoMixin<BitcodeAutoGeneratorPrePass> {
  bool Enable;
  StringRef FolderName;

public:
  explicit BitcodeAutoGeneratorPrePass(bool Enable, StringRef FolderName)
      : Enable(Enable), FolderName(FolderName) {}

  // Run the pass and generate bitcode files
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &);

  static bool isRequired() { return true; }
};

// Generate and save LLVM IR bitcode files after the IR analysis
class BitcodeAutoGeneratorPostPass
    : public PassInfoMixin<BitcodeAutoGeneratorPostPass> {
  bool Enable;
  StringRef FolderName;

public:
  explicit BitcodeAutoGeneratorPostPass(bool Enable, StringRef FolderName)
      : Enable(Enable), FolderName(FolderName) {}

  // Run the pass and generate bitcode files
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &);

  static bool isRequired() { return true; }
};

} // namespace llvm

#endif
