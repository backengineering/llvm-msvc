#include "llvm/Bitcode/BitcodeAutoGeneratorPass.h"
#include "llvm/Analysis/ModuleSummaryAnalysis.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IR/PassManager.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/ToolOutputFile.h"
#include <iostream>

using namespace llvm;

// Generate a bitcode file from the LLVM IR module M and save it to the
// specified FolderName directory
void autoGenerateBitCode(Module &M, StringRef FolderName) {

  // Get the current working directory
  SmallVector<char, 300> CurrentProjectDir;
  if (auto Error = sys::fs::current_path(CurrentProjectDir)) {
    report_fatal_error(Error.message().c_str());
    return;
  }

  // Append the target directory
  sys::path::append(CurrentProjectDir, FolderName);

  // Append the target triple directory
  sys::path::append(CurrentProjectDir, M.getTargetTriple());

  // Get the name of the source file and change its extension from .c/.cpp to
  // .bc
  auto SourceFileName = sys::path::relative_path(M.getSourceFileName());
  auto BCFileName = SourceFileName.substr(0, SourceFileName.rfind(".")) + ".bc";

  // Create the target directory if it does not exist
  auto CurrentProjectPath(CurrentProjectDir);
  sys::path::append(CurrentProjectPath, BCFileName);
  sys::path::native(CurrentProjectPath);
  std::string BCOutputFile(CurrentProjectPath.begin(),
                           CurrentProjectPath.end());
  if (auto Error = sys::fs::create_directories(
          sys::path::parent_path(BCOutputFile), true))
    report_fatal_error(Error.message().c_str());

  // Write the LLVM bitcode file to the output file
  std::error_code EC;
  sys::fs::OpenFlags OpenFlags = sys::fs::OF_None;
  std::unique_ptr<ToolOutputFile> Out =
      std::make_unique<ToolOutputFile>(BCOutputFile, EC, OpenFlags);
  if (EC)
    return;
  raw_pwrite_stream *OS = &Out->os();
  WriteBitcodeToFile(M, *OS);
  Out->keep();
}

// Implementation of the run() function for the BitcodeAutoGeneratorPrePass
// class
PreservedAnalyses BitcodeAutoGeneratorPrePass::run(Module &M,
                                                   ModuleAnalysisManager &AM) {
  if (Enable)
    autoGenerateBitCode(M, FolderName);

  // Return a PreservedAnalyses object that preserves all analysis results
  return PreservedAnalyses::all();
}

// Implementation of the run() function for the BitcodeAutoGeneratorPostPass
// class
PreservedAnalyses BitcodeAutoGeneratorPostPass::run(Module &M,
                                                    ModuleAnalysisManager &AM) {
  if (Enable)
    autoGenerateBitCode(M, FolderName);

  // Return a PreservedAnalyses object that preserves all analysis results
  return PreservedAnalyses::all();
}
