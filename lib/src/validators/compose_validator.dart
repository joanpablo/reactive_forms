// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Compose multiple validators into a single function.
///
/// If at least one validator returns 'null' then the compose validator
/// returns 'null', otherwise returns the union of the individual error
/// maps returned by each validator.
class ComposeValidator extends Validator<dynamic> {
  final List<ValidatorFunction> validators;

  /// Constructs an instance of the validator.
  ///
  /// The argument [validators] must not be null.
  ComposeValidator(this.validators);

  @override
  Map<String, Object>? validate(AbstractControl<dynamic> control) {
    final composedError = Map<String, Object>();

    for (final validator in this.validators) {
      final error = validator(control);
      if (error != null) {
        composedError.addAll(error);
      }
    }

    return composedError.isEmpty ? null : composedError;
  }
}
