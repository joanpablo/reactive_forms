// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is the signature to determine whether a route can popped.
/// See [PopScope] for more details.
typedef ReactiveFormCanPopCallback = bool Function(FormGroup formGroup);

/// This is the signature of the callback invoked when a route is popped.
/// See [PopScope] for more details.
typedef ReactiveFormPopInvokedCallback = void Function(
    FormGroup formGroup, bool didPop);

class ReactiveFormPopScope extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Determine whether a route can popped. See [PopScope] for more details.
  final ReactiveFormCanPopCallback? canPop;

  /// A callback invoked when a route is popped. See [PopScope] for more details.
  final ReactiveFormPopInvokedCallback? onPopInvoked;

  const ReactiveFormPopScope({
    super.key,
    this.canPop,
    this.onPopInvoked,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (canPop == null && onPopInvoked == null) {
      return child;
    }

    return ReactiveFormConsumer(
      builder: (context, formGroup, _) {
        return PopScope(
          canPop: canPop?.call(formGroup) ?? true,
          onPopInvoked: onPopInvoked != null
              ? (didPop) => onPopInvoked!(formGroup, didPop)
              : null,
          child: child,
        );
      },
    );
  }
}
