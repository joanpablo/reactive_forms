// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's array contains all provided values.
class ContainsValidator<T> extends Validator<Iterable<T>> {
  final List<T> values;

  /// Constructs the instance of the validator.
  ///
  /// The argument [values] must not be null.
  const ContainsValidator(this.values) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<Iterable<T>> control) {
    final value = control.value;

    return value != null &&
            values.every(value.contains)
        ? null
        : <String, dynamic>{ValidationMessage.contains: true};
  }
}
