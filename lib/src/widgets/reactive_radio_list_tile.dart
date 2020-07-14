// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [RadioListTile] widget in a
/// [ReactiveRadioListTile].
///
/// The [formControlName] is required to bind this [ReactiveRadioListTile]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [RadioListTile]
/// class and [new RadioListTile], the constructor.
class ReactiveRadioListTile<T> extends ReactiveFormField<T> {
  /// Create an instance of a [ReactiveRadioListTile].
  ///
  /// The [formControlName] arguments must not be null.
  ///
  /// See also [RadioListTile]
  ReactiveRadioListTile({
    Key key,
    @required formControlName,
    @required T value,
    Color activeColor,
    Widget title,
    Widget subtitle,
    bool isThreeLine = false,
    bool dense,
    Widget secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
  }) : super(
          key: key,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<T> field) {
            return RadioListTile<T>(
              value: value,
              groupValue: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              title: title,
              subtitle: subtitle,
              isThreeLine: isThreeLine,
              dense: dense,
              secondary: secondary,
              controlAffinity: controlAffinity,
            );
          },
        );

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}
