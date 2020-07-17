// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [CheckboxListTile] widget in a
/// [ReactiveCheckboxListTile].
///
/// The [formControlName] is required to bind this [ReactiveCheckboxListTile]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [CheckboxListTile]
/// class and [new CheckboxListTile], the constructor.
class ReactiveCheckboxListTile extends ReactiveFormField {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ///
  /// See also [CheckboxListTile]
  ReactiveCheckboxListTile({
    Key key,
    @required String formControlName,
    Color activeColor,
    Color checkColor,
    Widget title,
    Widget subtitle,
    bool isThreeLine = false,
    bool dense,
    Widget secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
  }) : super(
          key: key,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState field) {
            return CheckboxListTile(
              value: field.value ?? false,
              onChanged: field.didChange,
              activeColor: activeColor,
              checkColor: checkColor,
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
  ReactiveFormFieldState createState() => ReactiveFormFieldState();
}
