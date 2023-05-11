// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to not be null or blank string.
class RequiredValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{ValidationMessage.required: true};

    if (control.value == null) {
      return error;
    } else if (control.value is String) {
      return (control.value as String).trim().isEmpty ? error : null;
    }

    return null;
  }
}
