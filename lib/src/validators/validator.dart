// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// An interface implemented by classes that perform synchronous validation.
abstract class Validator<T> {
  Map<String, Object>? validate(AbstractControl<T> control);
}
