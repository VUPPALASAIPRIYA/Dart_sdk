// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

extension type IntegerExt(int integer) {
  static IntegerExt get one => IntegerExt(1);
}

void main() {
  IntegerExt c = .one;
}
