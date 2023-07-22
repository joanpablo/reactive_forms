// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Represents a [FormGroup] validator that requires that two controls in the
/// group have the same values.
class MustMatchValidator extends Validator<dynamic> {
  final String controlName;
  final String matchingControlName;
  final bool markAsDirty;
  const MustMatchValidator(
      this.controlName, this.matchingControlName, this.markAsDirty)
      : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessage.mustMatch: true};
    var form = {};
    control.parent?.valueChanges.listen((event) {
      form = event as Map<dynamic, dynamic>;

      if (form[controlName] != form[matchingControlName]) {
        control.setErrors(error, markAsDirty: markAsDirty);
        control.markAsTouched();
      } else {
        control.removeError(ValidationMessage.mustMatch);
      }
    });
    return null;
  }
}
