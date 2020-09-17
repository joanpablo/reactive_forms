// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Exception that is raised by [ControlValueAccessor]
class ValueAccessorException implements Exception {
  final String message;

  /// Constructs an instance of the exception with the provided [message].
  ValueAccessorException(this.message);

  @override
  String toString() {
    return 'ValueAccessorException: $message';
  }
}
