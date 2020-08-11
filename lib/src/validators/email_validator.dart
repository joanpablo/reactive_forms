// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value pass an email validation test.
class EmailValidator extends Validator {
  static final RegExp emailRegex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final error = {ValidationMessage.email: true};

    // error if value is not a String
    if (control.value != null && !(control.value is String)) {
      return error;
    }

    return (control.value == null ||
            control.value == '' ||
            emailRegex.hasMatch(control.value))
        ? null
        : error;
  }
}
