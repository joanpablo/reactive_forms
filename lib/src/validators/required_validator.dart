// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control have a non-empty value.
class RequiredValidator<T> extends Validator<T> {
  const RequiredValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<T> control) {
    final error = <String, dynamic>{ValidationMessage.required: true};
    final value = control.value;

    if (value == null) {
      return error;
    } else if (value is String) {
      return value.trim().isEmpty ? error : null;
    }

    return null;
  }
}
