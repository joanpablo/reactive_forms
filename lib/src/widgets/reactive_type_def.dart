// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is the definition of the builder function used in the widgets
/// [ReactiveStatusListenableBuilder] and [ReactiveValueListenableBuilder].
typedef ReactiveListenableWidgetBuilder<T> =
    Widget Function(
      BuildContext context,
      AbstractControl<T> control,
      Widget? child,
    );

/// This is the signature to determine whether a route can popped.
/// See [PopScope] for more details.
typedef ReactiveFormCanPopCallback = bool Function(FormGroup formGroup);

/// This is the signature of the callback invoked when a route is popped.
/// See [PopScope] for more details.
typedef ReactiveFormPopInvokedCallback =
    void Function(FormGroup formGroup, bool didPop);

typedef ReactiveFormPopInvokedWithResultCallback<T> =
    void Function(FormGroup formGroup, bool didPop, T? result);
