// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/models/abstract_control.dart';
import 'package:reactive_forms/validators/validator.dart';

class MinLengthValidator extends Validator {
  final int minLength;

  MinLengthValidator(this.minLength);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return (control.value == null || control.value.length >= this.minLength)
        ? null
        : {
            'minLength': {
              'requiredLength': this.minLength,
              'actualLength': control.value.length,
            }
          };
  }
}
