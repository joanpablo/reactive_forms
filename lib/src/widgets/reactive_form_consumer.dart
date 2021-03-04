// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Builder function definition of the [ReactiveFormConsumer] builder.
///
/// See also [ReactiveFormConsumer].
typedef ReactiveFormConsumerBuilder = Widget Function(
    BuildContext context, FormGroup formGroup, Widget? child);

/// Obtains [FormGroup] from its ancestors and passes its value to [builder].
///
/// The [ReactiveFormConsumerBuilder] widget doesn't do any fancy work.
/// It just calls [ReactiveForm.of] in a new widget, and delegates its `build`
/// implementation to [builder].
///
/// [builder] must not be null and may be called multiple times (such as when
/// the [FormGroup] validity change).
///
/// The ReactiveFormConsumerBuilder has two main responsibilities:
/// - Obtains the nearest [FormGroup] from its ancestors.
/// - Register the current context with the changes in the [FormGroup]
///   so that if the validity of the [FormGroup] change then the current
///   context is rebuilt.
class ReactiveFormConsumer extends StatelessWidget {
  final Widget? child;
  final ReactiveFormConsumerBuilder builder;

  /// Creates an instance of the [ReactiveFormConsumer]
  /// [builder] must not be null.
  ///
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [FormGroup] that is bind
  /// with this widget.
  const ReactiveFormConsumer({
    Key? key,
    required this.builder,
    this.child,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.builder(context, ReactiveForm.of(context) as FormGroup, this.child);
  }
}
