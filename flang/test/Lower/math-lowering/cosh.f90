! RUN: bbc -emit-fir %s -o - --math-runtime=fast | FileCheck --check-prefixes=ALL %s
! RUN: %flang_fc1 -emit-fir -mllvm -math-runtime=fast %s -o - | FileCheck --check-prefixes=ALL %s
! RUN: bbc -emit-fir %s -o - --math-runtime=relaxed | FileCheck --check-prefixes=ALL %s
! RUN: %flang_fc1 -emit-fir -mllvm -math-runtime=relaxed %s -o - | FileCheck --check-prefixes=ALL %s
! RUN: bbc -emit-fir %s -o - --math-runtime=precise | FileCheck --check-prefixes=ALL %s
! RUN: %flang_fc1 -emit-fir -mllvm -math-runtime=precise %s -o - | FileCheck --check-prefixes=ALL %s

function test_real4(x)
  real :: x, test_real4
  test_real4 = cosh(x)
end function

! ALL-LABEL: @_QPtest_real4
! ALL: {{%[A-Za-z0-9._]+}} = fir.call @coshf({{%[A-Za-z0-9._]+}}) {{.*}}: (f32) -> f32

function test_real8(x)
  real(8) :: x, test_real8
  test_real8 = cosh(x)
end function

! ALL-LABEL: @_QPtest_real8
! ALL: {{%[A-Za-z0-9._]+}} = fir.call @cosh({{%[A-Za-z0-9._]+}}) {{.*}}: (f64) -> f64

! ALL-DAG: func.func private @coshf(f32) -> f32 attributes {fir.bindc_name = "coshf", fir.runtime}
! ALL-DAG: func.func private @cosh(f64) -> f64 attributes {fir.bindc_name = "cosh", fir.runtime}
