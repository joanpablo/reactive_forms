// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

class CompareValidator extends Validator {
  final String controlName;
  final String compareControlName;
  final CompareOption compareOption;

  CompareValidator(
      this.controlName, this.compareControlName, this.compareOption)
      : assert(controlName != null),
        assert(compareControlName != null),
        assert(compareOption != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final form = control as FormGroup;
    if (form == null) {
      throw ValidatorException('[CompareValidator] must validate a FormGroup');
    }

    final mainControl = form.control(this.controlName);
    final compareControl = form.control(this.compareControlName);
    final error = {
      'compare': {
        'control': mainControl.value,
        'compareControl': compareControl.value,
        'option': this.compareOption,
      }
    };

    if (!(mainControl.value is Comparable) ||
        !(compareControl.value is Comparable)) {
      return error;
    }

    switch (this.compareOption) {
      case CompareOption.lower:
        return mainControl.value < compareControl.value ? null : error;
      case CompareOption.lower_or_equal:
        return mainControl.value <= compareControl.value ? null : error;
      case CompareOption.greater:
        return mainControl.value > compareControl.value ? null : error;
      case CompareOption.greater_or_equal:
        return mainControl.value >= compareControl.value ? null : error;
      default: //CompareOption.equal:
        return mainControl.value == compareControl.value ? null : error;
    }
  }
}
