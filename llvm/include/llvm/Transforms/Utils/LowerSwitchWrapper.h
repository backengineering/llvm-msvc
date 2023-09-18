#ifndef LLVM_TRANSFORMS_UTILS_LOWERSWITCH_WRAPPER_H
#define LLVM_TRANSFORMS_UTILS_LOWERSWITCH_WRAPPER_H

namespace llvm {
class FunctionPass;
FunctionPass *createLowerSwitchWrapperPass();
} // namespace llvm

#endif
