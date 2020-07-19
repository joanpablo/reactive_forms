// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
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
/// and [new Radio], the constructor.
class ReactiveRadio<T> extends ReactiveFormField<T> {
  /// Creates a [ReactiveRadio] that contains a [Radio].
  ///
  /// The [formControlName] is required to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// The [value] arguments is required. See [Radio] constructor.
  ///
  /// For documentation about the various parameters, see the [Radio] class
  /// and [new Radio], the constructor.
  ReactiveRadio({
    Key key,
    @required String formControlName,
    @required T value,
    Color activeColor,
    Color focusColor,
    Color hoverColor,
    MaterialTapTargetSize materialTapTargetSize,
    VisualDensity visualDensity,
    bool autofocus = false,
  }) : super(
          key: key,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<T> field) {
            return Radio<T>(
              value: value,
              groupValue: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              materialTapTargetSize: materialTapTargetSize,
              visualDensity: visualDensity,
              autofocus: autofocus,
            );
          },
        );

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}
