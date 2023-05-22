// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

abstract class AsyncValidator<T> {
  const AsyncValidator();

  Future<Map<String, dynamic>?> validate(AbstractControl<T> control);

  Future<Map<String, dynamic>?> call(AbstractControl<T> control) {
    return validate(control);
  }
}