; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck --check-prefixes=COMMON,SIMP %s
; RUN: opt -passes=constraint-elimination -constraint-elimination-max-rows=9 -S %s | FileCheck --check-prefixes=COMMON,SIMP %s
; RUN: opt -passes=constraint-elimination -constraint-elimination-max-rows=8 -S %s | FileCheck --check-prefixes=COMMON,NOSIMP %s


define i1 @test_max_row_limit(i32 %l0, i32 %l1, i32 %l2, i32 %l3, i32 %l4) {
; SIMP-LABEL: @test_max_row_limit(
; SIMP-NEXT:  bb0:
; SIMP-NEXT:    [[C0:%.*]] = icmp uge i32 [[L0:%.*]], 100
; SIMP-NEXT:    br i1 [[C0]], label [[BB1:%.*]], label [[EXIT:%.*]]
; SIMP:       bb1:
; SIMP-NEXT:    [[C1:%.*]] = icmp uge i32 [[L1:%.*]], 100
; SIMP-NEXT:    br i1 [[C1]], label [[BB2:%.*]], label [[EXIT]]
; SIMP:       bb2:
; SIMP-NEXT:    [[C2:%.*]] = icmp uge i32 [[L2:%.*]], 100
; SIMP-NEXT:    br i1 [[C2]], label [[BB3:%.*]], label [[EXIT]]
; SIMP:       bb3:
; SIMP-NEXT:    [[C3:%.*]] = icmp uge i32 [[L3:%.*]], 100
; SIMP-NEXT:    br i1 [[C3]], label [[BB4:%.*]], label [[EXIT]]
; SIMP:       bb4:
; SIMP-NEXT:    [[C4:%.*]] = icmp uge i32 [[L4:%.*]], 100
; SIMP-NEXT:    br i1 [[C4]], label [[BB5:%.*]], label [[EXIT]]
; SIMP:       bb5:
; SIMP-NEXT:    ret i1 true
; SIMP:       exit:
; SIMP-NEXT:    ret i1 false
;
; NOSIMP-LABEL: @test_max_row_limit(
; NOSIMP-NEXT:  bb0:
; NOSIMP-NEXT:    [[C0:%.*]] = icmp uge i32 [[L0:%.*]], 100
; NOSIMP-NEXT:    br i1 [[C0]], label [[BB1:%.*]], label [[EXIT:%.*]]
; NOSIMP:       bb1:
; NOSIMP-NEXT:    [[C1:%.*]] = icmp uge i32 [[L1:%.*]], 100
; NOSIMP-NEXT:    br i1 [[C1]], label [[BB2:%.*]], label [[EXIT]]
; NOSIMP:       bb2:
; NOSIMP-NEXT:    [[C2:%.*]] = icmp uge i32 [[L2:%.*]], 100
; NOSIMP-NEXT:    br i1 [[C2]], label [[BB3:%.*]], label [[EXIT]]
; NOSIMP:       bb3:
; NOSIMP-NEXT:    [[C3:%.*]] = icmp uge i32 [[L3:%.*]], 100
; NOSIMP-NEXT:    br i1 [[C3]], label [[BB4:%.*]], label [[EXIT]]
; NOSIMP:       bb4:
; NOSIMP-NEXT:    [[C4:%.*]] = icmp uge i32 [[L4:%.*]], 100
; NOSIMP-NEXT:    br i1 [[C4]], label [[BB5:%.*]], label [[EXIT]]
; NOSIMP:       bb5:
; NOSIMP-NEXT:    [[C5:%.*]] = icmp uge i32 [[L4]], 100
; NOSIMP-NEXT:    ret i1 [[C5]]
; NOSIMP:       exit:
; NOSIMP-NEXT:    ret i1 false
;
bb0:
  %c0 = icmp uge i32 %l0, 100
  br i1 %c0, label %bb1, label %exit

bb1:
  %c1 = icmp uge i32 %l1, 100
  br i1 %c1, label %bb2, label %exit

bb2:
  %c2 = icmp uge i32 %l2, 100
  br i1 %c2, label %bb3, label %exit

bb3:
  %c3 = icmp uge i32 %l3, 100
  br i1 %c3, label %bb4, label %exit

bb4:
  %c4 = icmp uge i32 %l4, 100
  br i1 %c4, label %bb5, label %exit

bb5:
  %c5 = icmp uge i32 %l4, 100
  ret i1 %c5

exit:
  ret i1 false
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; COMMON: {{.*}}
