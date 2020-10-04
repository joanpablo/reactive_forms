// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// This exception is thrown by [FormBuilder] when trying to create
/// controls with bad initialization params.
class FormBuilderInvalidInitializationException implements Exception {
  final String message;

  /// Create an instance of the exception with the specified [message]
  FormBuilderInvalidInitializationException(this.message);

  /// Returns the string representation of the exception.
  String toString() {
    return "FormBuilderInvalidInitializationException: $message";
  }
}
