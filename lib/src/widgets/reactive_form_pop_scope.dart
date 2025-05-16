// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

@optionalTypeArgs
class ReactiveFormPopScope<T> extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Determine whether a route can popped. See [PopScope] for more details.
  final ReactiveFormCanPopCallback? canPop;

  /// A callback invoked when a route is popped. See [PopScope] for more details.
  final ReactiveFormPopInvokedWithResultCallback<T>? onPopInvokedWithResult;

  const ReactiveFormPopScope({
    super.key,
    this.canPop,
    this.onPopInvokedWithResult,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (canPop == null && onPopInvokedWithResult == null) {
      return child;
    }

    return ReactiveFormConsumer(
      builder: (context, formGroup, _) {
        return PopScope<T>(
          canPop: canPop?.call(formGroup) ?? true,
          onPopInvokedWithResult: onPopInvokedWithResult != null
              ? (didPop, result) =>
                  onPopInvokedWithResult!(formGroup, didPop, result)
              : null,
          child: child,
        );
      },
    );
  }
}
