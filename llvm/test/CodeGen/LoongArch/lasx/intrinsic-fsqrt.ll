; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <8 x float> @llvm.loongarch.lasx.xvfsqrt.s(<8 x float>)

define <8 x float> @lasx_xvfsqrt_s(<8 x float> %va) nounwind {
; CHECK-LABEL: lasx_xvfsqrt_s:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvfsqrt.s $xr0, $xr0
; CHECK-NEXT:    ret
entry:
  %res = call <8 x float> @llvm.loongarch.lasx.xvfsqrt.s(<8 x float> %va)
  ret <8 x float> %res
}

declare <4 x double> @llvm.loongarch.lasx.xvfsqrt.d(<4 x double>)

define <4 x double> @lasx_xvfsqrt_d(<4 x double> %va) nounwind {
; CHECK-LABEL: lasx_xvfsqrt_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvfsqrt.d $xr0, $xr0
; CHECK-NEXT:    ret
entry:
  %res = call <4 x double> @llvm.loongarch.lasx.xvfsqrt.d(<4 x double> %va)
  ret <4 x double> %res
}
