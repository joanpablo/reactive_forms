// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Checkbox] widget in a
/// [ReactiveCheckbox].
class ReactiveCheckbox extends ReactiveFocusableFormField<bool, bool> {
  /// Create an instance of a [ReactiveCheckbox].
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
  /// and the [Checkbox] constructor.
  ReactiveCheckbox({
    super.key,
    super.formControlName,
    super.formControl,
    bool tristate = false,
    Color? activeColor,
    Color? checkColor,
    Color? focusColor,
    Color? hoverColor,
    MouseCursor? mouseCursor,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    bool autofocus = false,
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    super.focusNode,
    OutlinedBorder? shape,
    BorderSide? side,
    String? semanticLabel,
    ReactiveFormFieldCallback<bool>? onChanged,
    ShowErrorsFunction<bool>? showErrors,
  }) : super(
         showErrors:
             showErrors ??
             (control) => control.invalid && (control.dirty || control.touched),
         builder: (field) {
           return Checkbox(
             value: tristate ? field.value : field.value ?? false,
             tristate: tristate,
             mouseCursor: mouseCursor,
             activeColor: activeColor,
             checkColor: checkColor,
             focusColor: focusColor,
             hoverColor: hoverColor,
             materialTapTargetSize: materialTapTargetSize,
             visualDensity: visualDensity,
             autofocus: autofocus,
             fillColor: fillColor,
             overlayColor: overlayColor,
             splashRadius: splashRadius,
             focusNode: field.focusNode,
             shape: shape,
             side: side,
             isError: field.errorText != null,
             onChanged:
                 field.control.enabled
                     ? (value) {
                       field.didChange(value);
                       onChanged?.call(field.control);
                     }
                     : null,
             semanticLabel: semanticLabel,
           );
         },
       );
}
