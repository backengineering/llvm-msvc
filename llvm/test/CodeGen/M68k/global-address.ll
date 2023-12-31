; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=m68k < %s | FileCheck %s

@VBRTag = external dso_local global [2147483647 x i8]

define i1 @folded_offset(i32 %conv29) {
; CHECK-LABEL: folded_offset:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0: ; %entry
; CHECK-NEXT:    move.b (VBRTag+1,%pc), %d0
; CHECK-NEXT:    ext.w %d0
; CHECK-NEXT:    ext.l %d0
; CHECK-NEXT:    sub.l (4,%sp), %d0
; CHECK-NEXT:    seq %d0
; CHECK-NEXT:    rts
entry:
  %0 = load i8, ptr getelementptr inbounds ([2147483647 x i8], ptr @VBRTag, i32 0, i32 1), align 1
  %conv30 = sext i8 %0 to i32
  %cmp31.not = icmp eq i32 %conv30, %conv29
  ret i1 %cmp31.not
}

define i1 @non_folded_offset(i32 %conv29) {
; CHECK-LABEL: non_folded_offset:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0: ; %entry
; CHECK-NEXT:    move.l #2147483645, %d0
; CHECK-NEXT:    lea (VBRTag,%pc), %a0
; CHECK-NEXT:    move.b (0,%a0,%d0), %d0
; CHECK-NEXT:    ext.w %d0
; CHECK-NEXT:    ext.l %d0
; CHECK-NEXT:    sub.l (4,%sp), %d0
; CHECK-NEXT:    seq %d0
; CHECK-NEXT:    rts
entry:
  %0 = load i8, ptr getelementptr inbounds ([2147483647 x i8], ptr @VBRTag, i32 0, i32 2147483645), align 1
  %conv30 = sext i8 %0 to i32
  %cmp31.not = icmp eq i32 %conv30, %conv29
  ret i1 %cmp31.not
}
