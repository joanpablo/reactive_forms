// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value pass an email validation test.
class EmailValidator extends Validator<String> {
  static final RegExp emailRegex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic>? control) {
    final error = {ValidationMessage.email: control?.value};

    // don't validate empty values to allow optional controls
    return (control?.isNull == true ||
            control?.value?.isEmpty == true ||
            emailRegex.hasMatch(control!.value.toString()))
        ? null
        : error;
  }
}
