// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// This exception is thrown when a [FormGroup] or a [FormArray]
/// doesn't find the [FormControl] by name
class FormControlNotFoundException implements Exception {
  final String controlName;

  /// Creates an instance of the exception
  FormControlNotFoundException({this.controlName});

  @override
  String toString() {
    if (this.controlName == null) {
      return 'FormControlNotFoundException: control not found.';
    }

    return 'FormControlNotFoundException: control with name: \'$controlName\' not found.';
  }
}
