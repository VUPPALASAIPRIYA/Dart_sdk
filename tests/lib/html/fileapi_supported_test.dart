// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:expect/legacy/async_minitest.dart'; // ignore: deprecated_member_use

Future<FileSystem>? _fileSystem;

Future<FileSystem> get fileSystem async {
  if (_fileSystem != null) return _fileSystem!;

  _fileSystem = window.requestFileSystem(100);

  var fs = await _fileSystem!;
  expect(fs.runtimeType, FileSystem);
  expect(fs.root.runtimeType, DirectoryEntry);

  return _fileSystem!;
}

main() {
  test('supported', () {
    expect(FileSystem.supported, true);
  });

  test('requestFileSystem', () async {
    var expectation = FileSystem.supported ? returnsNormally : throws;
    expect(() async {
      await fileSystem;
    }, expectation);
  });
}
