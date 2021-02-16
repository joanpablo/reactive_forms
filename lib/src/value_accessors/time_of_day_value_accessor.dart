// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that convert between data types
/// [TimeOfDay] and [String].
class TimeOfDayValueAccessor extends ControlValueAccessor<TimeOfDay, String> {
  @override
  String modelToViewValue(TimeOfDay? modelValue) {
    return modelValue == null
        ? ''
        : '${modelValue.hour}:${_addLeadingZeroIfNeeded(modelValue.minute)}';
  }

  @override
  TimeOfDay? viewToModelValue(String? viewValue) {
    if (viewValue == null) {
      return null;
    }

    final parts = viewValue.split(':');
    if (parts.length != 2) {
      return null;
    }

    return TimeOfDay(
      hour: int.parse(parts[0].trim()),
      minute: int.parse(parts[1].trim()),
    );
  }

  String _addLeadingZeroIfNeeded(int value) =>
      (value < 10) ? '0$value' : value.toString();
}
