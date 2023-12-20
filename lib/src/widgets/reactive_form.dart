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
class ReactiveForm extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The form group control that is bound to this widget.
  final FormGroup formGroup;

  /// Creates and instance of [ReactiveForm].
  ///
  /// The [formGroup] and [child] arguments are required.
  const ReactiveForm({
    Key? key,
    required this.formGroup,
    required this.child,
  }) : super(key: key);

  /// Returns the nearest model up its widget tree.
  ///
  /// If [listen] is `true` (default value), all the dependents widgets
  /// will rebuild each time the model change.
  ///
  /// `listen: false` is necessary if want to avoid rebuilding the
  /// [context] when model changes.
  static AbstractControl<Object>? of(BuildContext context,
      {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<FormControlInheritedStreamer>()
          ?.control;
    }

    final element = context.getElementForInheritedWidgetOfExactType<
        FormControlInheritedStreamer>();
    return element == null
        ? null
        : (element.widget as FormControlInheritedStreamer).control;
  }

  @override
  Widget build(BuildContext context) {
    return FormControlInheritedStreamer(
      control: formGroup,
      stream: formGroup.statusChanged,
      child: child,
    );
  }
}
