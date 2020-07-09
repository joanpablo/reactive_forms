// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

class FormControlInvalidNameException implements Exception {
  final String name;

  /// Creates an instance of the exception
  FormControlInvalidNameException(this.name);

  @override
  String toString() {
    return 'FormControlInvalidNameException: Child FormControl with name: \'$name\' not found';
  }
}
