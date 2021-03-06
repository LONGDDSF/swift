// RUN: %empty-directory(%t)
// RUN: %target-build-swift %s -module-name Availability -emit-module -emit-module-path %t/
// RUN: %target-swift-symbolgraph-extract -module-name Availability -I %t -pretty-print -output-dir %t
// RUN: %FileCheck %s --input-file %t/Availability.symbols.json

@available(macOS, introduced: 10.9, deprecated: 10.10, obsoleted: 10.11, message: "Everyone makes mistakes", renamed: "S2")
public struct S {}

// CHECK: "domain": "macOS"

// CHECK: introduced
// CHECK-NEXT: "major": 10
// CHECK-NEXT: "minor": 9

// CHECK: deprecated 
// CHECK-NEXT: "major": 10
// CHECK-NEXT: "minor": 10

// CHECK: obsoleted
// CHECK-NEXT: "major": 10
// CHECK-NEXT: "minor": 11

// CHECK: "message": "Everyone makes mistakes"
// CHECK: "renamed": "S2"
