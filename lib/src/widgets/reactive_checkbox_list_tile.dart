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
class ReactiveCheckboxListTile extends ReactiveFormField<bool, bool> {
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
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (field) {
            final state = field as _ReactiveCheckboxListTileState<bool, bool>;

            state._setFocusNode(focusNode);

            return CheckboxListTile(
              value: tristate ? field.value : field.value ?? false,
              onChanged: field.control.enabled ? field.didChange : null,
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
              focusNode: state.focusNode,
              enableFeedback: enableFeedback,
              checkboxShape: checkboxShape,
              side: side,
            );
          },
        );

  @override
  ReactiveFormFieldState<bool, bool> createState() =>
      _ReactiveCheckboxListTileState<bool, bool>();
}

class _ReactiveCheckboxListTileState<T, V>
    extends ReactiveFormFieldState<T, V> {
  FocusNode? _focusNode;
  late FocusController _focusController;

  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
