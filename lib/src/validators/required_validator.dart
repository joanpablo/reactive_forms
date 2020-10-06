// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control have a non-empty value.
class RequiredValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic> validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessage.required: true};

    if (control.value == null) {
      return error;
    } else if (control.value is String) {
      return control.value.trim().isEmpty ? error : null;
    }

    return null;
  }
}
