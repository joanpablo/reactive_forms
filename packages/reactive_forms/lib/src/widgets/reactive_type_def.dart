// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

/// This is the definition of the builder function used in the widgets
/// [ReactiveStatusListenableBuilder] and [ReactiveValueListenableBuilder].
typedef ReactiveListenableWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AbstractControl<T> control,
  Widget? child,
);
