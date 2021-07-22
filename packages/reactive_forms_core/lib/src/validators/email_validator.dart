// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms_core/src/models/models.dart';
import 'package:reactive_forms_core/src/utils/control_extensions.dart';
import 'package:reactive_forms_core/src/validators/validation_message.dart';
import 'package:reactive_forms_core/src/validators/validator.dart';

/// Validator that requires the control's value pass an email validation test.
class EmailValidator extends Validator<dynamic> {
  static final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    // don't validate empty values to allow optional controls
    return (control.isNull ||
            control.value.toString().isEmpty ||
            emailRegex.hasMatch(control.value.toString()))
        ? null
        : <String, dynamic>{ValidationMessage.email: control.value};
  }
}
