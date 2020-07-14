// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../widgets/form_control_inherited_notifier.dart';

/// Called to obtain the child widget.
/// This is the signature of a function that receives the [context],
/// the [formArray] and an optional [child] and returns a [Widget].
///
typedef ReactiveFormArrayBuilder = Widget Function(
    BuildContext context, FormArray formArray, Widget child);

/// This class is responsible for create a [FormControlInheritedNotifier] for
/// exposing a [FormArray] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedNotifier] to refresh
/// context each time the [FormArray] append or remove new controls.
///
class ReactiveFormArray extends StatefulWidget {
  final String formArrayName;
  final Widget child;
  final ReactiveFormArrayBuilder builder;

  /// Creates an instance of [ReactiveFormArray].
  ///
  /// The [formArrayName] and [builder] arguments are required.
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [FormArray] that is bind
  /// with this widget.
  const ReactiveFormArray({
    Key key,
    @required this.formArrayName,
    @required this.builder,
    this.child,
  })  : assert(formArrayName != null),
        assert(builder != null),
        super(key: key);

  @override
  _ReactiveFormArrayState createState() => _ReactiveFormArrayState();
}

class _ReactiveFormArrayState extends State<ReactiveFormArray> {
  FormArray _formArray;

  @override
  void initState() {
    final form =
        ReactiveForm.of(context, listen: false) as FormControlCollection;
    _formArray = form.formControl(widget.formArrayName) as FormArray;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormControlInheritedNotifier(
      control: _formArray,
      notifierDelegate: () => _formArray.onCollectionChanged,
      child: Builder(builder: (context) {
        return widget.builder(context, ReactiveForm.of(context), widget.child);
      }),
    );
  }
}
