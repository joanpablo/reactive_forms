// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to be equals to provided [value].
class EqualsValidator<T> extends Validator<T> {
  final T value;

  /// Constructs an instance of [EqualsValidator].
  ///
  /// The argument [value] must not be null.
  EqualsValidator(this.value);

  @override
  Map<String, dynamic>? validate(AbstractControl? control) {
    return control?.value == this.value
        ? null
        : {
            ValidationMessage.equals: {
              'required': value,
              'actual': control?.value,
            }
          };
  }
}
