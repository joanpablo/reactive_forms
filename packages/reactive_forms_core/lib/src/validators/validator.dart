// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms_core/src/models/models.dart';

/// An interface implemented by classes that perform synchronous validation.
abstract class Validator<T> {
  Map<String, dynamic>? validate(AbstractControl<T> control);
}

/// Signature of a function that receives a control and synchronously
/// returns a map of validation errors if present, otherwise null.
typedef ValidatorFunction = Map<String, dynamic>? Function(
    AbstractControl<dynamic> control);

/// Signature of a function that receives a control and returns a Future
/// that emits validation errors if present, otherwise null.
typedef AsyncValidatorFunction = Future<Map<String, dynamic>?> Function(
    AbstractControl<dynamic> control);
