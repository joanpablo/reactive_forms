// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/form_control_inherited_notifier.dart';
import 'package:reactive_forms/src/widgets/reactive_form_pop_scope.dart';

/// FormGroup builder function definition of the [ReactiveFormBuilder].
typedef ReactiveFormBuilderCreator = FormGroup Function();

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormGroup] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to rebuild
/// context each time the [FormGroup.status] changes.
class ReactiveFormBuilder extends StatefulWidget {
  /// Called to obtain the child widget.
  final ReactiveFormConsumerBuilder builder;

  /// Called to create the FormGroup that will be bind to this widget.
  final ReactiveFormBuilderCreator form;

  /// Determine whether a route can popped. See [PopScope] for more details.
  final bool Function(FormGroup formGroup)? canPop;

  /// A callback invoked when a route is popped. See [PopScope] for more details.
  final void Function(FormGroup formGroup, bool didPop)? onPopInvoked;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Creates and instance of [ReactiveFormBuilder].
  ///
  /// The [form] and [builder] arguments must not be null.
  ///
  /// ### Example:
  /// ```dart
  /// class MyWidget extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return ReactiveFormBuilder(
  ///       form: (context) => FormGroup({'name': FormControl<String>()}),
  ///       builder: (context, form, child) {
  ///         return ReactiveTextField(
  ///           formControlName: 'name',
  ///         );
  ///       },
  ///     );
  ///   }
  /// }
  /// ```
  const ReactiveFormBuilder({
    Key? key,
    required this.form,
    required this.builder,
    this.canPop,
    this.onPopInvoked,
    this.child,
  }) : super(key: key);

  @override
  ReactiveFormBuilderState createState() => ReactiveFormBuilderState();
}

class ReactiveFormBuilderState extends State<ReactiveFormBuilder> {
  late FormGroup _form;

  @override
  void initState() {
    _form = widget.form();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.builder(context, _form, widget.child);
    return ReactiveForm(
      formGroup: _form,
      child: widget.canPop != null || widget.onPopInvoked != null
          ? ReactiveFormPopScope(
              canPop: widget.canPop,
              onPopInvoked: widget.onPopInvoked,
              child: child,
            )
          : child,
    );
  }
}
