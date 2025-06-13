// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/gestures.dart';
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
/// class and [SwitchListTile], the constructor.
class ReactiveSwitchListTile extends ReactiveFocusableFormField<bool, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ///
  /// See also [CheckboxListTile]
  ReactiveSwitchListTile({
    super.key,
    super.formControlName,
    super.formControl,
    Color? tileColor,
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    Color? hoverColor,
    ImageProvider? activeThumbImage,
    ImageProvider? inactiveThumbImage,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool? dense,
    bool selected = false,
    bool autofocus = false,
    EdgeInsetsGeometry? contentPadding,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    ShapeBorder? shape,
    Color? selectedTileColor,
    VisualDensity? visualDensity,
    bool? enableFeedback,
    super.focusNode,
    ReactiveFormFieldCallback<bool>? onChanged,
    ImageErrorListener? onActiveThumbImageError,
    ImageErrorListener? onInactiveThumbImageError,
    WidgetStateProperty<Color?>? thumbColor,
    WidgetStateProperty<Color?>? trackColor,
    WidgetStateProperty<Color?>? trackOutlineColor,
    WidgetStateProperty<Icon?>? thumbIcon,
    MaterialTapTargetSize? materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    MouseCursor? mouseCursor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    ValueChanged<bool>? onFocusChange,
  }) : super(
         builder: (field) {
           return SwitchListTile(
             value: field.value ?? false,
             activeColor: activeColor,
             activeTrackColor: activeTrackColor,
             inactiveThumbColor: inactiveThumbColor,
             inactiveTrackColor: inactiveTrackColor,
             mouseCursor: mouseCursor,
             overlayColor: overlayColor,
             splashRadius: splashRadius,
             onFocusChange: onFocusChange,
             thumbColor: thumbColor,
             trackColor: trackColor,
             dragStartBehavior: dragStartBehavior,
             materialTapTargetSize: materialTapTargetSize,
             thumbIcon: thumbIcon,
             trackOutlineColor: trackOutlineColor,
             onActiveThumbImageError: onActiveThumbImageError,
             onInactiveThumbImageError: onInactiveThumbImageError,
             hoverColor: hoverColor,
             activeThumbImage: activeThumbImage,
             title: title,
             subtitle: subtitle,
             isThreeLine: isThreeLine,
             dense: dense,
             contentPadding: contentPadding,
             secondary: secondary,
             inactiveThumbImage: inactiveThumbImage,
             tileColor: tileColor,
             selected: selected,
             autofocus: autofocus,
             controlAffinity: controlAffinity,
             shape: shape,
             selectedTileColor: selectedTileColor,
             visualDensity: visualDensity,
             enableFeedback: enableFeedback,
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

  /// Creates a [ReactiveSwitchListTile] that wraps a Material [ListTile] with
  /// an adaptive [Switch], following Material design's
  /// [Cross-platform guidelines](https://material.io/design/platform-guidance/cross-platform-adaptation.html).
  ///
  /// This widget uses [Switch.adaptive] to change the graphics of the switch
  /// component based on the ambient [ThemeData.platform]. On iOS and macOS, a
  /// [CupertinoSwitch] will be used. On other platforms a Material design
  /// [Switch] will be used.
  ///
  /// If a [CupertinoSwitch] is created, the following parameters are
  /// ignored: [activeTrackColor], [inactiveThumbColor], [inactiveTrackColor],
  /// [activeThumbImage], [inactiveThumbImage].
  ///
  /// For documentation about the various parameters, see the
  /// [SwitchListTile.adaptive] constructor.
  ReactiveSwitchListTile.adaptive({
    super.key,
    super.formControlName,
    super.formControl,
    Color? activeColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
    ImageProvider? activeThumbImage,
    ImageErrorListener? onActiveThumbImageError,
    ImageProvider? inactiveThumbImage,
    ImageErrorListener? onInactiveThumbImageError,
    WidgetStateProperty<Color?>? thumbColor,
    WidgetStateProperty<Color?>? trackColor,
    WidgetStateProperty<Color?>? trackOutlineColor,
    WidgetStateProperty<Icon?>? thumbIcon,
    MaterialTapTargetSize? materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    MouseCursor? mouseCursor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    bool autofocus = false,
    bool? applyCupertinoTheme,
    EdgeInsetsGeometry? contentPadding,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    bool? dense,
    bool? enableFeedback,
    super.focusNode,
    ValueChanged<bool>? onFocusChange,
    Color? hoverColor,
    bool isThreeLine = false,
    Widget? secondary,
    bool selected = false,
    Color? selectedTileColor,
    ShapeBorder? shape,
    Widget? subtitle,
    Color? tileColor,
    Widget? title,
    VisualDensity? visualDensity,
    ReactiveFormFieldCallback<bool>? onChanged,
  }) : super(
         builder: (field) {
           return SwitchListTile.adaptive(
             value: field.value ?? false,
             activeColor: activeColor,
             activeTrackColor: activeTrackColor,
             inactiveThumbColor: inactiveThumbColor,
             inactiveTrackColor: inactiveTrackColor,
             activeThumbImage: activeThumbImage,
             onActiveThumbImageError: onActiveThumbImageError,
             inactiveThumbImage: inactiveThumbImage,
             onInactiveThumbImageError: onInactiveThumbImageError,
             thumbColor: thumbColor,
             trackColor: trackColor,
             trackOutlineColor: trackOutlineColor,
             thumbIcon: thumbIcon,
             materialTapTargetSize: materialTapTargetSize,
             dragStartBehavior: dragStartBehavior,
             mouseCursor: mouseCursor,
             overlayColor: overlayColor,
             splashRadius: splashRadius,
             autofocus: autofocus,
             applyCupertinoTheme: applyCupertinoTheme,
             contentPadding: contentPadding,
             controlAffinity: controlAffinity,
             dense: dense,
             enableFeedback: enableFeedback,
             focusNode: field.focusNode,
             onFocusChange: onFocusChange,
             hoverColor: hoverColor,
             isThreeLine: isThreeLine,
             secondary: secondary,
             selected: selected,
             selectedTileColor: selectedTileColor,
             shape: shape,
             subtitle: subtitle,
             tileColor: tileColor,
             title: title,
             visualDensity: visualDensity,
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
