// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [CheckboxListTile] widget in a
/// [ReactiveCheckboxListTile].
class ReactiveCheckboxListTile extends ReactiveFocusableFormField<bool, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// For documentation about the various parameters, see the [CheckboxListTile]
  /// class and the [CheckboxListTile] constructor.
  ReactiveCheckboxListTile({
    super.key,
    super.formControlName,
    super.formControl,
    Color? activeColor,
    Color? checkColor,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool selected = false,
    bool? dense,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    bool autofocus = false,
    EdgeInsetsGeometry? contentPadding,
    bool tristate = false,
    Color? selectedTileColor,
    Color? tileColor,
    ShapeBorder? shape,
    VisualDensity? visualDensity,
    super.focusNode,
    bool? enableFeedback,
    String? checkboxSemanticLabel,
    OutlinedBorder? checkboxShape,
    BorderSide? side,
    ReactiveFormFieldCallback<bool>? onChanged,
    MouseCursor? mouseCursor,
    WidgetStateProperty<Color?>? fillColor,
    Color? hoverColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    ValueChanged<bool>? onFocusChange,
    double checkboxScaleFactor = 1.0,
    ShowErrorsFunction<bool>? showErrors,
  }) : super(
         showErrors:
             showErrors ??
             (control) => control.invalid && (control.dirty || control.touched),
         builder: (field) {
           return CheckboxListTile(
             value: tristate ? field.value : field.value ?? false,
             mouseCursor: mouseCursor,
             fillColor: fillColor,
             hoverColor: hoverColor,
             overlayColor: overlayColor,
             materialTapTargetSize: materialTapTargetSize,
             splashRadius: splashRadius,
             activeColor: activeColor,
             checkColor: checkColor,
             onFocusChange: onFocusChange,
             isError: field.errorText != null,
             title: title,
             subtitle: subtitle,
             isThreeLine: isThreeLine,
             dense: dense,
             secondary: secondary,
             controlAffinity: controlAffinity,
             autofocus: autofocus,
             contentPadding: contentPadding,
             tristate: tristate,
             selectedTileColor: selectedTileColor,
             tileColor: tileColor,
             shape: shape,
             selected: selected,
             visualDensity: visualDensity,
             focusNode: field.focusNode,
             enableFeedback: enableFeedback,
             checkboxSemanticLabel: checkboxSemanticLabel,
             checkboxScaleFactor: checkboxScaleFactor,
             checkboxShape: checkboxShape,
             side: side,
             enabled: field.control.enabled,
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
