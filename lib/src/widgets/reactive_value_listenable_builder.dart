// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A widget whose content stays synced with a [ValueListenable].
///
/// This widget is a wrapper around [ValueListenableBuilder] widget
/// that binds to a [FormControl] and stay synced with changes
/// in the control. The form control is specified with the [formControlName]
/// constructor argument.
///
/// See [ValueListenableBuilder] documentation for more information
///
class ReactiveValueListenableBuilder<T> extends StatelessWidget {
  /// The name of the control bound to this widgets.
  final String? formControlName;

  /// The control bound to this widgets.
  final AbstractControl<T>? formControl;

  /// Optionally child widget.
  final Widget? child;

  /// The builder that creates a widget depending on the value of the control.
  final ReactiveListenableWidgetBuilder<T> builder;

  /// Create an instance of a [ReactiveValueListenableBuilder].
  ///
  /// Must provide a [forControlName] or a [formControl] but not both
  /// at the same time.
  ///
  /// The [builder] arguments must not be null.
  ///
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [FormControl] that is bind
  /// with this widget.
  const ReactiveValueListenableBuilder({
    Key? key,
    required this.builder,
    this.formControlName,
    this.formControl,
    this.child,
  })  : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var control = formControl;
    if (control == null) {
      final form = ReactiveForm.of(context, listen: false);
      if (form is! FormControlCollection) {
        throw FormControlParentNotFoundException(this);
      }
      // TODO handling should be optimized
      // ignore: cast_nullable_to_non_nullable
      final collection = form as FormControlCollection;
      control = collection.control(formControlName!) as AbstractControl<T>;
    }

    return StreamBuilder<T?>(
      stream: control.valueChanges,
      builder: (context, snapshot) => builder(context, control!, child),
    );
  }
}
