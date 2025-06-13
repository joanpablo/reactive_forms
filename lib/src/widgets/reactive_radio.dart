// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Radio] widget in a
/// [ReactiveRadio].
///
/// The [formControlName] is required to bind this [ReactiveRadio]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Radio] class
/// and [Radio], the constructor.
class ReactiveRadio<T> extends ReactiveFocusableFormField<T, T> {
  /// Creates a [ReactiveRadio] that contains a [Radio].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The [value] arguments is required. See [Radio] constructor.
  ///
  /// For documentation about the various parameters, see the [Radio] class
  /// and [Radio], the constructor.
  ReactiveRadio({
    super.key,
    super.formControlName,
    super.formControl,
    required T value,
    Color? activeColor,
    Color? focusColor,
    Color? hoverColor,
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? overlayColor,
    MouseCursor? mouseCursor,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    double? splashRadius,
    bool autofocus = false,
    bool toggleable = false,
    super.focusNode,
    ReactiveFormFieldCallback<T>? onChanged,
  }) : super(
         builder: (field) {
           return Radio<T>(
             value: value,
             groupValue: field.value,
             activeColor: activeColor,
             focusColor: focusColor,
             hoverColor: hoverColor,
             fillColor: fillColor,
             overlayColor: overlayColor,
             mouseCursor: mouseCursor,
             splashRadius: splashRadius,
             materialTapTargetSize: materialTapTargetSize,
             visualDensity: visualDensity,
             autofocus: autofocus,
             toggleable: toggleable,
             focusNode: field.focusNode,
             onChanged:
                 field.control.enabled
                     ? (value) {
                       field.didChange(value);
                       onChanged?.call(field.control);
                     }
                     : null,
           );
         },
       );
}
