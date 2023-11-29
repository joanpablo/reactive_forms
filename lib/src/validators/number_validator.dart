// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that validates if control's value is a numeric value.
class NumberValidator extends Validator<dynamic> {
  const NumberValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return (control.value == null) ||
            num.tryParse(control.value.toString()) == null
        ? <String, dynamic>{ValidationMessage.number: true}
        : null;
  }
}
