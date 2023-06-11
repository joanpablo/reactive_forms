// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// validator that requires the control's value to be less than or equal to a
/// provided value.
class MaxValidator<T> extends Validator<T> {
  final T max;

  /// Constructs the instance of the validator.
  ///
  /// The argument [max] must not be null.
  const MaxValidator(this.max) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<T> control) {
    final value = control.value;
    final error = {
      ValidationMessage.max: <String, dynamic>{
        'max': max,
        'actual': value,
      },
    };

    if (value == null) {
      return error;
    }

    assert(value is Comparable<dynamic>,
        'The MinValidator validator is expecting a control of type `Comparable` but received a control of type ${control.value.runtimeType}');

    final comparableValue = value as Comparable<dynamic>;
    return comparableValue.compareTo(max) <= 0 ? null : error;
  }
}
