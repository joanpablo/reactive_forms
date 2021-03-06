// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/form_control_inherited_notifier.dart';

typedef ReactiveFormBuilderCreator = FormGroup Function();

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormGroup] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to rebuild
/// context each time the [FormGroup.status] changes.
class ReactiveFormBuilder extends StatefulWidget {
  final ReactiveFormConsumerBuilder builder;
  final ReactiveFormBuilderCreator form;
  final Widget child;

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
  final WillPopCallback onWillPop;

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
    Key key,
    this.child,
    this.onWillPop,
    required this.builder,
    required this.form,
  })   : assert(form != null),
        assert(builder != null),
        super(key: key);

  @override
  _ReactiveFormBuilderState createState() => _ReactiveFormBuilderState();
}

class _ReactiveFormBuilderState extends State<ReactiveFormBuilder> {
  FormGroup _form;

  @override
  void initState() {
    _form = widget.form();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: widget.builder(context, _form, widget.child),
      onWillPop: widget.onWillPop,
    );
  }
}
