// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Signature of a function that receives a control and synchronously
/// returns a map of validation errors if present, otherwise null.
typedef ValidatorFunction =
    Map<String, dynamic>? Function(AbstractControl<dynamic> control);

/// Validator that delegates the validation to an external function.
class DelegateValidator extends Validator<dynamic> {
  final ValidatorFunction _validator;

  /// Creates an instance of the [DelegateValidator] class.
  ///
  /// The [DelegateValidator] validator delegates the validation to the
  /// external [validator] function.
  const DelegateValidator(ValidatorFunction validator)
    : _validator = validator,
      super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return _validator(control);
  }
}
