// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class MinValidator<Comparable> extends Validator {
  final Comparable min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  MinValidator(this.min) : assert(min != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return control.value is Comparable && control.value >= min
        ? null
        : {
            ValidationMessage.min: {
              'min': min,
              'actual': control.value,
            },
          };
  }
}
