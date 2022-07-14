// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Radio] widget in a
/// [ReactiveRadio].
///
/// The [formControlName] is required to bind this [ReactiveRadio]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Radio] class
/// and [Radio], the constructor.
class ReactiveRadio<T> extends ReactiveFormField<T, T> {
  /// Creates a [ReactiveRadio] that contains a [Radio].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The [value] arguments is required. See [Radio] constructor.
  ///
  /// For documentation about the various parameters, see the [Radio] class
  /// and [Radio], the constructor.
  ReactiveRadio({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    required T value,
    Color? activeColor,
    Color? focusColor,
    Color? hoverColor,
    MaterialStateProperty<Color?>? fillColor,
    MaterialStateProperty<Color?>? overlayColor,
    MouseCursor? mouseCursor,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    double? splashRadius,
    bool autofocus = false,
    bool toggleable = false,
    FocusNode? focusNode,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (field) {
            final state = field as _ReactiveRadioState<T, T>;

            state._setFocusNode(focusNode);

            return Radio<T>(
              value: value,
              groupValue: field.value,
              onChanged: field.control.enabled ? field.didChange : null,
              activeColor: activeColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              fillColor: fillColor,
              overlayColor: overlayColor,
              mouseCursor: mouseCursor,
              splashRadius: splashRadius,
              materialTapTargetSize: materialTapTargetSize,
              visualDensity: visualDensity,
              autofocus: autofocus,
              toggleable: toggleable,
              focusNode: state.focusNode,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, T> createState() => _ReactiveRadioState<T, T>();
}

class _ReactiveRadioState<T, V> extends ReactiveFormFieldState<T, V> {
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
