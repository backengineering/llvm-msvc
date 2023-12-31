; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -o - -verify-machineinstrs -global-isel=1 -global-isel-abort=1 | FileCheck %s --check-prefixes=CHECK,GISEL
; RUN: llc < %s -o - -verify-machineinstrs -global-isel=0 | FileCheck %s --check-prefixes=CHECK,SDAG

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-ios14.5.0"

define i32 @bfi_w_31(i32 %in1, i32 %in2) {
; CHECK-LABEL: bfi_w_31:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi w1, w0, #31, #1
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i32 %in1, 31
  %tmp4 = and i32 %in2, 2147483647
  %out = or i32 %tmp3, %tmp4
  ret i32 %out
}

define i32 @bfi_w_8(i32 %in1, i32 %in2) {
; CHECK-LABEL: bfi_w_8:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi w1, w0, #8, #24
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i32 %in1, 8
  %tmp4 = and i32 %in2, 255
  %out = or i32 %tmp3, %tmp4
  ret i32 %out
}

define i32 @bfi_w_1(i32 %in1, i32 %in2) {
; CHECK-LABEL: bfi_w_1:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi w1, w0, #1, #31
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i32 %in1, 1
  %tmp4 = and i32 %in2, 1
  %out = or i32 %tmp3, %tmp4
  ret i32 %out
}

define i64 @bfi_x_63(i64 %in1, i64 %in2) {
; CHECK-LABEL: bfi_x_63:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi x1, x0, #63, #1
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 63
  %tmp4 = and i64 %in2, 9223372036854775807
  %out = or i64 %tmp3, %tmp4
  ret i64 %out
}

define i64 @bfi_x_31(i64 %in1, i64 %in2) {
; CHECK-LABEL: bfi_x_31:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi x1, x0, #31, #33
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 31
  %tmp4 = and i64 %in2, 2147483647
  %out = or i64 %tmp3, %tmp4
  ret i64 %out
}

define i64 @bfi_x_8(i64 %in1, i64 %in2) {
; CHECK-LABEL: bfi_x_8:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi x1, x0, #8, #56
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 8
  %tmp4 = and i64 %in2, 255
  %out = or i64 %tmp3, %tmp4
  ret i64 %out
}

define i64 @bfi_x_1(i64 %in1, i64 %in2) {
; CHECK-LABEL: bfi_x_1:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi x1, x0, #1, #63
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 1
  %tmp4 = and i64 %in2, 1
  %out = or i64 %tmp3, %tmp4
  ret i64 %out
}

define i64 @bfi_x_1_swapped(i64 %in1, i64 %in2) {
; CHECK-LABEL: bfi_x_1_swapped:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    bfi x1, x0, #1, #63
; CHECK-NEXT:    mov x0, x1
; CHECK-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 1
  %tmp4 = and i64 %in2, 1
  %out = or i64 %tmp4, %tmp3
  ret i64 %out
}

define i64 @extra_use1(i64 %in1, i64 %in2, ptr %p) {
; GISEL-LABEL: extra_use1:
; GISEL:       ; %bb.0: ; %bb
; GISEL-NEXT:    lsl x8, x0, #1
; GISEL-NEXT:    and x9, x1, #0x1
; GISEL-NEXT:    orr x0, x8, x9
; GISEL-NEXT:    str x8, [x2]
; GISEL-NEXT:    ret
;
; SDAG-LABEL: extra_use1:
; SDAG:       ; %bb.0: ; %bb
; SDAG-NEXT:    bfi x1, x0, #1, #63
; SDAG-NEXT:    lsl x8, x0, #1
; SDAG-NEXT:    mov x0, x1
; SDAG-NEXT:    str x8, [x2]
; SDAG-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 1
  %tmp4 = and i64 %in2, 1
  %out = or i64 %tmp3, %tmp4
  store i64 %tmp3, ptr %p
  ret i64 %out
}

define i64 @extra_use2(i64 %in1, i64 %in2, ptr %p) {
; GISEL-LABEL: extra_use2:
; GISEL:       ; %bb.0: ; %bb
; GISEL-NEXT:    and x8, x1, #0x1
; GISEL-NEXT:    orr x0, x8, x0, lsl #1
; GISEL-NEXT:    str x8, [x2]
; GISEL-NEXT:    ret
;
; SDAG-LABEL: extra_use2:
; SDAG:       ; %bb.0: ; %bb
; SDAG-NEXT:    and x8, x1, #0x1
; SDAG-NEXT:    bfi x1, x0, #1, #63
; SDAG-NEXT:    str x8, [x2]
; SDAG-NEXT:    mov x0, x1
; SDAG-NEXT:    ret
bb:
  %tmp3 = shl i64 %in1, 1
  %tmp4 = and i64 %in2, 1
  %out = or i64 %tmp3, %tmp4
  store i64 %tmp4, ptr %p
  ret i64 %out
}
