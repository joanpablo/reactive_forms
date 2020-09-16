import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TimeOfDayValueAccessor extends ControlValueAccessor<TimeOfDay, String> {
  @override
  String modelToViewValue(TimeOfDay modelValue) {
    return modelValue == null ? '' : '${modelValue.hour}:${modelValue.minute}';
  }

  @override
  TimeOfDay viewToModelValue(String viewValue) {
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
}
