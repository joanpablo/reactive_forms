// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Switch] widget in a
/// [ReactiveSwitch].
///
/// The [formControlName] is required to bind this [ReactiveSwitch]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Switch] class
/// and [new Switch], the constructor.
class ReactiveSwitch extends ReactiveFormField<bool> {
  /// Creates a [ReactiveSwitch] that wraps a material design switch.
  ///
  /// The [formControlName] is required to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// For documentation about the various parameters, see the [Switch] class
  /// and [new Switch], the constructor.
  ///
  ReactiveSwitch({
    Key key,
    @required String formControlName,
    Color activeColor,
    Color activeTrackColor,
    Color inactiveThumbColor,
    Color inactiveTrackColor,
    ImageProvider activeThumbImage,
    ImageErrorListener onActiveThumbImageError,
    ImageProvider inactiveThumbImage,
    ImageErrorListener onInactiveThumbImageError,
    MaterialTapTargetSize materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color focusColor,
    Color hoverColor,
    bool autofocus = false,
  }) : super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<bool> field) {
            return Switch(
              key: key,
              value: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              onActiveThumbImageError: onActiveThumbImageError,
              inactiveThumbImage: inactiveThumbImage,
              onInactiveThumbImageError: onInactiveThumbImageError,
              materialTapTargetSize: materialTapTargetSize,
              dragStartBehavior: dragStartBehavior,
              focusColor: focusColor,
              hoverColor: hoverColor,
              autofocus: autofocus,
            );
          },
        );

  /// Creates a [ReactiveSwitch] that wraps a [CupertinoSwitch] if the
  /// target platform is iOS, creates a material design switch otherwise.
  ///
  /// If a [CupertinoSwitch] is created, the following parameters are
  /// ignored: [activeTrackColor], [inactiveThumbColor], [inactiveTrackColor],
  /// [activeThumbImage], [onActiveThumbImageError], [inactiveThumbImage],
  /// [onInactiveImageThumbError], [materialTapTargetSize].
  ///
  /// The target platform is based on the current [Theme]: [ThemeData.platform].
  ///
  /// For documentation about the various parameters, see the [Switch.adaptive]
  /// constructor.
  ///
  ReactiveSwitch.adaptive({
    Key key,
    @required String formControlName,
    Color activeColor,
    Color activeTrackColor,
    Color inactiveThumbColor,
    Color inactiveTrackColor,
    ImageProvider activeThumbImage,
    ImageErrorListener onActiveThumbImageError,
    ImageProvider inactiveThumbImage,
    ImageErrorListener onInactiveThumbImageError,
    MaterialTapTargetSize materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color focusColor,
    Color hoverColor,
  }) : super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<bool> field) {
            return Switch.adaptive(
              key: key,
              value: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              onActiveThumbImageError: onActiveThumbImageError,
              inactiveThumbImage: inactiveThumbImage,
              onInactiveThumbImageError: onInactiveThumbImageError,
              materialTapTargetSize: materialTapTargetSize,
              dragStartBehavior: DragStartBehavior.start,
              focusColor: focusColor,
              hoverColor: hoverColor,
            );
          },
        );

  @override
  ReactiveFormFieldState<bool> createState() => ReactiveFormFieldState<bool>();
}
