# REQUIRES: x86
# RUN: rm -rf %t; split-file %s %t

## Check that we fold identical function bodies correctly. Note: This test
## has many different functions; each group of similarly-named functions aim
## to test one aspect of ICF's logic. To prevent accidental folding across
## groups, we use `mov` instructions with a variety of immediates, with
## different immediate values for each group.

# RUN: llvm-mc -emit-compact-unwind-non-canonical=true -filetype=obj -triple=x86_64-apple-darwin19.0.0 %t/main.s -o %t/main.o
# RUN: llvm-mc -emit-compact-unwind-non-canonical=true -filetype=obj -triple=x86_64-apple-darwin19.0.0 %t/abs.s -o %t/abs.o
# RUN: %lld -lSystem --icf=all -o %t/main %t/main.o %t/abs.o
# RUN: llvm-objdump -d --syms --dwarf=frames %t/main | FileCheck %s

# CHECK-LABEL: SYMBOL TABLE:
# CHECK: [[#%x,ABS1B_REF:]]                 l     F __TEXT,__text _abs1a_ref
# CHECK: [[#%x,ABS1B_REF]]                  l     F __TEXT,__text _abs1b_ref
# CHECK: [[#%x,ABS1B_REF_WITH_ADDEND:]]     l     F __TEXT,__text _abs1a_ref_with_addend
# CHECK: [[#%x,ABS1B_REF_WITH_ADDEND]]      l     F __TEXT,__text _abs1b_ref_with_addend
# CHECK: [[#%x,ABS2_REF:]]                  l     F __TEXT,__text _abs2_ref
# CHECK: [[#%x,NOT_ABS_REF:]]               l     F __TEXT,__text _not_abs_ref
# CHECK: [[#%x,DYLIB_REF_2:]]               l     F __TEXT,__text _dylib_ref_1
# CHECK: [[#%x,DYLIB_REF_2]]                l     F __TEXT,__text _dylib_ref_2
# CHECK: [[#%x,DYLIB_REF_3:]]               l     F __TEXT,__text _dylib_ref_3
# CHECK: [[#%x,DYLIB_REF_4:]]               l     F __TEXT,__text _dylib_ref_4
# CHECK: [[#%x,ALT:]]                       l     F __TEXT,__text _alt
# CHECK: [[#%x,WITH_ALT_ENTRY:]]            l     F __TEXT,__text _with_alt_entry
# CHECK: [[#%x,NO_ALT_ENTRY:]]              l     F __TEXT,__text _no_alt_entry
# CHECK: [[#%x,DEFINED_REF_WITH_ADDEND_2:]] l     F __TEXT,__text _defined_ref_with_addend_1
# CHECK: [[#%x,DEFINED_REF_WITH_ADDEND_2]]  l     F __TEXT,__text _defined_ref_with_addend_2
# CHECK: [[#%x,DEFINED_REF_WITH_ADDEND_3:]] l     F __TEXT,__text _defined_ref_with_addend_3
# CHECK: [[#%x,RECURSIVE:]]                 l     F __TEXT,__text _recursive
# CHECK: [[#%x,CALL_RECURSIVE_2:]]          l     F __TEXT,__text _call_recursive_1
# CHECK: [[#%x,CALL_RECURSIVE_2]]           l     F __TEXT,__text _call_recursive_2
# CHECK: [[#%x,CHECK_LENGTH_1:]]            l     F __TEXT,__text _check_length_1
# CHECK: [[#%x,CHECK_LENGTH_2:]]            l     F __TEXT,__text _check_length_2
# CHECK: [[#%x,HAS_UNWIND_2:]]              l     F __TEXT,__text _has_unwind_1
# CHECK: [[#%x,HAS_UNWIND_2]]               l     F __TEXT,__text _has_unwind_2
# CHECK: [[#%x,HAS_UNWIND_3:]]              l     F __TEXT,__text _has_unwind_3
# CHECK: [[#%x,HAS_UNWIND_4:]]              l     F __TEXT,__text _has_unwind_4
# CHECK: [[#%x,HAS_ABS_PERSONALITY_1:]]     l     F __TEXT,__text _has_abs_personality_1
# CHECK: [[#%x,HAS_ABS_PERSONALITY_2:]]     l     F __TEXT,__text _has_abs_personality_2
# CHECK: [[#%x,HAS_EH_FRAME_1:]]            l     F __TEXT,__text _has_eh_frame_1
# CHECK: [[#%x,HAS_EH_FRAME_2:]]            l     F __TEXT,__text _has_eh_frame_2
# CHECK: [[#%x,HAS_EH_FRAME_3:]]            l     F __TEXT,__text _has_eh_frame_3
# CHECK: [[#%x,MUTALLY_RECURSIVE_2:]]       l     F __TEXT,__text _mutually_recursive_1
# CHECK: [[#%x,MUTALLY_RECURSIVE_2]]        l     F __TEXT,__text _mutually_recursive_2
# CHECK: [[#%x,INIT_2:]]                    l     F __TEXT,__text _init_1
# CHECK: [[#%x,INIT_2]]                     l     F __TEXT,__text _init_2
# CHECK: [[#%x,INIT_3:]]                    l     O __TEXT,__foo  _init_3
### FIXME: Mutually-recursive functions with identical bodies (see below)
# COM:   [[#%x,ASYMMETRIC_RECURSIVE_2:]]    l   F __TEXT,__text _asymmetric_recursive_1
# COM:   [[#%x,ASYMMETRIC_RECURSIVE_2]]     l   F __TEXT,__text _asymmetric_recursive_2
# CHECK: [[#%x,GCC_EXCEPT_0:]]              l     O __TEXT,__gcc_except_tab GCC_except_table0
# CHECK: [[#%x,GCC_EXCEPT_0]]               l     O __TEXT,__gcc_except_tab GCC_except_table1
# CHECK: [[#%x,GCC_EXCEPT_2:]]              l     O __TEXT,__gcc_except_tab GCC_except_table2

