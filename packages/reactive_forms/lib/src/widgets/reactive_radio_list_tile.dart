// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/reactive_form_field.dart';

/// This is a convenience widget that wraps a [RadioListTile] widget in a
/// [ReactiveRadioListTile].
///
/// The [formControlName] is required to bind this [ReactiveRadioListTile]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [RadioListTile]
/// class and [new RadioListTile], the constructor.
class ReactiveRadioListTile<T> extends ReactiveFormField<T, T> {
  /// Create an instance of a [ReactiveRadioListTile].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// See also [RadioListTile]
  ReactiveRadioListTile({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    required T value,
    Color? activeColor,
    Color? selectedTileColor,
    Color? tileColor,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool? dense,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    EdgeInsetsGeometry? contentPadding,
    bool toggleable = false,
    ShapeBorder? shape,
    bool autofocus = false,
    bool selected = false,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<T, T> field) {
            return RadioListTile<T>(
              value: value,
              groupValue: field.value,
              onChanged: field.control.enabled ? field.didChange : null,
              activeColor: activeColor,
              selectedTileColor: selectedTileColor,
              tileColor: tileColor,
              title: title,
              subtitle: subtitle,
              isThreeLine: isThreeLine,
              dense: dense,
              secondary: secondary,
              controlAffinity: controlAffinity,
              contentPadding: contentPadding,
              toggleable: toggleable,
              shape: shape,
              selected: selected,
              autofocus: autofocus,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}
