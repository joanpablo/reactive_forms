// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to not be null or empty.
class RequiredNonEmptyValidator extends Validator<dynamic> {
  const RequiredNonEmptyValidator() : super();
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{ValidationMessage.requiredNonEmpty: true};
    final dynamic value = control.value;

    if (value == null) {
      return error;
    } else if (value is String) {
      return value.trim().isEmpty ? error : null;
    } else if (value is Iterable && value.isEmpty) {
      return error;
    } else if (value is Map && value.isEmpty) {
      return error;
    } else if (value is Set && value.isEmpty) {
      return error;
    }

    return null;
  }
}
