// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Represents a [FormGroup] validator that compares two controls in the group.
class CompareValidator<T> extends Validator<T> {
  final String controlName;
  final String compareControlName;
  final CompareOption compareOption;

  /// Constructs an instance of the validator.
  ///
  /// The arguments [controlName], [compareControlName] and [compareOption]
  /// must not be null.
  const CompareValidator(
    this.controlName,
    this.compareControlName,
    this.compareOption,
  ) : super();

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

    if (compareOption == CompareOption.equal &&
        mainControl.isNull &&
        compareControl.isNull) {
      return null;
    } else if (mainControl.isNull || compareControl.isNull) {
      mainControl.setErrors(error);
      return null;
    } else if (mainControl.value is! Comparable<dynamic>) {
      throw ValidatorException(
          'Control "$controlName" must be of type "Comparable"');
    }

    try {
      final meetsComparison = _meetsComparison(
        mainControl.value as Comparable<dynamic>,
        compareControl.value,
      );

      if (meetsComparison) {
        mainControl.removeError(ValidationMessage.compare);
      } else {
        mainControl.setErrors(error);
        mainControl.markAsTouched();
      }

      return null;
    } on TypeError {
      throw ValidatorException(
          'Can\'t compare control "$controlName" of type "${mainControl.value.runtimeType}" with the control "$compareControlName" of type ${compareControl.value.runtimeType}');
    }
  }

  bool _meetsComparison(Comparable<dynamic> value, dynamic compareValue) {
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
