// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:expect/async_helper.dart';
import 'package:expect/expect.dart';

import "no_such_method_lib.dart" deferred as lib;

void main() {
  asyncStart();
  lib.loadLibrary().then((_) {
    Expect.equals(42, (new lib.C() as dynamic).nonExisting());
    asyncEnd();
  });
}
