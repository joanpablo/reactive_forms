// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
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
/// class and [SwitchListTile], the constructor.
class ReactiveSwitchListTile extends ReactiveFocusableFormField<bool, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ///
  /// See also [CheckboxListTile]
  ReactiveSwitchListTile({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<bool>? formControl,
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
    FocusNode? focusNode,
    ReactiveFormFieldCallback<bool>? onChanged,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          focusNode: focusNode,
          builder: (field) {
            return SwitchListTile(
              key: widgetKey,
              value: field.value ?? false,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
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
              onChanged: field.control.enabled
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
  ReactiveSwitchListTile.adaptative({
    Key? key,
    String? formControlName,
    FormControl<bool>? formControl,
    Color? activeColor,
    ImageProvider? activeThumbImage,
    Color? activeTrackColor,
    bool autofocus = false,
    EdgeInsetsGeometry? contentPadding,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    bool? dense,
    bool? enableFeedback,
    FocusNode? focusNode,
    Color? hoverColor,
    Color? inactiveThumbColor,
    ImageProvider? inactiveThumbImage,
    Color? inactiveTrackColor,
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
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          focusNode: focusNode,
          builder: (field) {
            return SwitchListTile.adaptive(
              value: field.value ?? false,
              activeColor: activeColor,
              activeThumbImage: activeThumbImage,
              activeTrackColor: activeTrackColor,
              autofocus: autofocus,
              contentPadding: contentPadding,
              controlAffinity: controlAffinity,
              dense: dense,
              enableFeedback: enableFeedback,
              focusNode: field.focusNode,
              hoverColor: hoverColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveThumbImage: inactiveThumbImage,
              inactiveTrackColor: inactiveTrackColor,
              isThreeLine: isThreeLine,
              secondary: secondary,
              selected: selected,
              selectedTileColor: selectedTileColor,
              shape: shape,
              subtitle: subtitle,
              tileColor: tileColor,
              title: title,
              visualDensity: visualDensity,
              onChanged: field.control.enabled
                  ? (value) {
                      field.didChange(value);
                      onChanged?.call(field.control);
                    }
                  : null,
            );
          },
        );
}
