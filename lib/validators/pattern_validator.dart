// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

class PatternValidator extends Validator {
  final Pattern pattern;

  PatternValidator(this.pattern);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    RegExp regex = new RegExp(this.pattern);
    return (control.value == null ||
            control.value == '' ||
            regex.hasMatch(control.value))
        ? null
        : {
            ValidationMessage.pattern: {
              'requiredPattern': this.pattern.toString(),
              'actualValue': control.value,
            }
          };
  }
}
