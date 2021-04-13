// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Represents a [FormGroup] validator that requires that two controls in the
/// group have the same values.
class MustMatchValidator extends Validator<dynamic> {
  final String controlName;
  final String matchingControlName;

  /// Constructs an instance of [MustMatchValidator]
  MustMatchValidator(this.controlName, this.matchingControlName);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessage.mustMatch: true};

    if (control is! FormGroup) {
      return error;
    }

    final formControl = control.control(controlName);
    final matchingFormControl = control.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors(error);
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError(ValidationMessage.mustMatch);
    }

    return null;
  }
}
