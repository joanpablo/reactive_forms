// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// validator that requires the control's value to be less than or equal to a
/// provided value.
class MaxValidator<T> extends Validator<dynamic> {
  final T max;

  /// Constructs the instance of the validator.
  ///
  /// The argument [max] must not be null.
  MaxValidator(this.max);

  @override
  Map<String, Object>? validate(AbstractControl<dynamic> control) {
    assert(control is AbstractControl<Comparable<dynamic>>);

    final comparable = control as AbstractControl<Comparable<dynamic>>;
    return (comparable.value != null) && (comparable.value!.compareTo(max) <= 0)
        ? null
        : {
            ValidationMessage.max: {
              'max': max,
              'actual': control.value,
            },
          };
  }
}
