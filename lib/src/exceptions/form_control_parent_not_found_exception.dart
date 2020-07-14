// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// This exception is thrown by Reactive Widgets that doesn't find a
/// parent widget [ReactiveForm] or [ReactiveFormArray] in the widgets tree.
class FormControlParentNotFoundException implements Exception {
  Widget widget;

  /// Creates an instance of the exception
  /// passing the widget that throws the exception.
  FormControlParentNotFoundException(this.widget);

  @override
  String toString() {
    return 'FormControlParentNotFoundException: ReactiveFormField widget couldn\'t find a parent widget. An instance of ${widget.runtimeType.toString()} widget must be under a ReactiveForm or a ReactiveFormArray in the widgets tree.';
  }
}
