// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// An abstract class extended by classes that perform asynchronous validation.
abstract class AsyncValidator<T> {
  const AsyncValidator();

  /// Validates the [control].
  Future<Map<String, dynamic>?> validate(AbstractControl<T> control);

  Future<Map<String, dynamic>?> call(AbstractControl<T> control) {
    return validate(control);
  }
}
