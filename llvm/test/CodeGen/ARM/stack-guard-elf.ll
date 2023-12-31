; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
;; direct-access-external-data is false due to PIC Level, so __stack_chk_guard
;; is dso_preemtable. Check that we use GOT PIC code sequence as well because
;; R_ARM_GOT_ABS does not have assembler support.
; RUN: llc -relocation-model=static < %s | FileCheck %s
; RUN: llc -relocation-model=pic < %s | FileCheck %s

target triple = "armv7a-linux-gnueabi"

define i32 @test1() #0 {
; CHECK-LABEL: test1:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    sub sp, sp, #8
; CHECK-NEXT:    sub sp, sp, #1024
; CHECK-NEXT:    ldr r0, .LCPI0_0
; CHECK-NEXT:  .LPC0_0:
; CHECK-NEXT:    add r0, pc, r0
; CHECK-NEXT:    ldr r0, [r0]
; CHECK-NEXT:    ldr r0, [r0]
; CHECK-NEXT:    str r0, [sp, #1028]
; CHECK-NEXT:    add r0, sp, #4
; CHECK-NEXT:    bl foo
; CHECK-NEXT:    ldr r0, [sp, #1028]
; CHECK-NEXT:    ldr r1, .LCPI0_1
; CHECK-NEXT:  .LPC0_1:
; CHECK-NEXT:    add r1, pc, r1
; CHECK-NEXT:    ldr r1, [r1]
; CHECK-NEXT:    ldr r1, [r1]
; CHECK-NEXT:    cmp r1, r0
; CHECK-NEXT:    moveq r0, #0
; CHECK-NEXT:    addeq sp, sp, #8
; CHECK-NEXT:    addeq sp, sp, #1024
; CHECK-NEXT:    popeq {r11, pc}
; CHECK-NEXT:  .LBB0_1:
; CHECK-NEXT:    bl __stack_chk_fail
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:  .LCPI0_0:
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    .long __stack_chk_guard(GOT_PREL)-((.LPC0_0+8)-.Ltmp0)
; CHECK-NEXT:  .LCPI0_1:
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:    .long __stack_chk_guard(GOT_PREL)-((.LPC0_1+8)-.Ltmp1)
  %a1 = alloca [256 x i32], align 4
  call void @foo(ptr %a1) #3
  ret i32 0
}

declare void @foo(ptr)

attributes #0 = { nounwind sspstrong }

!llvm.module.flags = !{!0}
!0 = !{i32 8, !"PIC Level", i32 2}
