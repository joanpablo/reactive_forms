// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to be equals to provided [value].
class EqualsValidator<T> extends Validator<dynamic> {
  final T value;
  final String validationMessage;

  /// Constructs an instance of [EqualsValidator].
  ///
  /// The argument [value] must not be null.
  ///
  /// The argument [validationMessage] is optional and specify the key text for
  /// the validation error. I none value is supplied then the default value is
  /// [ValidationMessage.equals].
  EqualsValidator(
    this.value, {
    this.validationMessage = ValidationMessage.equals,
  });

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return control.value == value
        ? null
        : <String, dynamic>{
            validationMessage: <String, dynamic>{
              'required': value,
              'actual': control.value,
            }
          };
  }
}
