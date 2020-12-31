// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormattedDateTimeValueAccessor
    extends ControlValueAccessor<DateTime, String> {
  final DateFormat dateTimeFormat;

  FormattedDateTimeValueAccessor(this.dateTimeFormat);

  @override
  String modelToViewValue(modelValue) {
    return modelValue == null ? '' : dateTimeFormat.format(modelValue);
  }

  @override
  DateTime viewToModelValue(viewValue) {
    return viewValue == null || viewValue.trim().isEmpty
        ? null
        : dateTimeFormat.parse(viewValue);
  }
}
