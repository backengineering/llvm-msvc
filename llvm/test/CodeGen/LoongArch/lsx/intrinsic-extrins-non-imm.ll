; RUN: not llc --mtriple=loongarch64 --mattr=+lsx < %s 2>&1 | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vextrins.b(<16 x i8>, <16 x i8>, i32)

define <16 x i8> @lsx_vextrins_b(<16 x i8> %va, <16 x i8> %vb, i32 %c) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vextrins.b(<16 x i8> %va, <16 x i8> %vb, i32 %c)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vextrins.h(<8 x i16>, <8 x i16>, i32)

define <8 x i16> @lsx_vextrins_h(<8 x i16> %va, <8 x i16> %vb, i32 %c) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vextrins.h(<8 x i16> %va, <8 x i16> %vb, i32 %c)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vextrins.w(<4 x i32>, <4 x i32>, i32)

define <4 x i32> @lsx_vextrins_w(<4 x i32> %va, <4 x i32> %vb, i32 %c) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vextrins.w(<4 x i32> %va, <4 x i32> %vb, i32 %c)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vextrins.d(<2 x i64>, <2 x i64>, i32)

define <2 x i64> @lsx_vextrins_d(<2 x i64> %va, <2 x i64> %vb, i32 %c) nounwind {
; CHECK: immarg operand has non-immediate parameter
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vextrins.d(<2 x i64> %va, <2 x i64> %vb, i32 %c)
  ret <2 x i64> %res
}
