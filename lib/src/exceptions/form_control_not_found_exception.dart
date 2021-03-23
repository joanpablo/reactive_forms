// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// This exception is thrown when a [FormGroup] or a [FormArray]
/// doesn't find the [FormControl] by name
class FormControlNotFoundException extends ReactiveFormsException {
  /// The name of the control that was not found.
  final String? controlName;

  /// Creates an instance of the exception.
  ///
  /// Requires the [controlName] that represents the name of the control
  /// that was not found.
  FormControlNotFoundException({this.controlName});

  @override
  String toString() {
    if (this.controlName == null) {
      return 'FormControlNotFoundException: control not found.';
    }

    return 'FormControlNotFoundException: control with name: \'$controlName\' not found.';
  }
}
