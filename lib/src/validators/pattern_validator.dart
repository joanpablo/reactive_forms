// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/pattern/pattern_evaluator.dart';

/// Validator that requires the control's value to match a regex pattern.
class PatternValidator extends Validator<dynamic> {
  final PatternEvaluator evaluator;
  final String validationMessage;

  /// Constructs an instance of [PatternValidator].
  ///
  /// The [evaluator] argument must not be null.
  PatternValidator(this.evaluator,
      {this.validationMessage = ValidationMessage.pattern});

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return (control.value == null ||
            control.value.toString() == '' ||
            evaluator.hasMatch(control.value.toString()))
        ? null
        : <String, dynamic>{
            validationMessage: {
              'requiredPattern': evaluator.pattern,
              'actualValue': control.value as Object,
            }
          };
  }
}
