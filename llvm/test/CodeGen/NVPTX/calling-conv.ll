; RUN: llc < %s -march=nvptx -mcpu=sm_20 | FileCheck %s
; RUN: llc < %s -march=nvptx64 -mcpu=sm_20 | FileCheck %s
; RUN: %if ptxas && !ptxas-12.0 %{ llc < %s -march=nvptx -mcpu=sm_20 | %ptxas-verify %}
; RUN: %if ptxas %{ llc < %s -march=nvptx64 -mcpu=sm_20 | %ptxas-verify %}


;; Kernel function using ptx_kernel calling conv

; CHECK: .entry kernel_func
define ptx_kernel void @kernel_func(ptr %a) {
; CHECK: ret
  ret void
}

;; Device function
; CHECK: .func device_func
define void @device_func(ptr %a) {
; CHECK: ret
  ret void
}

;; Kernel function using NVVM metadata
; CHECK: .entry metadata_kernel
define void @metadata_kernel(ptr %a) {
; CHECK: ret
  ret void
}


!nvvm.annotations = !{!1}

!1 = !{ptr @metadata_kernel, !"kernel", i32 1}
