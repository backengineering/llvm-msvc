; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zkne -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZKNE

declare i32 @llvm.riscv.aes32esi(i32, i32, i32);

define i32 @aes32esi(i32 %a, i32 %b) nounwind {
; RV32ZKNE-LABEL: aes32esi:
; RV32ZKNE:       # %bb.0:
; RV32ZKNE-NEXT:    aes32esi a0, a0, a1, 2
; RV32ZKNE-NEXT:    ret
    %val = call i32 @llvm.riscv.aes32esi(i32 %a, i32 %b, i32 2)
    ret i32 %val
}

declare i32 @llvm.riscv.aes32esmi(i32, i32, i32);

define i32 @aes32esmi(i32 %a, i32 %b) nounwind {
; RV32ZKNE-LABEL: aes32esmi:
; RV32ZKNE:       # %bb.0:
; RV32ZKNE-NEXT:    aes32esmi a0, a0, a1, 3
; RV32ZKNE-NEXT:    ret
    %val = call i32 @llvm.riscv.aes32esmi(i32 %a, i32 %b, i32 3)
    ret i32 %val
}
