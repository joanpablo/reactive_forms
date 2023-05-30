// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [CheckboxListTile] widget in a
/// [ReactiveCheckboxListTile].
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
/// class and [CheckboxListTile], the constructor.
class ReactiveCheckboxListTile extends ReactiveFocusableFormField<bool, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ///
  /// See also [CheckboxListTile]
  ReactiveCheckboxListTile({
    Key? key,
    String? formControlName,
    FormControl<bool>? formControl,
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
    FocusNode? focusNode,
    bool? enableFeedback,
    OutlinedBorder? checkboxShape,
    BorderSide? side,
    ReactiveFormFieldCallback<bool>? onChanged,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          focusNode: focusNode,
          builder: (field) {
            return CheckboxListTile(
              value: tristate ? field.value : field.value ?? false,
              activeColor: activeColor,
              checkColor: checkColor,
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
              checkboxShape: checkboxShape,
              side: side,
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
