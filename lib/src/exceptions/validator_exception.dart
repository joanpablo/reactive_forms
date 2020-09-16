// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Exception that is raised by [Validator]
class ValidatorException implements Exception {
  final String message;

  /// Constructs an instance of the exception with the provided [message].
  ValidatorException(this.message);

  @override
  String toString() {
    return 'ValidatorException: $message';
  }
}
