// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/form_control_inherited_notifier.dart';

/// FormGroup builder function definition of the [ReactiveFormBuilder].
typedef ReactiveFormBuilderCreator = FormGroup Function();

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormGroup] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to rebuild
/// context each time the [FormGroup.status] changes.
///
/// The optional type argument `T` allows for specifying the type of result that
/// can be returned when a route associated with this form is popped.
@optionalTypeArgs
class ReactiveFormBuilder<T> extends StatefulWidget {
  /// Called to obtain the child widget.
  final ReactiveFormConsumerBuilder builder;

  /// Called to create the FormGroup that will be bind to this widget.
  final ReactiveFormBuilderCreator form;

  /// Determine whether a route can be popped. See [PopScope] for more details.
  final ReactiveFormCanPopCallback? canPop;

  /// A callback invoked when a route is popped. See [PopScope] for more details.
  ///
  /// This uses the type argument `T` to define the type of the result. If `T`
  /// is not specified, it defaults to `dynamic`. This parameter is optional
  /// and allows for handling results with specific data types when a route is
  /// popped.
  final ReactiveFormPopInvokedWithResultCallback<T>? onPopInvokedWithResult;

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
  /// ### Example: Allows the route to be popped only if the form is valid.
  /// ```dart
  /// class MyWidget extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return ReactiveFormBuilder(
  ///       form: (context) => FormGroup({'name': FormControl<String>()}),
  ///       canPop: (formGroup) => formGroup.valid
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
    super.key,
    required this.form,
    required this.builder,
    this.canPop,
    this.onPopInvokedWithResult,
    this.child,
  });

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
    return ReactiveForm(
      formGroup: _form,
      canPop: widget.canPop,
      onPopInvokedWithResult: widget.onPopInvokedWithResult,
      child: widget.builder(context, _form, widget.child),
    );
  }
}
