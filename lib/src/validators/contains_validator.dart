// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's array contains all provided values.
class ContainsValidator<T> extends Validator<Iterable<dynamic>> {
  final List<T> values;

  /// Constructs the instance of the validator.
  ///
  /// The argument [values] must not be null.
  ContainsValidator(this.values) : assert(values != null);

  @override
  Map<String, dynamic> validate(AbstractControl<Iterable<dynamic>> control) {
    final error = {ValidationMessage.contain: true};

    // error if value is not a List
    if (control.value == null || control.value != null && !(control.value is List<T>)) {
      return error;
    }

    return values.every((value) => control.value.contains(value))
        ? null
        : error;
  }
}
