// Test hlfir.maxloc operation parse, verify (no errors), and unparse

// RUN: fir-opt %s | fir-opt | FileCheck %s

// array is an expression of known shape
func.func @maxloc0(%arg0: !hlfir.expr<42xi32>) {
  %mask = fir.alloca !fir.logical<4>
  %c_1 = arith.constant 1 : index
  %true = arith.constant true
  %true_logical = fir.convert %true : (i1) -> !fir.logical<4>
  fir.store %true_logical to %mask : !fir.ref<!fir.logical<4>>
  %mask_box = fir.embox %mask : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %mask_box : (!hlfir.expr<42xi32>, index, !fir.box<!fir.logical<4>>) -> i32
  return
}
// CHECK:      func.func @maxloc0(%[[ARRAY:.*]]: !hlfir.expr<42xi32>) {
// CHECK-NEXT:   %[[MASK:.*]] = fir.alloca !fir.logical<4>
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   %[[TRUE:.*]] = arith.constant true
// CHECK-NEXT:   %[[LOGICAL:.*]] = fir.convert %[[TRUE]] : (i1) -> !fir.logical<4>
// CHECK-NEXT:   fir.store %[[LOGICAL]] to %[[MASK]] : !fir.ref<!fir.logical<4>>
// CHECK-NEXT:   %[[BOX:.*]] = fir.embox %0 : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[C1]] mask %[[BOX]] : (!hlfir.expr<42xi32>, index, !fir.box<!fir.logical<4>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// array is an expression of assumed shape
func.func @maxloc1(%arg0: !hlfir.expr<?xi32>) {
  %mask = fir.alloca !fir.logical<4>
  %c_1 = arith.constant 1 : index
  %true = arith.constant true
  %true_logical = fir.convert %true : (i1) -> !fir.logical<4>
  fir.store %true_logical to %mask : !fir.ref<!fir.logical<4>>
  %mask_box = fir.embox %mask : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %mask_box : (!hlfir.expr<?xi32>, index, !fir.box<!fir.logical<4>>) -> i32
  return
}
// CHECK:      func.func @maxloc1(%[[ARRAY:.*]]: !hlfir.expr<?xi32>) {
// CHECK-NEXT:   %[[MASK:.*]] = fir.alloca !fir.logical<4>
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   %[[TRUE:.*]] = arith.constant true
// CHECK-NEXT:   %[[LOGICAL:.*]] = fir.convert %[[TRUE]] : (i1) -> !fir.logical<4>
// CHECK-NEXT:   fir.store %[[LOGICAL:.*]] to %[[MASK:.*]] : !fir.ref<!fir.logical<4>>
// CHECK-NEXT:   %[[BOX:.*]] = fir.embox %[[MASK:.*]] : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY:.*]] dim %[[C1]] mask %[[BOX]] : (!hlfir.expr<?xi32>, index, !fir.box<!fir.logical<4>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// boxed array
func.func @maxloc2(%arg0: !fir.box<!fir.array<42xi32>>) {
  %mask = fir.alloca !fir.logical<4>
  %c_1 = arith.constant 1 : index
  %true = arith.constant true
  %true_logical = fir.convert %true : (i1) -> !fir.logical<4>
  fir.store %true_logical to %mask : !fir.ref<!fir.logical<4>>
  %mask_box = fir.embox %mask : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %mask_box : (!fir.box<!fir.array<42xi32>>, index, !fir.box<!fir.logical<4>>) -> i32
  return
}
// CHECK:      func.func @maxloc2(%[[ARRAY:.*]]: !fir.box<!fir.array<42xi32>>) {
// CHECK-NEXT:   %[[MASK:.*]] = fir.alloca !fir.logical<4>
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   %[[TRUE:.*]] = arith.constant true
// CHECK-NEXT:   %[[LOGICAL:.*]] = fir.convert %[[TRUE]] : (i1) -> !fir.logical<4>
// CHECK-NEXT:   fir.store %[[LOGICAL:.*]] to %[[MASK:.*]] : !fir.ref<!fir.logical<4>>
// CHECK-NEXT:   %[[BOX:.*]] = fir.embox %[[MASK:.*]] : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY:.*]] dim %[[C1]] mask %[[BOX]] : (!fir.box<!fir.array<42xi32>>, index, !fir.box<!fir.logical<4>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// assumed shape boxed array
func.func @maxloc3(%arg0: !fir.box<!fir.array<?xi32>>) {
  %mask = fir.alloca !fir.logical<4>
  %c_1 = arith.constant 1 : index
  %true = arith.constant true
  %true_logical = fir.convert %true : (i1) -> !fir.logical<4>
  fir.store %true_logical to %mask : !fir.ref<!fir.logical<4>>
  %mask_box = fir.embox %mask : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %mask_box : (!fir.box<!fir.array<?xi32>>, index, !fir.box<!fir.logical<4>>) -> i32
  return
}
// CHECK:      func.func @maxloc3(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>) {
// CHECK-NEXT:   %[[MASK:.*]] = fir.alloca !fir.logical<4>
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   %[[TRUE:.*]] = arith.constant true
// CHECK-NEXT:   %[[LOGICAL:.*]] = fir.convert %[[TRUE]] : (i1) -> !fir.logical<4>
// CHECK-NEXT:   fir.store %[[LOGICAL:.*]] to %[[MASK:.*]] : !fir.ref<!fir.logical<4>>
// CHECK-NEXT:   %[[BOX:.*]] = fir.embox %[[MASK:.*]] : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY:.*]] dim %[[C1]] mask %[[BOX]] : (!fir.box<!fir.array<?xi32>>, index, !fir.box<!fir.logical<4>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// known shape expr mask
func.func @maxloc4(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: !hlfir.expr<42x!fir.logical<4>>) {
  %c_1 = arith.constant 1 : index
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %arg1 : (!fir.box<!fir.array<?xi32>>, index, !hlfir.expr<42x!fir.logical<4>>) -> i32
  return
}
// CHECK:      func.func @maxloc4(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: !hlfir.expr<42x!fir.logical<4>>) {
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[C1]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, index, !hlfir.expr<42x!fir.logical<4>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// assumed shape expr mask
func.func @maxloc5(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: !hlfir.expr<?x!fir.logical<4>>) {
  %c_1 = arith.constant 1 : index
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %arg1 : (!fir.box<!fir.array<?xi32>>, index, !hlfir.expr<?x!fir.logical<4>>) -> i32
  return
}
// CHECK:      func.func @maxloc5(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: !hlfir.expr<?x!fir.logical<4>>) {
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[C1]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, index, !hlfir.expr<?x!fir.logical<4>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// known shape array mask
func.func @maxloc6(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: !fir.box<!fir.array<42x!fir.logical<4>>>) {
  %c_1 = arith.constant 1 : index
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %arg1 : (!fir.box<!fir.array<?xi32>>, index, !fir.box<!fir.array<42x!fir.logical<4>>>) -> i32
  return
}
// CHECK:      func.func @maxloc6(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: !fir.box<!fir.array<42x!fir.logical<4>>>) {
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[C1]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, index, !fir.box<!fir.array<42x!fir.logical<4>>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// assumed shape array mask
func.func @maxloc7(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: !fir.box<!fir.array<?x!fir.logical<4>>>) {
  %c_1 = arith.constant 1 : index
  %0 = hlfir.maxloc %arg0 dim %c_1 mask %arg1 : (!fir.box<!fir.array<?xi32>>, index, !fir.box<!fir.array<?x!fir.logical<4>>>) -> i32
  return
}
// CHECK:      func.func @maxloc7(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: !fir.box<!fir.array<?x!fir.logical<4>>>) {
// CHECK-NEXT:   %[[C1:.*]] = arith.constant 1 : index
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[C1]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, index, !fir.box<!fir.array<?x!fir.logical<4>>>) -> i32
// CHECK-NEXT:   return
// CHECK-NEXT: }

