// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class MinValidator<T> extends Validator<T> {
  final T min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  const MinValidator(this.min) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<T> control) {
    final value = control.value;

    final error = {
      ValidationMessage.min: <String, dynamic>{
        'min': min,
        'actual': value,
      },
    };

    if (value == null) {
      return error;
    }

    assert(value is Comparable<dynamic>,
        'The MinValidator validator is expecting a control of type `Comparable` but received a control of type ${control.value.runtimeType}');

    final comparableValue = value as Comparable<dynamic>;

    return comparableValue.compareTo(min) >= 0 ? null : error;
  }
}
