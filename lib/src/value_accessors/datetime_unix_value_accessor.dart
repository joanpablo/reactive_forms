// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that convert between data types
/// [DateTime] and [int] or [double] representing unix date time.
class DateTimeUnixValueAccessor<T> extends ControlValueAccessor<T, String> {
  final DateFormat dateTimeFormat;

  DateTimeUnixValueAccessor({DateFormat? dateTimeFormat})
      : dateTimeFormat = dateTimeFormat ?? DateFormat('yyyy/MM/dd');

  @override
  String modelToViewValue(T? modelValue) {
    if (modelValue == null) {
      return '';
    }
    if (modelValue is int) {
      return dateTimeFormat
          .format(DateTime.fromMillisecondsSinceEpoch(modelValue));
    } else if (modelValue is double) {
      return dateTimeFormat
          .format(DateTime.fromMillisecondsSinceEpoch(modelValue.toInt()));
    }
    throw ValueAccessorException(
        'UnixDateTimeValueAccessor supports only int or double values');
  }

  @override
  T? viewToModelValue(String? viewValue) {
    return viewValue == null || viewValue.trim().isEmpty
        ? null
        : dateTimeFormat.parse(viewValue).millisecondsSinceEpoch as T;
  }
}