## Check that we don't accidentally dedup distinct EH frames.
# CHECK: FDE {{.*}} pc=[[#%x,HAS_EH_FRAME_1]]
# CHECK: FDE {{.*}} pc=[[#%x,HAS_EH_FRAME_2]]
# CHECK: FDE {{.*}} pc=[[#%x,HAS_EH_FRAME_3]]

# CHECK-LABEL: Disassembly of section __TEXT,__text:
# CHECK:        <_main>:
# CHECK: callq 0x[[#%x,ABS1B_REF]]                 <_abs1b_ref>
# CHECK: callq 0x[[#%x,ABS1B_REF]]                 <_abs1b_ref>
# CHECK: callq 0x[[#%x,ABS1B_REF_WITH_ADDEND]]     <_abs1b_ref_with_addend>
# CHECK: callq 0x[[#%x,ABS1B_REF_WITH_ADDEND]]     <_abs1b_ref_with_addend>
# CHECK: callq 0x[[#%x,ABS2_REF]]                  <_abs2_ref>
# CHECK: callq 0x[[#%x,NOT_ABS_REF]]               <_not_abs_ref>
# CHECK: callq 0x[[#%x,DYLIB_REF_2]]               <_dylib_ref_2>
# CHECK: callq 0x[[#%x,DYLIB_REF_2]]               <_dylib_ref_2>
# CHECK: callq 0x[[#%x,DYLIB_REF_3]]               <_dylib_ref_3>
# CHECK: callq 0x[[#%x,DYLIB_REF_4]]               <_dylib_ref_4>
# CHECK: callq 0x[[#%x,ALT]]                       <_alt>
# CHECK: callq 0x[[#%x,WITH_ALT_ENTRY]]            <_with_alt_entry>
# CHECK: callq 0x[[#%x,NO_ALT_ENTRY]]              <_no_alt_entry>
# CHECK: callq 0x[[#%x,DEFINED_REF_WITH_ADDEND_2]] <_defined_ref_with_addend_2>
# CHECK: callq 0x[[#%x,DEFINED_REF_WITH_ADDEND_2]] <_defined_ref_with_addend_2>
# CHECK: callq 0x[[#%x,DEFINED_REF_WITH_ADDEND_3]] <_defined_ref_with_addend_3>
# CHECK: callq 0x[[#%x,RECURSIVE]]                 <_recursive>
# CHECK: callq 0x[[#%x,CALL_RECURSIVE_2]]          <_call_recursive_2>
# CHECK: callq 0x[[#%x,CALL_RECURSIVE_2]]          <_call_recursive_2>
# CHECK: callq 0x[[#%x,CHECK_LENGTH_1]]            <_check_length_1>
# CHECK: callq 0x[[#%x,CHECK_LENGTH_2]]            <_check_length_2>
# CHECK: callq 0x[[#%x,HAS_UNWIND_2]]              <_has_unwind_2>
# CHECK: callq 0x[[#%x,HAS_UNWIND_2]]              <_has_unwind_2>
# CHECK: callq 0x[[#%x,HAS_UNWIND_3]]              <_has_unwind_3>
# CHECK: callq 0x[[#%x,HAS_UNWIND_4]]              <_has_unwind_4>
# CHECK: callq 0x[[#%x,HAS_ABS_PERSONALITY_1]]     <_has_abs_personality_1>
# CHECK: callq 0x[[#%x,HAS_ABS_PERSONALITY_2]]     <_has_abs_personality_2>
# CHECK: callq 0x[[#%x,HAS_EH_FRAME_1]]            <_has_eh_frame_1>
# CHECK: callq 0x[[#%x,HAS_EH_FRAME_2]]            <_has_eh_frame_2>
# CHECK: callq 0x[[#%x,HAS_EH_FRAME_3]]            <_has_eh_frame_3>
# CHECK: callq 0x[[#%x,MUTALLY_RECURSIVE_2]]       <_mutually_recursive_2>
# CHECK: callq 0x[[#%x,MUTALLY_RECURSIVE_2]]       <_mutually_recursive_2>
## FIXME Mutually-recursive functions with identical bodies (see below)
# COM:   callq 0x[[#%x,ASYMMETRIC_RECURSIVE_2]]    <_asymmetric_recursive_2>
# COM:   callq 0x[[#%x,ASYMMETRIC_RECURSIVE_2]]    <_asymmetric_recursive_2>
# CHECK: callq 0x[[#%x,INIT_2]]                    <_init_2>
# CHECK: callq 0x[[#%x,INIT_2]]                    <_init_2>
# CHECK: callq 0x[[#%x,INIT_3]]                    <_init_3>

