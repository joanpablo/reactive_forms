// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class MinValidator<T> extends Validator<Comparable<T>> {
  final T min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  MinValidator(this.min);

  @override
  Map<String, Object>? validate(AbstractControl<Comparable<T>> control) {
    return (control.value != null) && (control.value!.compareTo(min) >= 0)
        ? null
        : {
            ValidationMessage.min: {
              'min': min,
              'actual': control.value,
            },
          };
  }
}
