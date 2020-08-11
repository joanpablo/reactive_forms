// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that validates that the length of the control's value string
/// doesn't exceed the maximum allowed limit.
class MaxLengthValidator extends Validator {
  final int maxLength;

  /// Constructs a [MaxLengthValidator].
  ///
  /// The [maxLength] must not be null.
  MaxLengthValidator(this.maxLength) : assert(maxLength != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return (control.value == null || control.value.length <= this.maxLength)
        ? null
        : {
            ValidationMessage.maxLength: {
              'requiredLength': this.maxLength,
              'actualLength': control.value.length,
            }
          };
  }
}
