// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Represents the [AnyValidator] test function definition.
typedef AnyValidatorFunctionTest<T> = bool Function(T value);

/// Represents a validator that requires any element of the control's iterable
/// value satisfies [test].
class AnyValidator<T> extends Validator<dynamic> {
  final AnyValidatorFunctionTest<T> test;

  /// Constructs an instance of the validator.
  ///
  /// The argument [test] must not be null.
  const AnyValidator(this.test) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.value == null) {
      return <String, dynamic>{ValidationMessage.any: true};
    }

    assert(
      control.value is Iterable<T>,
      '''Expected the control value to be of type ${(Iterable<T>).runtimeType}
        but found type ${control.value.runtimeType.toString()}.''',
    );

    final iterable = control.value as Iterable<T>;
    return iterable.any(test)
        ? null
        : <String, dynamic>{ValidationMessage.any: true};
  }
}
