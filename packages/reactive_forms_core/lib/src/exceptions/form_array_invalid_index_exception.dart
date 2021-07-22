// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'reactive_forms_exception.dart';

/// This exception is thrown when the index used to access a control in a
/// [FormArray] is not a valid integer number.
class FormArrayInvalidIndexException extends ReactiveFormsException {
  /// The invalid index that was the cause of this exception.
  final String index;

  /// Creates an instance of the exception.
  ///
  /// The [index] argument is the invalid index that was the cause
  /// of this exception.
  FormArrayInvalidIndexException(this.index);

  @override
  String toString() {
    return 'FormArrayInvalidIndexException: Index \'$index\' is not a valid index for FormArray';
  }
}
