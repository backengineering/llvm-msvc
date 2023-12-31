; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 | FileCheck %s --check-prefixes=CHECK,RV64I
; RUN: llc < %s -mtriple=riscv64 -mattr=+zba,+zbb | \
; RUN:   FileCheck %s --check-prefixes=CHECK,RV64ZB

; Make sure we emit an lw for the stack reload in 'truebb'.
define i1 @test_sext_w(i64 %x, i32 %y) nounwind {
; CHECK-LABEL: test_sext_w:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -128
; CHECK-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    beqz a0, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %falsebb
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    j .LBB0_3
; CHECK-NEXT:  .LBB0_2: # %truebb
; CHECK-NEXT:    lw a0, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    slti a0, a0, 0
; CHECK-NEXT:  .LBB0_3: # %falsebb
; CHECK-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 128
; CHECK-NEXT:    ret
  tail call void asm sideeffect "", "~{x1},~{x3},~{x4},~{x5},~{x6},~{x7},~{x8},~{x9},~{x10},~{x11},~{x12},~{x13},~{x14},~{x15},~{x16},~{x17},~{x18},~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{x29},~{x30},~{x31}"()
  %a = icmp eq i64 %x, 0
  br i1 %a, label %truebb, label %falsebb
truebb:
  %b = icmp slt i32 %y, 0
  ret i1 %b
falsebb:
  ret i1 0
}

