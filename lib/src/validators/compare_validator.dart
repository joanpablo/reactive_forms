// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Represents a [FormGroup] validator that compares two controls in the group.
class CompareValidator extends Validator {
  final String controlName;
  final String compareControlName;
  final CompareOption compareOption;

  /// Constructs an instance of the validator.
  ///
  /// The arguments [controlName], [compareControlName] and [compareOption]
  /// must not be null.
  CompareValidator(
      this.controlName, this.compareControlName, this.compareOption)
      : assert(controlName != null),
        assert(compareControlName != null),
        assert(compareOption != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final form = control as FormGroup;
    if (form == null) {
      return {ValidationMessage.compare: true};
    }

    final mainControl = form.control(this.controlName);
    final compareControl = form.control(this.compareControlName);
    final error = {
      ValidationMessage.compare: {
        'control': mainControl.value,
        'compareControl': compareControl.value,
        'option': this.compareOption,
      }
    };

    if (!(mainControl.value is Comparable) ||
        !(compareControl.value is Comparable)) {
      return error;
    }

    if (_meetsComparison(mainControl, compareControl)) {
      mainControl.removeError(ValidationMessage.compare);
    } else {
      mainControl.setErrors(error);
      mainControl.markAsTouched();
    }

    return null;
  }

  bool _meetsComparison(AbstractControl<dynamic> control,
      AbstractControl<dynamic> compareControl) {
    switch (this.compareOption) {
      case CompareOption.lower:
        return control.value < compareControl.value;
      case CompareOption.lower_or_equal:
        return control.value <= compareControl.value;
      case CompareOption.greater:
        return control.value > compareControl.value;
      case CompareOption.greater_or_equal:
        return control.value >= compareControl.value;
      default: //CompareOption.equal:
        return control.value == compareControl.value;
    }
  }
}
