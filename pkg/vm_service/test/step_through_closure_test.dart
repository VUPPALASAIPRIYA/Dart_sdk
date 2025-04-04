// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'common/service_test_common.dart';
import 'common/test_helper.dart';

// AUTOGENERATED START
//
// Update these constants by running:
//
// dart pkg/vm_service/test/update_line_numbers.dart pkg/vm_service/test/step_through_closure_test.dart
//
const LINE_A = 22;
// AUTOGENERATED END

const file = 'step_through_closure_test.dart';

int codeXYZ(int i) {
  int x() =>
      // some comment here to allow this formatting
      i * i; // LINE_A
  return x();
}

void code() {
  codeXYZ(42);
}

final stops = <String>[];
const expected = <String>[
  '$file:${LINE_A + 0}:9', // on '*'
  '$file:${LINE_A + 0}:7', // on first 'i'
  '$file:${LINE_A + 1}:3', // on 'return'
  '$file:${LINE_A + 6}:1', // on ending '}'
];

final tests = <IsolateTest>[
  hasPausedAtStart,
  setBreakpointAtLine(LINE_A),
  runStepThroughProgramRecordingStops(stops),
  checkRecordedStops(stops, expected),
];

void main([args = const <String>[]]) => runIsolateTests(
      args,
      tests,
      'step_through_closure_test.dart',
      testeeConcurrent: code,
      pauseOnStart: true,
      pauseOnExit: true,
    );
