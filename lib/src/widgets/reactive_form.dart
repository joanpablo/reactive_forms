// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../widgets/form_control_inherited_notifier.dart';

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormGroup] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to rebuild
/// context each time the [FormGroup.status] changes.
class ReactiveForm extends StatefulWidget {
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
  static AbstractControl<Object>? of(BuildContext context,
      {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<FormControlInheritedStreamer>()
          ?.control;
    }

    final element = context.getElementForInheritedWidgetOfExactType<
        FormControlInheritedStreamer>();
    return (element?.widget as FormControlInheritedStreamer).control;
  }

  @override
  _ReactiveFormState createState() => _ReactiveFormState();
}

/// Represents the state of the [ReactiveForm] stateful widget.
class _ReactiveFormState extends State<ReactiveForm> {
  @override
  Widget build(BuildContext context) {
    return FormControlInheritedStreamer(
      control: widget.formGroup,
      stream: widget.formGroup.statusChanged,
      child: WillPopScope(
        onWillPop: widget.onWillPop,
        child: widget.child,
      ),
    );
  }
}
