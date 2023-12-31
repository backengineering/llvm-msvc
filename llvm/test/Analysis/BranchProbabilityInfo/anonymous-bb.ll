; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -passes='print<branch-prob>' -disable-output 2>&1 | FileCheck %s

define void @fct() {
; CHECK-LABEL: 'fct'
; CHECK-NEXT:  ---- Branch Probabilities ----
; CHECK-NEXT:    edge %entry -> %0 probability is 0x80000000 / 0x80000000 = 100.00% [HOT edge]
; CHECK-NEXT:    edge %0 -> %1 probability is 0x80000000 / 0x80000000 = 100.00% [HOT edge]
;
entry:
  br label %0
0:
  br label %1
1:
  ret void
}

define void @fct2() {
; CHECK-LABEL: 'fct2'
; CHECK-NEXT:  ---- Branch Probabilities ----
; CHECK-NEXT:    edge %0 -> %1 probability is 0x80000000 / 0x80000000 = 100.00% [HOT edge]
; CHECK-NEXT:    edge %1 -> %2 probability is 0x80000000 / 0x80000000 = 100.00% [HOT edge]
;
  br label %1
1:
  br label %2
2:
  ret void
}
