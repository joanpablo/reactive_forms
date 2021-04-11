// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Represents a [FormGroup] validator that compares two controls in the group.
class CompareValidator<T> extends Validator<dynamic> {
  final String controlName;
  final String compareControlName;
  final CompareOption compareOption;

  /// Constructs an instance of the validator.
  ///
  /// The arguments [controlName], [compareControlName] and [compareOption]
  /// must not be null.
  CompareValidator(
    this.controlName,
    this.compareControlName,
    this.compareOption,
  );

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control is! FormGroup) {
      // Maybe throw an exception is better
      return <String, dynamic>{ValidationMessage.compare: true};
    }

    final mainControl = control.control(controlName);
    final compareControl = control.control(compareControlName);
    final error = {
      ValidationMessage.compare: <String, dynamic>{
        'control': mainControl.value,
        'compareControl': compareControl.value,
        'option': compareOption,
      }
    };

    if (mainControl.value is! Comparable<T> || compareControl.value is! T) {
      return error;
    }

    if (_meetsComparison(
        mainControl.value as Comparable<T>, compareControl.value as T)) {
      mainControl.removeError(ValidationMessage.compare);
    } else {
      mainControl.setErrors(error);
      mainControl.markAsTouched();
    }

    return null;
  }

  bool _meetsComparison(Comparable<T> value, T compareValue) {
    switch (compareOption) {
      case CompareOption.lower:
        return value.compareTo(compareValue) < 0;
      case CompareOption.lowerOrEqual:
        return value.compareTo(compareValue) <= 0;
      case CompareOption.greater:
        return value.compareTo(compareValue) > 0;
      case CompareOption.greaterOrEqual:
        return value.compareTo(compareValue) >= 0;
      default: //CompareOption.equal:
        return value.compareTo(compareValue) == 0;
    }
  }
}
