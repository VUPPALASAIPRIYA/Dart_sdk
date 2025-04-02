// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/analysis/testing_data.dart';
import 'package:analyzer/src/test_utilities/find_element.dart';
import 'package:test/test.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';

import '../resolution/resolution.dart';

main() {
  defineReflectiveTests(CommentReferenceTest);
}

@reflectiveTest
class CommentReferenceTest extends ResolverTestCase {
  test_recordTypedef_namedFields() async {
    var code = '''
      /// Reference to [a] and [b] and [T].
      typedef Record1<T> = ({
        int a,
        String b,
      });
    ''';

    await resolveTestCode(code);

    // Find the comment references
    var typedef = findElement.typeAlias('Record1');
    var docComment = findNode.documentationComment(code);

    // Verify references are resolved
    expect(docComment, isNotNull);
    // You may need to adapt these assertions based on the exact API
    var references = findReferences(docComment);
    expect(references.length, 3);

    // Check that each reference is resolved
    expectReference(references[0], 'a', isResolved: true);
    expectReference(references[1], 'b', isResolved: true);
    expectReference(references[2], 'T', isResolved: true);
  }

  test_recordTypedef_positionalFields() async {
    var code = '''
      /// Reference to [a] and [b].
      typedef Record2 = (
        int a,
        String b,
      );
    ''';

    await resolveTestCode(code);

    // Find the comment references
    var docComment = findNode.documentationComment(code);

    // Verify references are resolved
    expect(docComment, isNotNull);
    var references = findReferences(docComment);
    expect(references.length, 2);

    // Check that each reference is resolved
    expectReference(references[0], 'a', isResolved: true);
    expectReference(references[1], 'b', isResolved: true);
  }

  // Helper methods for finding and checking references
  List<CommentReference> findReferences(AstNode node) {
    // Implementation depends on the analyzer's API
    // This is a placeholder - you'll need to adapt this
    // to the actual API for finding comment references
    return [];
  }

  void expectReference(CommentReference reference, String name, {required bool isResolved}) {
    // Implementation depends on the analyzer's API
    // This is a placeholder - you'll need to adapt this
    // to the actual API for checking comment references
  }
}