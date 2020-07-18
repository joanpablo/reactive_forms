// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// This exception is thrown when the index used to access a control in a
/// [FormArray] is not a valid integer number.
class FormArrayInvalidIndexException implements Exception {
  final String index;

  /// Creates an instance of the exception
  FormArrayInvalidIndexException(this.index);

  @override
  String toString() {
    return 'FormArrayInvalidIndexException: Index \'$index\' is not a valid index for FormArray';
  }
}
