// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/exceptions/control_cast_exception.dart';

import '../widgets/form_control_inherited_notifier.dart';

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormGroup] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to rebuild
/// context each time the [FormGroup.status] changes.
class ReactiveForm extends StatelessWidget {
  final Widget child;
  final FormGroup formGroup;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback? onWillPop;

  /// Creates and instance of [ReactiveForm].
  ///
  /// The [formGroup] and [child] arguments are required.
  const ReactiveForm({
    Key? key,
    required this.formGroup,
    required this.child,
    this.onWillPop,
  }) : super(key: key);

  /// Returns the nearest model up its widget tree
  ///
  /// If [listen] is `true` (default value), all the dependents widgets
  /// will rebuild each time the model change.
  ///
  /// `listen: false` is necessary if want to avoid rebuilding the
  /// [context] when model changes:
  static F? of<F extends AbstractControl<dynamic>>(BuildContext context,
      {bool listen = true}) {
    if (listen) {
      final control = context
          .dependOnInheritedWidgetOfExactType<FormControlInheritedStreamer>()
          ?.control;
      if (control is! F?) {
        throw ControlCastException<F>(control);
      }

      return control as F?;
    }

    final element = context.getElementForInheritedWidgetOfExactType<
        FormControlInheritedStreamer>();
    final control = element == null
        ? null
        : (element.widget as FormControlInheritedStreamer).control;

    if (control is! F?) {
      throw ControlCastException<F>(control);
    }

    return control as F?;
  }

  @override
  Widget build(BuildContext context) {
    return FormControlInheritedStreamer(
      control: formGroup,
      stream: formGroup.statusChanged,
      child: WillPopScope(
        onWillPop: onWillPop,
        child: child,
      ),
    );
  }
}
