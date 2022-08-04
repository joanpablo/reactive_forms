// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [RadioListTile] widget in a
/// [ReactiveRadioListTile].
///
/// The [formControlName] is required to bind this [ReactiveRadioListTile]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [RadioListTile]
/// class and [RadioListTile], the constructor.
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
    VisualDensity? visualDensity,
    FocusNode? focusNode,
    bool? enableFeedback,
    ReactiveFormFieldCallback<T>? onChanged,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (field) {
            final state = field as _ReactiveRadioListTileState<T, T>;

            state._setFocusNode(focusNode);

            return RadioListTile<T>(
              value: value,
              groupValue: field.value,
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
              visualDensity: visualDensity,
              focusNode: state.focusNode,
              enableFeedback: enableFeedback,
              onChanged: field.control.enabled
                  ? (value) {
                      field.didChange(value);
                      onChanged?.call(field.control);
                    }
                  : null,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, T> createState() =>
      _ReactiveRadioListTileState<T, T>();
}

class _ReactiveRadioListTileState<T, V> extends ReactiveFormFieldState<T, V> {
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
