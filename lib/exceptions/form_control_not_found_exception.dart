// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// This exception is thrown by Reactive Widgets that doesn't find a FormControl
/// to bind
class FormControlNotFoundException implements Exception {
  final String formControlName;

  /// Creates an instance of the exception
  /// passing the name of the form control
  FormControlNotFoundException(this.formControlName);

  @override
  String toString() {
    return 'FormControlNotFoundException: ReactiveFormField widget couldn\'t bind to FormControl, the name: \'$formControlName\' not found!';
  }
}
