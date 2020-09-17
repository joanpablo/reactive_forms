// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class DoubleValueAccessor extends ControlValueAccessor<double, String> {
  final int fractionDigits;

  DoubleValueAccessor({
    this.fractionDigits = 2,
  });

  @override
  String modelToViewValue(double modelValue) {
    return modelValue == null ? '' : modelValue.toStringAsFixed(fractionDigits);
  }

  @override
  double viewToModelValue(String viewValue) {
    return (viewValue == '' || viewValue == null)
        ? null
        : double.tryParse(viewValue);
  }
}
