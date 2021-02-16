// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [SwitchListTile] widget in a
/// [ReactiveSwitchListTile].
///
/// Can optionally provide a [formControl] to bind this widget to a control.
///
/// Can optionally provide a [formControlName] to bind this ReactiveFormField
/// to a [FormControl].
///
/// Must provide one of the arguments [formControl] or a [formControlName],
/// but not both at the same time.
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
    Key? key,
    String? formControlName,
    FormControl? formControl,
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    ImageProvider? activeThumbImage,
    ImageProvider? inactiveThumbImage,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool? dense,
    EdgeInsetsGeometry? contentPadding,
    Widget? secondary,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState field) {
            return SwitchListTile(
              value: field.value,
              onChanged: field.control.enabled ? field.didChange : null,
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
