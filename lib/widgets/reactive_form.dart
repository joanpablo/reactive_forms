// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_group.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/widgets/form_control_inherited_notifier.dart';

///This class is responsible for create an [FormGroupInheritedNotifier] for
///exposing a [FormGroup] to all descendants widgets. It also
///brings a mechanism to dispose when the [ReactiveForm] disposes itself.
class ReactiveForm extends StatefulWidget {
  final Widget child;
  final FormGroup formGroup;

  const ReactiveForm({
    Key key,
    @required this.formGroup,
    @required this.child,
  })  : assert(formGroup != null),
        assert(child != null),
        super(key: key);

  /// Returns the nearest model up its widget tree
  ///
  /// If [listen] is `true` (default value), all the dependents widgets
  /// will rebuild
  ///
  /// `rebuildContext: false` is necessary if want to avoid rebuilding the
  /// [context] when model changes:
  static AbstractControl of(BuildContext context, {bool listen: true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<FormControlInheritedNotifier>()
          .control;
    }

    final element = context.getElementForInheritedWidgetOfExactType<
        FormControlInheritedNotifier>();
    return (element.widget as FormControlInheritedNotifier).control;
  }

  @override
  _ReactiveFormState createState() => _ReactiveFormState();
}

class _ReactiveFormState extends State<ReactiveForm> {
  @override
  Widget build(BuildContext context) {
    return FormControlInheritedNotifier(
      control: widget.formGroup,
      notifierDelegate: () => widget.formGroup.onStatusChanged,
      child: widget.child,
    );
  }
}
