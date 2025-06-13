// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Signature of a function that receives a control and returns a Future
/// that emits validation errors if present, otherwise null.
typedef AsyncValidatorFunction =
    Future<Map<String, dynamic>?> Function(AbstractControl<dynamic> control);

/// Validator that delegates the validation to an external function.
class DelegateAsyncValidator extends AsyncValidator<dynamic> {
  final AsyncValidatorFunction _asyncValidator;

  /// Creates an instance of the [DelegateAsyncValidator] class.
  ///
  /// The [DelegateAsyncValidator] validator delegates the validation to the
  /// external asynchronous [validator] function.
  const DelegateAsyncValidator(AsyncValidatorFunction asyncValidator)
    : _asyncValidator = asyncValidator,
      super();

  @override
  Future<Map<String, dynamic>?> validate(AbstractControl<dynamic> control) {
    return _asyncValidator(control);
  }
}
