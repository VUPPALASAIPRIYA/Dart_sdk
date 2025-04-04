// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:developer';
import 'common/service_test_common.dart';
import 'common/test_helper.dart';

// AUTOGENERATED START
//
// Update these constants by running:
//
// dart pkg/vm_service/test/update_line_numbers.dart pkg/vm_service/test/issue_57040_test.dart
//
const LINE_A = 28;
const LINE_B = 31;
// AUTOGENERATED END

extension on String? {
  bool get isNullOrEmpty {
    final str = this;
    return str == null || str.isEmpty;
  }
}

void code() {
  String? str = 'hello';
  debugger(); // LINE_A
  print(str.isNullOrEmpty);
  str = null;
  debugger(); // LINE_B
  print(str.isNullOrEmpty);
}

final tests = <IsolateTest>[
  hasStoppedAtBreakpoint,
  stoppedAtLine(LINE_A),
  testExpressionEvaluationAndAvailableVariables('code', [
    'str',
  ], [
    ('() { return str.isNullOrEmpty; }()', 'false'),
    ('str.isNullOrEmpty', 'false'),
  ]),
  resumeIsolate,
  hasStoppedAtBreakpoint,
  stoppedAtLine(LINE_B),
  testExpressionEvaluationAndAvailableVariables('code', [
    'str',
  ], [
    ('() { return str.isNullOrEmpty; }()', 'true'),
    ('str.isNullOrEmpty', 'true'),
  ]),
];

void main([args = const <String>[]]) => runIsolateTests(
      args,
      tests,
      'issue_57040_test.dart',
      testeeConcurrent: code,
      pauseOnStart: false,
      pauseOnExit: true,
    );
