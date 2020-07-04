// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/models/abstract_control.dart';

abstract class Validator<T> {
  Map<String, dynamic> validate(AbstractControl<T> value);
}
