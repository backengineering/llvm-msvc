; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <8 x i16> @llvm.loongarch.lsx.vmulwev.h.b(<16 x i8>, <16 x i8>)

define <8 x i16> @lsx_vmulwev_h_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_h_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.h.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vmulwev.h.b(<16 x i8> %va, <16 x i8> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vmulwev.w.h(<8 x i16>, <8 x i16>)

define <4 x i32> @lsx_vmulwev_w_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_w_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.w.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vmulwev.w.h(<8 x i16> %va, <8 x i16> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwev.d.w(<4 x i32>, <4 x i32>)

define <2 x i64> @lsx_vmulwev_d_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_d_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.d.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwev.d.w(<4 x i32> %va, <4 x i32> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwev.q.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vmulwev_q_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_q_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.q.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwev.q.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vmulwev.h.bu(<16 x i8>, <16 x i8>)

define <8 x i16> @lsx_vmulwev_h_bu(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_h_bu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.h.bu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vmulwev.h.bu(<16 x i8> %va, <16 x i8> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vmulwev.w.hu(<8 x i16>, <8 x i16>)

define <4 x i32> @lsx_vmulwev_w_hu(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_w_hu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.w.hu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vmulwev.w.hu(<8 x i16> %va, <8 x i16> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwev.d.wu(<4 x i32>, <4 x i32>)

define <2 x i64> @lsx_vmulwev_d_wu(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_d_wu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.d.wu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwev.d.wu(<4 x i32> %va, <4 x i32> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwev.q.du(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vmulwev_q_du(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_q_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.q.du $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwev.q.du(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vmulwev.h.bu.b(<16 x i8>, <16 x i8>)

define <8 x i16> @lsx_vmulwev_h_bu_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_h_bu_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.h.bu.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vmulwev.h.bu.b(<16 x i8> %va, <16 x i8> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vmulwev.w.hu.h(<8 x i16>, <8 x i16>)

define <4 x i32> @lsx_vmulwev_w_hu_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_w_hu_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.w.hu.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vmulwev.w.hu.h(<8 x i16> %va, <8 x i16> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwev.d.wu.w(<4 x i32>, <4 x i32>)

define <2 x i64> @lsx_vmulwev_d_wu_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_d_wu_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.d.wu.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwev.d.wu.w(<4 x i32> %va, <4 x i32> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwev.q.du.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vmulwev_q_du_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwev_q_du_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwev.q.du.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwev.q.du.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vmulwod.h.b(<16 x i8>, <16 x i8>)

define <8 x i16> @lsx_vmulwod_h_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_h_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.h.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vmulwod.h.b(<16 x i8> %va, <16 x i8> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vmulwod.w.h(<8 x i16>, <8 x i16>)

define <4 x i32> @lsx_vmulwod_w_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_w_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.w.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vmulwod.w.h(<8 x i16> %va, <8 x i16> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwod.d.w(<4 x i32>, <4 x i32>)

define <2 x i64> @lsx_vmulwod_d_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_d_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.d.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwod.d.w(<4 x i32> %va, <4 x i32> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwod.q.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vmulwod_q_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_q_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.q.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwod.q.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vmulwod.h.bu(<16 x i8>, <16 x i8>)

define <8 x i16> @lsx_vmulwod_h_bu(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_h_bu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.h.bu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vmulwod.h.bu(<16 x i8> %va, <16 x i8> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vmulwod.w.hu(<8 x i16>, <8 x i16>)

define <4 x i32> @lsx_vmulwod_w_hu(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_w_hu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.w.hu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vmulwod.w.hu(<8 x i16> %va, <8 x i16> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwod.d.wu(<4 x i32>, <4 x i32>)

define <2 x i64> @lsx_vmulwod_d_wu(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_d_wu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.d.wu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwod.d.wu(<4 x i32> %va, <4 x i32> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwod.q.du(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vmulwod_q_du(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_q_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.q.du $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwod.q.du(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vmulwod.h.bu.b(<16 x i8>, <16 x i8>)

define <8 x i16> @lsx_vmulwod_h_bu_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_h_bu_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.h.bu.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vmulwod.h.bu.b(<16 x i8> %va, <16 x i8> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vmulwod.w.hu.h(<8 x i16>, <8 x i16>)

define <4 x i32> @lsx_vmulwod_w_hu_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_w_hu_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.w.hu.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vmulwod.w.hu.h(<8 x i16> %va, <8 x i16> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwod.d.wu.w(<4 x i32>, <4 x i32>)

define <2 x i64> @lsx_vmulwod_d_wu_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_d_wu_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.d.wu.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwod.d.wu.w(<4 x i32> %va, <4 x i32> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vmulwod.q.du.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vmulwod_q_du_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vmulwod_q_du_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulwod.q.du.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vmulwod.q.du.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}