; Make sure we emit an lb for the stack reload in 'truebb' with Zbb.
define i64 @test_sext_b(i64 %x, i8 %y) nounwind {
; RV64I-LABEL: test_sext_b:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -128
; RV64I-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    #APP
; RV64I-NEXT:    #NO_APP
; RV64I-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    beqz a0, .LBB1_2
; RV64I-NEXT:  # %bb.1: # %falsebb
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    j .LBB1_3
; RV64I-NEXT:  .LBB1_2: # %truebb
; RV64I-NEXT:    ld a0, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:  .LBB1_3: # %falsebb
; RV64I-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 128
; RV64I-NEXT:    ret
;
; RV64ZB-LABEL: test_sext_b:
; RV64ZB:       # %bb.0:
; RV64ZB-NEXT:    addi sp, sp, -128
; RV64ZB-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    #APP
; RV64ZB-NEXT:    #NO_APP
; RV64ZB-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    beqz a0, .LBB1_2
; RV64ZB-NEXT:  # %bb.1: # %falsebb
; RV64ZB-NEXT:    li a0, 0
; RV64ZB-NEXT:    j .LBB1_3
; RV64ZB-NEXT:  .LBB1_2: # %truebb
; RV64ZB-NEXT:    lb a0, 8(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:  .LBB1_3: # %falsebb
; RV64ZB-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    addi sp, sp, 128
; RV64ZB-NEXT:    ret
  tail call void asm sideeffect "", "~{x1},~{x3},~{x4},~{x5},~{x6},~{x7},~{x8},~{x9},~{x10},~{x11},~{x12},~{x13},~{x14},~{x15},~{x16},~{x17},~{x18},~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{x29},~{x30},~{x31}"()
  %a = icmp eq i64 %x, 0
  br i1 %a, label %truebb, label %falsebb
truebb:
  %b = sext i8 %y to i64
  ret i64 %b
falsebb:
  ret i64 0
}

; Make sure we emit an lh for the stack reload in 'truebb' with Zbb.
define i64 @test_sext_h(i64 %x, i16 %y) nounwind {
; RV64I-LABEL: test_sext_h:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -128
; RV64I-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    #APP
; RV64I-NEXT:    #NO_APP
; RV64I-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    beqz a0, .LBB2_2
; RV64I-NEXT:  # %bb.1: # %falsebb
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    j .LBB2_3
; RV64I-NEXT:  .LBB2_2: # %truebb
; RV64I-NEXT:    ld a0, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:  .LBB2_3: # %falsebb
; RV64I-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 128
; RV64I-NEXT:    ret
;
; RV64ZB-LABEL: test_sext_h:
; RV64ZB:       # %bb.0:
; RV64ZB-NEXT:    addi sp, sp, -128
; RV64ZB-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    #APP
; RV64ZB-NEXT:    #NO_APP
; RV64ZB-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    beqz a0, .LBB2_2
; RV64ZB-NEXT:  # %bb.1: # %falsebb
; RV64ZB-NEXT:    li a0, 0
; RV64ZB-NEXT:    j .LBB2_3
; RV64ZB-NEXT:  .LBB2_2: # %truebb
; RV64ZB-NEXT:    lh a0, 8(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:  .LBB2_3: # %falsebb
; RV64ZB-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    addi sp, sp, 128
; RV64ZB-NEXT:    ret
  tail call void asm sideeffect "", "~{x1},~{x3},~{x4},~{x5},~{x6},~{x7},~{x8},~{x9},~{x10},~{x11},~{x12},~{x13},~{x14},~{x15},~{x16},~{x17},~{x18},~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{x29},~{x30},~{x31}"()
  %a = icmp eq i64 %x, 0
  br i1 %a, label %truebb, label %falsebb
truebb:
  %b = sext i16 %y to i64
  ret i64 %b
falsebb:
  ret i64 0
}

; Make sure we emit an lbu for the stack reload in 'truebb' with Zbb.
define i64 @test_zext_b(i64 %x, i8 %y) nounwind {
; CHECK-LABEL: test_zext_b:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -128
; CHECK-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; CHECK-NEXT:    beqz a0, .LBB3_2
; CHECK-NEXT:  # %bb.1: # %falsebb
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    j .LBB3_3
; CHECK-NEXT:  .LBB3_2: # %truebb
; CHECK-NEXT:    lbu a0, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:  .LBB3_3: # %falsebb
; CHECK-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; CHECK-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 128
; CHECK-NEXT:    ret
  tail call void asm sideeffect "", "~{x1},~{x3},~{x4},~{x5},~{x6},~{x7},~{x8},~{x9},~{x10},~{x11},~{x12},~{x13},~{x14},~{x15},~{x16},~{x17},~{x18},~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{x29},~{x30},~{x31}"()
  %a = icmp eq i64 %x, 0
  br i1 %a, label %truebb, label %falsebb
truebb:
  %b = zext i8 %y to i64
  ret i64 %b
falsebb:
  ret i64 0
}

; Make sure we emit an lhu for the stack reload in 'truebb' with Zbb.
define i64 @test_zext_h(i64 %x, i16 %y) nounwind {
; RV64I-LABEL: test_zext_h:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -128
; RV64I-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    #APP
; RV64I-NEXT:    #NO_APP
; RV64I-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    beqz a0, .LBB4_2
; RV64I-NEXT:  # %bb.1: # %falsebb
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    j .LBB4_3
; RV64I-NEXT:  .LBB4_2: # %truebb
; RV64I-NEXT:    ld a0, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:  .LBB4_3: # %falsebb
; RV64I-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 128
; RV64I-NEXT:    ret
;
; RV64ZB-LABEL: test_zext_h:
; RV64ZB:       # %bb.0:
; RV64ZB-NEXT:    addi sp, sp, -128
; RV64ZB-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    #APP
; RV64ZB-NEXT:    #NO_APP
; RV64ZB-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    beqz a0, .LBB4_2
; RV64ZB-NEXT:  # %bb.1: # %falsebb
; RV64ZB-NEXT:    li a0, 0
; RV64ZB-NEXT:    j .LBB4_3
; RV64ZB-NEXT:  .LBB4_2: # %truebb
; RV64ZB-NEXT:    lhu a0, 8(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:  .LBB4_3: # %falsebb
; RV64ZB-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    addi sp, sp, 128
; RV64ZB-NEXT:    ret
  tail call void asm sideeffect "", "~{x1},~{x3},~{x4},~{x5},~{x6},~{x7},~{x8},~{x9},~{x10},~{x11},~{x12},~{x13},~{x14},~{x15},~{x16},~{x17},~{x18},~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{x29},~{x30},~{x31}"()
  %a = icmp eq i64 %x, 0
  br i1 %a, label %truebb, label %falsebb
truebb:
  %b = zext i16 %y to i64
  ret i64 %b
falsebb:
  ret i64 0
}

; Make sure we emit an lwu for the stack reload in 'truebb' with Zbb.
define i64 @test_zext_w(i64 %x, i32 %y) nounwind {
; RV64I-LABEL: test_zext_w:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -128
; RV64I-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    #APP
; RV64I-NEXT:    #NO_APP
; RV64I-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    beqz a0, .LBB5_2
; RV64I-NEXT:  # %bb.1: # %falsebb
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    j .LBB5_3
; RV64I-NEXT:  .LBB5_2: # %truebb
; RV64I-NEXT:    ld a0, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:  .LBB5_3: # %falsebb
; RV64I-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 128
; RV64I-NEXT:    ret
;
; RV64ZB-LABEL: test_zext_w:
; RV64ZB:       # %bb.0:
; RV64ZB-NEXT:    addi sp, sp, -128
; RV64ZB-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s1, 104(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s2, 96(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s3, 88(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s4, 80(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s5, 72(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s6, 64(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s7, 56(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s8, 48(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s9, 40(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s10, 32(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd s11, 24(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a1, 8(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    sd a0, 16(sp) # 8-byte Folded Spill
; RV64ZB-NEXT:    #APP
; RV64ZB-NEXT:    #NO_APP
; RV64ZB-NEXT:    ld a0, 16(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    beqz a0, .LBB5_2
; RV64ZB-NEXT:  # %bb.1: # %falsebb
; RV64ZB-NEXT:    li a0, 0
; RV64ZB-NEXT:    j .LBB5_3
; RV64ZB-NEXT:  .LBB5_2: # %truebb
; RV64ZB-NEXT:    lwu a0, 8(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:  .LBB5_3: # %falsebb
; RV64ZB-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s1, 104(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s2, 96(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s3, 88(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s4, 80(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s5, 72(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s6, 64(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s7, 56(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s8, 48(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s9, 40(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s10, 32(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    ld s11, 24(sp) # 8-byte Folded Reload
; RV64ZB-NEXT:    addi sp, sp, 128
; RV64ZB-NEXT:    ret
  tail call void asm sideeffect "", "~{x1},~{x3},~{x4},~{x5},~{x6},~{x7},~{x8},~{x9},~{x10},~{x11},~{x12},~{x13},~{x14},~{x15},~{x16},~{x17},~{x18},~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{x29},~{x30},~{x31}"()
  %a = icmp eq i64 %x, 0
  br i1 %a, label %truebb, label %falsebb
truebb:
  %b = zext i32 %y to i64
  ret i64 %b
falsebb:
  ret i64 0
}
