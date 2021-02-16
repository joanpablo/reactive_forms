// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/pattern/pattern_evaluator.dart';

/// Validator that requires the control's value to match a regex pattern.
class PatternValidator extends Validator<dynamic> {
  final PatternEvaluator evaluator;

  /// Constructs an instance of [PatternValidator].
  ///
  /// The [evaluator] argument must not be null.
  PatternValidator(this.evaluator);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return (control.value == null ||
            control.value.toString() == '' ||
            this.evaluator.hasMatch(control.value.toString()))
        ? null
        : {
            ValidationMessage.pattern: {
              'requiredPattern': this.evaluator.pattern,
              'actualValue': control.value,
            }
          };
  }
}
