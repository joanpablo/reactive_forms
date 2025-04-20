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
  final ReactiveFormPopInvokedCallback? onPopInvoked;

  /// A callback invoked when a route is popped. See [PopScope] for more details.
  final ReactiveFormPopInvokedWithResultCallback<T>? onPopInvokedWithResult;

  const ReactiveFormPopScope({
    super.key,
    this.canPop,
    @Deprecated('Use onPopInvokedWithResult instead.') this.onPopInvoked,
    this.onPopInvokedWithResult,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (canPop == null &&
        onPopInvoked == null &&
        onPopInvokedWithResult == null) {
      return child;
    }

    return ReactiveFormConsumer(
      builder: (context, formGroup, _) {
        return PopScope<T>(
          canPop: canPop?.call(formGroup) ?? true,
          onPopInvokedWithResult: _buildOnPopInvokedCallback(formGroup),
          child: child,
        );
      },
    );
  }

  /// Builds the onPopInvoked callback based on the available callbacks.
  PopInvokedWithResultCallback<T>? _buildOnPopInvokedCallback(
    FormGroup formGroup,
  ) {
    if (onPopInvokedWithResult != null) {
      return (didPop, result) =>
          onPopInvokedWithResult!(formGroup, didPop, result);
    }

    if (onPopInvoked != null) {
      return (didPop, _) => onPopInvoked!(formGroup, didPop);
    }

    return null;
  }
}
