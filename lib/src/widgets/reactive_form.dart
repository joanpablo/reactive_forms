// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/form_control_inherited_notifier.dart';

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormGroup] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to rebuild
/// context each time the [FormGroup.status] changes.
///
/// The optional type argument `T` allows for specifying the type of result that
/// can be returned when a route associated with this form is popped.
@optionalTypeArgs
class ReactiveForm<T> extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The form group control that is bound to this widget.
  final FormGroup formGroup;

  /// Determine whether a route can popped. See [PopScope] for more details.
  final ReactiveFormCanPopCallback? canPop;

  /// A callback invoked when a route is popped. See [PopScope] for more details.
  ///
  /// This uses the type argument `T` to define the type of the result. If `T`
  /// is not specified, it defaults to `dynamic`. This parameter is optional
  /// and allows for handling results with specific data types when a route is
  /// popped.
  final ReactiveFormPopInvokedWithResultCallback<T>? onPopInvokedWithResult;

  /// Creates and instance of [ReactiveForm].
  ///
  /// The [formGroup] and [child] arguments are required.
  const ReactiveForm({
    super.key,
    required this.formGroup,
    required this.child,
    this.canPop,
    this.onPopInvokedWithResult,
  });

  /// Returns the nearest model up its widget tree.
  ///
  /// If [listen] is `true` (default value), all the dependents widgets
  /// will rebuild each time the model change.
  ///
  /// `listen: false` is necessary if want to avoid rebuilding the
  /// [context] when model changes.
  static AbstractControl<Object>? of(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<FormControlInheritedStreamer>()
          ?.control;
    }

    final element =
        context
            .getElementForInheritedWidgetOfExactType<
              FormControlInheritedStreamer
            >();
    return element == null
        ? null
        : (element.widget as FormControlInheritedStreamer).control;
  }

  @override
  Widget build(BuildContext context) {
    return FormControlInheritedStreamer(
      control: formGroup,
      stream: formGroup.statusChanged,
      child: PopScope<T>(
        canPop: canPop?.call(formGroup) ?? true,
        onPopInvokedWithResult:
            onPopInvokedWithResult != null
                ? (didPop, result) =>
                    onPopInvokedWithResult!(formGroup, didPop, result)
                : null,
        child: child,
      ),
    );
  }
}