// known shape expr return
func.func @maxloc8(%arg0: !fir.box<!fir.array<2x2xi32>>, %arg1: i32) {
  %mask = fir.alloca !fir.logical<4>
  %true = arith.constant true
  %true_logical = fir.convert %true : (i1) -> !fir.logical<4>
  fir.store %true_logical to %mask : !fir.ref<!fir.logical<4>>
  %mask_box = fir.embox %mask : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
  %0 = hlfir.maxloc %arg0 dim %arg1 mask %mask_box : (!fir.box<!fir.array<2x2xi32>>, i32, !fir.box<!fir.logical<4>>) -> !hlfir.expr<2xi32>
  return
}
// CHECK:      func.func @maxloc8(%[[ARRAY:.*]]: !fir.box<!fir.array<2x2xi32>>, %[[DIM:.*]]: i32) {
// CHECK-NEXT:   %[[MASK:.*]] = fir.alloca !fir.logical<4>
// CHECK-NEXT:   %[[TRUE:.*]] = arith.constant true
// CHECK-NEXT:   %[[LOGICAL:.*]] = fir.convert %[[TRUE]] : (i1) -> !fir.logical<4>
// CHECK-NEXT:   fir.store %[[LOGICAL]] to %[[MASK]] : !fir.ref<!fir.logical<4>>
// CHECK-NEXT:   %[[BOX:.*]] = fir.embox %0 : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[DIM]] mask %[[BOX]] : (!fir.box<!fir.array<2x2xi32>>, i32, !fir.box<!fir.logical<4>>) -> !hlfir.expr<2xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// assumed shape expr return
func.func @maxloc9(%arg0: !fir.box<!fir.array<?x?xi32>>, %arg1: i32) {
  %mask = fir.alloca !fir.logical<4>
  %true = arith.constant true
  %true_logical = fir.convert %true : (i1) -> !fir.logical<4>
  fir.store %true_logical to %mask : !fir.ref<!fir.logical<4>>
  %mask_box = fir.embox %mask : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
  %0 = hlfir.maxloc %arg0 dim %arg1 mask %mask_box : (!fir.box<!fir.array<?x?xi32>>, i32, !fir.box<!fir.logical<4>>) -> !hlfir.expr<?xi32>
  return
}
// CHECK:      func.func @maxloc9(%[[ARRAY:.*]]: !fir.box<!fir.array<?x?xi32>>, %[[DIM:.*]]: i32) {
// CHECK-NEXT:   %[[MASK:.*]] = fir.alloca !fir.logical<4>
// CHECK-NEXT:   %[[TRUE:.*]] = arith.constant true
// CHECK-NEXT:   %[[LOGICAL:.*]] = fir.convert %[[TRUE]] : (i1) -> !fir.logical<4>
// CHECK-NEXT:   fir.store %[[LOGICAL]] to %[[MASK]] : !fir.ref<!fir.logical<4>>
// CHECK-NEXT:   %[[BOX:.*]] = fir.embox %0 : (!fir.ref<!fir.logical<4>>) -> !fir.box<!fir.logical<4>>
// CHECK-NEXT:   hlfir.maxloc %[[ARRAY]] dim %[[DIM]] mask %[[BOX]] : (!fir.box<!fir.array<?x?xi32>>, i32, !fir.box<!fir.logical<4>>) -> !hlfir.expr<?xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with only an array argument
func.func @maxloc10(%arg0: !fir.box<!fir.array<?x?xi32>>) {
  %maxloc = hlfir.maxloc %arg0 : (!fir.box<!fir.array<?x?xi32>>) -> !hlfir.expr<1xi32>
  return
}
// CHECK:      func.func @maxloc10(%[[ARRAY:.*]]: !fir.box<!fir.array<?x?xi32>>
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] : (!fir.box<!fir.array<?x?xi32>>) -> !hlfir.expr<1xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with only a character array argument
func.func @maxloc11(%arg0: !fir.box<!fir.array<?x?x!fir.char<1,?>>>) {
  %maxloc = hlfir.maxloc %arg0 : (!fir.box<!fir.array<?x?x!fir.char<1,?>>>) -> !hlfir.expr<1xi32>
  return
}
// CHECK:      func.func @maxloc11(%[[ARRAY:.*]]: !fir.box<!fir.array<?x?x!fir.char<1,?>>>
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] : (!fir.box<!fir.array<?x?x!fir.char<1,?>>>) -> !hlfir.expr<1xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with array and dim argument
func.func @maxloc12(%arg0: !fir.box<!fir.array<?x?xi32>>, %arg1: i32) {
  %maxloc = hlfir.maxloc %arg0 dim %arg1 : (!fir.box<!fir.array<?x?xi32>>, i32) -> !hlfir.expr<?xi32>
  return
}
// CHECK:      func.func @maxloc12(%[[ARRAY:.*]]: !fir.box<!fir.array<?x?xi32>>, %[[DIM:.*]]: i32
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] dim %[[DIM]] : (!fir.box<!fir.array<?x?xi32>>, i32) -> !hlfir.expr<?xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with array and mask argument
func.func @maxloc13(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: !fir.logical<4>) {
  %maxloc = hlfir.maxloc %arg0 mask %arg1 : (!fir.box<!fir.array<?xi32>>, !fir.logical<4>) -> !hlfir.expr<1xi32>
  return
}
// CHECK:      func.func @maxloc13(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: !fir.logical<4>
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, !fir.logical<4>) -> !hlfir.expr<1xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with dim argument with an unusual type
func.func @maxloc14(%arg0: !fir.box<!fir.array<?x?xi32>>, %arg1: index) {
  %maxloc = hlfir.maxloc %arg0 dim %arg1 : (!fir.box<!fir.array<?x?xi32>>, index) -> !hlfir.expr<?xi32>
  return
}
// CHECK:      func.func @maxloc14(%[[ARRAY:.*]]: !fir.box<!fir.array<?x?xi32>>, %[[DIM:.*]]: index
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] dim %[[DIM]] : (!fir.box<!fir.array<?x?xi32>>, index) -> !hlfir.expr<?xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with mask argument of unusual type
func.func @maxloc15(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: i1) {
  %maxloc = hlfir.maxloc %arg0 mask %arg1 : (!fir.box<!fir.array<?xi32>>, i1) -> !hlfir.expr<1xi32>
  return
}
// CHECK:      func.func @maxloc15(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: i1
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, i1) -> !hlfir.expr<1xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with mask argument of ref<array<>> type
func.func @maxloc16(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: !fir.ref<!fir.array<?x!fir.logical<4>>>) {
  %maxloc = hlfir.maxloc %arg0 mask %arg1 : (!fir.box<!fir.array<?xi32>>, !fir.ref<!fir.array<?x!fir.logical<4>>>) -> !hlfir.expr<1xi32>
  return
}
// CHECK:      func.func @maxloc16(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: !fir.ref<!fir.array<?x!fir.logical<4>>>
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, !fir.ref<!fir.array<?x!fir.logical<4>>>) -> !hlfir.expr<1xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }


