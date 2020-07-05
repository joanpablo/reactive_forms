// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

class NumberValidator extends Validator {
  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return (control.value == null || int.tryParse(control.value) == null)
        ? {ValidationMessage.number: true}
        : null;
  }
}
