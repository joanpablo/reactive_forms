// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

class DateTimeValueAccessor extends ControlValueAccessor<DateTime, String> {
  @override
  String modelToViewValue(DateTime modelValue) {
    return modelValue == null
        ? ''
        : '${modelValue.year}/${modelValue.month}/${modelValue.day}';
  }

  @override
  DateTime viewToModelValue(String viewValue) {
    if (viewValue == null) {
      return null;
    }

    final parts = viewValue.split('/');
    if (parts.length != 3) {
      return null;
    }

    return DateTime(
      int.parse(parts[0].trim()),
      int.parse(parts[1].trim()),
      int.parse(parts[2].trim()),
    );
  }
}
