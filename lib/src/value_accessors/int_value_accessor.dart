// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

/// Represents a control value accessor that convert between data types
/// [int] and [String].
class IntValueAccessor extends ControlValueAccessor<int, String> {
  @override
  String modelToViewValue(int? modelValue) {
    return modelValue == null ? '' : modelValue.toString();
  }

  @override
  int? viewToModelValue(String? viewValue) {
    return (viewValue == '' || viewValue == null)
        ? null
        : int.tryParse(viewValue);
  }
}
