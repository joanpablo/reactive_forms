// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Checkbox] widget in a
/// [ReactiveCheckbox].
///
/// Can optionally provide a [formControl] to bind this widget to a control.
///
/// Can optionally provide a [formControlName] to bind this ReactiveFormField
/// to a [FormControl].
///
/// Must provide one of the arguments [formControl] or a [formControlName],
/// but not both at the same time.
///
/// For documentation about the various parameters, see the [Checkbox] class
/// and [new Checkbox], the constructor.
class ReactiveCheckbox extends ReactiveFormField<bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ReactiveCheckbox({
    Key key,
    String formControlName,
    FormControl formControl,
    bool tristate = false,
    Color activeColor,
    Color checkColor,
    Color focusColor,
    Color hoverColor,
    MaterialTapTargetSize materialTapTargetSize,
    VisualDensity visualDensity,
    bool autofocus = false,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: const {},
          builder: (ReactiveFormFieldState<bool> field) {
            return Checkbox(
              value: field.value ?? false,
              onChanged: field.control.enabled ? field.didChange : null,
              tristate: tristate,
              activeColor: activeColor,
              checkColor: checkColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              materialTapTargetSize: materialTapTargetSize,
              visualDensity: visualDensity,
              autofocus: autofocus,
            );
          },
        );

  @override
  ReactiveFormFieldState<bool> createState() => ReactiveFormFieldState<bool>();
}
