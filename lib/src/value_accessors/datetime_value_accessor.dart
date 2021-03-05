// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that convert between data types
/// [DateTime] and [String].
class DateTimeValueAccessor extends ControlValueAccessor<DateTime, String> {
  final DateFormat dateTimeFormat;

  DateTimeValueAccessor({DateFormat? dateTimeFormat})
      : dateTimeFormat = dateTimeFormat ?? DateFormat('yyyy/MM/dd');

  @override
  String modelToViewValue(DateTime? modelValue) {
    return modelValue == null ? '' : dateTimeFormat.format(modelValue);
  }

  @override
  DateTime? viewToModelValue(String? viewValue) {
    return viewValue == null || viewValue.trim().isEmpty
        ? null
        : dateTimeFormat.parse(viewValue);
  }
}
