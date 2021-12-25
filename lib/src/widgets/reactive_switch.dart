// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Switch] widget in a
/// [ReactiveSwitch].
///
/// Can optionally provide a [formControl] to bind this widget to a control.
///
/// Can optionally provide a [formControlName] to bind this ReactiveFormField
/// to a [FormControl].
///
/// Must provide one of the arguments [formControl] or a [formControlName],
/// but not both at the same time.
///
/// For documentation about the various parameters, see the [Switch] class
/// and [Switch], the constructor.
class ReactiveSwitch extends ReactiveFormField<bool, bool> {
  /// Creates a [ReactiveSwitch] that wraps a material design switch.
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// For documentation about the various parameters, see the [Switch] class
  /// and [Switch], the constructor.
  ReactiveSwitch({
    Key? key,
    String? formControlName,
    FormControl<bool>? formControl,
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    ImageProvider? activeThumbImage,
    ImageErrorListener? onActiveThumbImageError,
    ImageProvider? inactiveThumbImage,
    ImageErrorListener? onInactiveThumbImageError,
    MaterialTapTargetSize? materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color? focusColor,
    Color? hoverColor,
    bool autofocus = false,
    MaterialStateProperty<Color?>? thumbColor,
    MaterialStateProperty<Color?>? trackColor,
    MouseCursor? mouseCursor,
    MaterialStateProperty<Color?>? overlayColor,
    double? splashRadius,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<bool, bool> field) {
            return Switch(
              value: field.value ?? false,
              onChanged: field.control.enabled ? field.didChange : null,
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
              thumbColor: thumbColor,
              trackColor: trackColor,
              mouseCursor: mouseCursor,
              overlayColor: overlayColor,
              splashRadius: splashRadius,
              // focusNode: focusNode - requires more time
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
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The target platform is based on the current [Theme]: [ThemeData.platform].
  ///
  /// For documentation about the various parameters, see the [Switch.adaptive]
  /// constructor.
  ReactiveSwitch.adaptive({
    Key? key,
    String? formControlName,
    FormControl<bool>? formControl,
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    ImageProvider? activeThumbImage,
    ImageErrorListener? onActiveThumbImageError,
    ImageProvider? inactiveThumbImage,
    ImageErrorListener? onInactiveThumbImageError,
    MaterialTapTargetSize? materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color? focusColor,
    Color? hoverColor,
    bool autofocus = false,
    MaterialStateProperty<Color?>? thumbColor,
    MaterialStateProperty<Color?>? trackColor,
    MaterialStateProperty<Color?>? overlayColor,
    MouseCursor? mouseCursor,
    double? splashRadius,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<bool, bool> field) {
            return Switch.adaptive(
              value: field.value ?? false,
              onChanged: field.control.enabled ? field.didChange : null,
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
              thumbColor: thumbColor,
              trackColor: trackColor,
              mouseCursor: mouseCursor,
              overlayColor: overlayColor,
              splashRadius: splashRadius,
              autofocus: autofocus,
              // focusNode: focusNode - requires more time
            );
          },
        );

  @override
  ReactiveFormFieldState<bool, bool> createState() =>
      ReactiveFormFieldState<bool, bool>();
}