### TODO:
### * Fold: funcs only differ in alignment
### * No fold: func is weak? preemptible?
### * Test that we hash things appropriately w/ minimal collisions

#--- abs.s
.subsections_via_symbols

.globl _abs1a, _abs1b, _abs2, _not_abs
_abs1a = 0xfac3
_abs1b = 0xfac3
_abs2 =  0xf00d

.data
.space 0xfac3
## _not_abs has the same Defined::value as _abs1{a,b}
_not_abs:

#--- main.s
.subsections_via_symbols
.text

_abs1a_ref:
  movabs $_abs1a, %rdx

_abs1b_ref:
  movabs $_abs1b, %rdx

_abs1a_ref_with_addend:
  movabs $_abs1a + 3, %rdx

_abs1b_ref_with_addend:
  movabs $_abs1b + 3, %rdx

## No fold: the absolute symbol value differs
_abs2_ref:
  movabs $_abs2, %rdx

## No fold: _not_abs has the same value as _abs1{a,b}, but is not absolute.
_not_abs_ref:
  movabs $_not_abs, %rdx

_dylib_ref_1:
  mov ___nan@GOTPCREL(%rip), %rax
  callq ___isnan

_dylib_ref_2:
  mov ___nan@GOTPCREL(%rip), %rax
  callq ___isnan

## No fold: referent dylib symbol differs
_dylib_ref_3:
  mov ___inf@GOTPCREL(%rip), %rax
  callq ___inf

## No fold: referent dylib addend differs
_dylib_ref_4:
  mov ___nan + 1@GOTPCREL(%rip), %rax
  callq ___inf + 1

## Sections with alt entries cannot be merged.
.alt_entry _alt
_with_alt_entry:
  movq $3132, %rax
_alt:
  ret

_no_alt_entry:
  movq $3132, %rax
  ret

_defined_ref_with_addend_1:
  callq _with_alt_entry + 4

_defined_ref_with_addend_2:
  callq _with_alt_entry + 4

# No fold: addend differs
_defined_ref_with_addend_3:
  callq _with_alt_entry + 8

## _recursive has the same body as its next two callers, but cannot be folded
## with them.
_recursive:
  callq _recursive

_call_recursive_1:
  callq _recursive

_call_recursive_2:
  callq _recursive

## Functions of different lengths should not be folded
_check_length_1:
  movq $97, %rax

_check_length_2:
  movq $97, %rax
  .space 1

_my_personality:
  mov $1345, %rax

## Functions with identical unwind info should be folded.
_has_unwind_1:
  .cfi_startproc
  .cfi_personality 155, _my_personality
  .cfi_lsda 16, Lexception0
  .cfi_def_cfa_offset 16
  ret
  .cfi_endproc

_has_unwind_2:
  .cfi_startproc
  .cfi_personality 155, _my_personality
  .cfi_lsda 16, Lexception1
  .cfi_def_cfa_offset 16
  ret
  .cfi_endproc

## This function has a different cfa_offset from the first two, and therefore
## should not be folded.
_has_unwind_3:
  .cfi_startproc
  .cfi_personality 155, _my_personality
  .cfi_lsda 16, Lexception1
  .cfi_def_cfa_offset 8
  ret
  .cfi_endproc

