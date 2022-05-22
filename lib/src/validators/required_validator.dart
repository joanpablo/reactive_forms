// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control have a non-empty value.
class RequiredValidator<T> extends Validator<T> {
  const RequiredValidator([String? message]) : super(message);

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

  static String get messageKey1 => 'required';

  @override
  String get messageKey => RequiredValidator.messageKey1;
}
