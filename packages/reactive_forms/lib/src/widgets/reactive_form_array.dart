// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

/// Called to obtain the child widget.
/// This is the signature of a function that receives the [context],
/// the [formArray] and an optional [child] and returns a [Widget].
///
typedef ReactiveFormArrayBuilder<T> = Widget Function(
    BuildContext context, FormArray<T> formArray, Widget? child);

/// This class is responsible for create a [FormControlInheritedStreamer] for
/// exposing a [FormArray] to all descendants widgets.
///
/// It also configures the inner [FormControlInheritedStreamer] to refresh
/// context each time the [FormArray] append or remove new controls.
///
class ReactiveFormArray<T> extends StatefulWidget {
  final String? formArrayName;
  final FormArray<T>? formArray;
  final Widget? child;
  final ReactiveFormArrayBuilder<T> builder;

  /// Creates an instance of [ReactiveFormArray].
  ///
  /// The [builder] argument is required.
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [FormArray] that is bind
  /// with this widget.
  const ReactiveFormArray({
    Key? key,
    required this.builder,
    this.formArrayName,
    this.formArray,
    this.child,
  })  : assert(
            (formArrayName != null && formArray == null) ||
                (formArrayName == null && formArray != null),
            'Must provide a formArrayName or a formArray, but not both at the same time.'),
        super(key: key);

  @override
  _ReactiveFormArrayState<T> createState() => _ReactiveFormArrayState<T>();
}

class _ReactiveFormArrayState<T> extends State<ReactiveFormArray<T>> {
  late FormArray<T> _formArray;

  @override
  void didChangeDependencies() {
    if (widget.formArray != null) {
      _formArray = widget.formArray!;
    } else {
      final form =
          ReactiveForm.of(context, listen: false) as FormControlCollection;
      _formArray = form.control(widget.formArrayName!) as FormArray<T>;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FormControlInheritedStreamer(
      control: _formArray,
      stream: _formArray.collectionChanges,
      child: Builder(
        builder: (context) {
          return widget.builder(
            context,
            ReactiveForm.of(context) as FormArray<T>,
            widget.child,
          );
        },
      ),
    );
  }
}