## This function has a different LSDA from the first two, and therefore should
## not be folded.
_has_unwind_4:
  .cfi_startproc
  .cfi_personality 155, _my_personality
  .cfi_lsda 16, Lexception2
  .cfi_def_cfa_offset 16
  ret
  .cfi_endproc

## The next two functions should not be folded as they refer to personalities
## at different absolute addresses. This verifies that we are doing the right
## thing in our "data slicing hack" for compact unwind.
_has_abs_personality_1:
  .cfi_startproc
  .cfi_personality 155, _abs_personality_1
  .cfi_def_cfa_offset 16
  ret
  .cfi_endproc

_has_abs_personality_2:
  .cfi_startproc
  .cfi_personality 155, _abs_personality_2
  .cfi_def_cfa_offset 16
  ret
  .cfi_endproc

_abs_personality_1 = 0x1
_abs_personality_2 = 0x2

## In theory _has_eh_frame_{1, 2} can be dedup'ed, but we don't support this
## yet.
_has_eh_frame_1:
  .cfi_startproc
  .cfi_def_cfa_offset 8
  ## cfi_escape cannot be encoded in compact unwind
  .cfi_escape 0x2e, 0x10
  ret
  .cfi_endproc

_has_eh_frame_2:
  .cfi_startproc
  .cfi_def_cfa_offset 8
  ## cfi_escape cannot be encoded in compact unwind
  .cfi_escape 0x2e, 0x10
  ret
  .cfi_endproc

## The nop in this function body means that it cannot be folded with the
## previous two, even though the unwind info is otherwise identical.
_has_eh_frame_3:
  .cfi_startproc
  .cfi_def_cfa_offset 8
  ## cfi_escape cannot be encoded in compact unwind
  .cfi_escape 0x2e, 0x10
  nop
  ret
  .cfi_endproc

## Fold: Mutually-recursive functions with symmetric bodies
_mutually_recursive_1:
  callq _mutually_recursive_1 # call myself
  callq _mutually_recursive_2 # call my twin

_mutually_recursive_2:
  callq _mutually_recursive_2 # call myself
  callq _mutually_recursive_1 # call my twin

## Fold: Mutually-recursive functions with identical bodies
##
## FIXME: This test is currently broken. Recursive call sites have no relocs
## and the non-zero displacement field is already written to the section
## data, while non-recursive call sites use symbol relocs and section data
## contains zeros in the displacement field. Thus, ICF's equalsConstant()
## finds that the section data doesn't match.
##
## ELF folds this case properly because it emits symbol relocs for all calls,
## even recursive ones.

_asymmetric_recursive_1:
  callq _asymmetric_recursive_1 # call myself
  callq _asymmetric_recursive_2 # call my twin
  movl $3, %eax

_asymmetric_recursive_2:
  callq _asymmetric_recursive_1 # call my twin
  callq _asymmetric_recursive_2 # call myself
  movl $3, %eax

_init_1:
  movq $12938, %rax

## Fold: _init_2 is in a section that gets renamed and output as __text
.section __TEXT,__StaticInit
_init_2:
  movq $12938, %rax

## No fold: _init_3 is in a different output section from _init_{1,2}
.section __TEXT,__foo
_init_3:
  movq $12938, %rax

.text
.globl _main
_main:
  callq _abs1a_ref
  callq _abs1b_ref
  callq _abs1a_ref_with_addend
  callq _abs1b_ref_with_addend
  callq _abs2_ref
  callq _not_abs_ref
  callq _dylib_ref_1
  callq _dylib_ref_2
  callq _dylib_ref_3
  callq _dylib_ref_4
  callq _alt
  callq _with_alt_entry
  callq _no_alt_entry
  callq _defined_ref_with_addend_1
  callq _defined_ref_with_addend_2
  callq _defined_ref_with_addend_3
  callq _recursive
  callq _call_recursive_1
  callq _call_recursive_2
  callq _check_length_1
  callq _check_length_2
  callq _has_unwind_1
  callq _has_unwind_2
  callq _has_unwind_3
  callq _has_unwind_4
  callq _has_abs_personality_1
  callq _has_abs_personality_2
  callq _has_eh_frame_1
  callq _has_eh_frame_2
  callq _has_eh_frame_3
  callq _mutually_recursive_1
  callq _mutually_recursive_2
  callq _asymmetric_recursive_1
  callq _asymmetric_recursive_2
  callq _init_1
  callq _init_2
  callq _init_3

.section __TEXT,__gcc_except_tab
GCC_except_table0:
Lexception0:
  .byte 255

GCC_except_table1:
Lexception1:
  .byte 255

GCC_except_table2:
Lexception2:
  .byte 254