// hlfir.maxloc with kind implied by the return type
func.func @maxloc17(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: i1) {
  %maxloc = hlfir.maxloc %arg0 mask %arg1 : (!fir.box<!fir.array<?xi32>>, i1) -> !hlfir.expr<1xi16>
  return
}
// CHECK:      func.func @maxloc17(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: i1
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] mask %[[MASK]] : (!fir.box<!fir.array<?xi32>>, i1) -> !hlfir.expr<1xi16>
// CHECK-NEXT:   return
// CHECK-NEXT: }

// hlfir.maxloc with back argument
func.func @maxloc18(%arg0: !fir.box<!fir.array<?xi32>>, %arg1: i1) {
  %true = arith.constant true
  %maxloc = hlfir.maxloc %arg0 mask %arg1 back %true : (!fir.box<!fir.array<?xi32>>, i1, i1) -> !hlfir.expr<1xi32>
  return
}
// CHECK:      func.func @maxloc18(%[[ARRAY:.*]]: !fir.box<!fir.array<?xi32>>, %[[MASK:.*]]: i1
// CHECK-NEXT:   %[[C2:.*]] = arith.constant true
// CHECK-NEXT:   %[[maxloc:.*]] = hlfir.maxloc %[[ARRAY]] mask %[[MASK]] back %[[C2]] : (!fir.box<!fir.array<?xi32>>, i1, i1) -> !hlfir.expr<1xi32>
// CHECK-NEXT:   return
// CHECK-NEXT: }