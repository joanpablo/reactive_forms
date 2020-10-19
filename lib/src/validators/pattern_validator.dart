// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to match a regex pattern.
class PatternValidator extends Validator<dynamic> {
  final Pattern pattern;

  /// Constructs an instance of [PatternValidator].
  ///
  /// The [pattern] argument must not be null.
  PatternValidator(this.pattern) : assert(pattern != null);

  @override
  Map<String, dynamic> validate(AbstractControl<dynamic> control) {
    RegExp regex = new RegExp(this.pattern);
    return (control.value == null ||
            control.value.toString() == '' ||
            regex.hasMatch(control.value.toString()))
        ? null
        : {
            ValidationMessage.pattern: {
              'requiredPattern': this.pattern.toString(),
              'actualValue': control.value,
            }
          };
  }
}
