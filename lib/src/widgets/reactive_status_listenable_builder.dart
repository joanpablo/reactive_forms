// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This widget listen for changes in the status of a [FormControl] specified
/// in [formControlName] property and call [builder] function to rebuild widgets.
///
/// This widget is just a wrapper around [ValueListenableBuilder]
/// that listen [AbstractControl.statusChanged]
///
class ReactiveStatusListenableBuilder extends StatelessWidget {
  /// The name of the control bound to this widgets
  final String? formControlName;

  // The control bound to this widget
  final AbstractControl<dynamic>? formControl;

  /// Optionally child widget
  final Widget? child;

  /// The builder that creates a widget depending on the status of the control.
  final ReactiveListenableWidgetBuilder<dynamic> builder;

  /// Creates an instance of [ReactiveStatusListenableBuilder].
  ///
  /// The [builder] function must not be null.
  ///
  /// Must provide a [forControlName] or a [formControl] but not both
  /// at the same time.
  ///
  const ReactiveStatusListenableBuilder({
    Key? key,
    this.formControlName,
    this.formControl,
    required this.builder,
    this.child,
  })  : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractControl<dynamic>? control = this.formControl;

    if (control == null) {
      final form =
          ReactiveForm.of(context, listen: false) as FormControlCollection;
      control = form.control(this.formControlName!);
    }

    return StreamBuilder<ControlStatus>(
      stream: control?.statusChanged,
      builder: (context, snapshot) => this.builder(context, control!, child),
    );
  }
}
