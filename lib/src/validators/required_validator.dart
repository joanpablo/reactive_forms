// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control have a non-empty value.
class RequiredValidator extends Validator<dynamic> {
  const RequiredValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{ValidationMessage.required: true};

    if (control.value == null) {
      return error;
    } else if (control.value case String string) {
      return string.trim().isEmpty ? error : null;
    } else if (control.value case Map value) {
      return value.isEmpty ? error : null;
    } else if (control.value case Iterable value) {
      return value.isEmpty ? error : null;
    }

    return null;
  }
}
