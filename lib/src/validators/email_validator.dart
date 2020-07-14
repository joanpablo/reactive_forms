// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

class EmailValidator extends Validator {
  static final Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final error = {ValidationMessage.email: true};

    // error if value is not a String
    if (control.value != null && !(control.value is String)) {
      return error;
    }

    RegExp regex = new RegExp(EmailValidator.pattern);
    return (control.value == null ||
            control.value == '' ||
            regex.hasMatch(control.value))
        ? null
        : error;
  }
}
