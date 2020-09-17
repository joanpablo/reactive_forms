// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// validator that requires the control's value to be less than or equal to a
/// provided value.
class MaxValidator<Comparable> extends Validator {
  final Comparable max;

  /// Constructs the instance of the validator.
  ///
  /// The argument [max] must not be null.
  MaxValidator(this.max) : assert(max != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return control.value is Comparable && control.value <= max
        ? null
        : {
            'max': {
              'max': max,
              'actual': control.value,
            },
          };
  }
}
