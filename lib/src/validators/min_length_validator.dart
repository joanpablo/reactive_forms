// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that validates whether the value meets a minimum length
/// requirement.
class MinLengthValidator extends Validator {
  final int minLength;

  /// Constructs a [MinLengthValidator].
  ///
  /// The argument [minLength] argument must not be null.
  MinLengthValidator(this.minLength) : assert(minLength != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return (control.value == null || control.value.length >= this.minLength)
        ? null
        : {
            ValidationMessage.minLength: {
              'requiredLength': this.minLength,
              'actualLength': control.value.length,
            }
          };
  }
}
