// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [SwitchListTile] widget in a
/// [ReactiveSwitchListTile].
///
/// The [formControlName] is required to bind this [ReactiveSwitchListTile]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [SwitchListTile]
/// class and [new SwitchListTile], the constructor.
class ReactiveSwitchListTile extends ReactiveFormField {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ///
  /// See also [CheckboxListTile]
  ReactiveSwitchListTile({
    Key key,
    @required String formControlName,
    Color activeColor,
    Color activeTrackColor,
    Color inactiveThumbColor,
    Color inactiveTrackColor,
    ImageProvider activeThumbImage,
    ImageProvider inactiveThumbImage,
    Widget title,
    Widget subtitle,
    bool isThreeLine = false,
    bool dense,
    EdgeInsetsGeometry contentPadding,
    Widget secondary,
  }) : super(
          key: key,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState field) {
            return SwitchListTile(
              value: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              title: title,
              subtitle: subtitle,
              isThreeLine: isThreeLine,
              dense: dense,
              contentPadding: contentPadding,
              secondary: secondary,
              inactiveThumbImage: inactiveThumbImage,
            );
          },
        );

  @override
  ReactiveFormFieldState createState() => ReactiveFormFieldState();
}
