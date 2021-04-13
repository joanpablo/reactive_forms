// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's array contains all provided values.
class ContainsValidator<T> extends Validator<dynamic> {
  final List<T> values;

  /// Constructs the instance of the validator.
  ///
  /// The argument [values] must not be null.
  ContainsValidator(this.values);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    assert(
        control is AbstractControl<Iterable<T>> ||
            control is AbstractControl<Iterable<T?>>,
        'Expected a control of type AbstractControl<Iterable<$T>> or AbstractControl<Iterable<$T?>>');

    final iterableControl = control as AbstractControl<Iterable<dynamic>>;
    return iterableControl.value != null &&
            values.every(iterableControl.value!.contains)
        ? null
        : <String, dynamic>{ValidationMessage.contains: true};
  }
}
