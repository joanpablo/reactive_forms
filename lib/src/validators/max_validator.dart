// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// validator that requires the control's value to be less than or equal to a
/// provided value.
class MaxValidator extends Validator<Comparable> {
  final Comparable max;

  /// Constructs the instance of the validator.
  ///
  /// The argument [max] must not be null.
  MaxValidator(this.max);

  @override
  Map<String, dynamic>? validate(AbstractControl<Comparable> control) {
    // ignore: unnecessary_null_comparison
    return (control.value != null) && (control.value!.compareTo(max) <= 0)
        ? null
        : {
            ValidationMessage.max: {
              'max': max,
              'actual': control.value,
            },
          };
  }
}
