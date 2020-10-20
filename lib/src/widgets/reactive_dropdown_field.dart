// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A reactive widget that wraps a [DropdownButton].
class ReactiveDropdownField<T> extends ReactiveFormField<T> {
  /// Creates a [DropdownButton] widget wrapped in an [InputDecorator].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The [DropdownButton] [items] parameters must not be null.
  ReactiveDropdownField({
    Key key,
    String formControlName,
    FormControl formControl,
    @required List<DropdownMenuItem<T>> items,
    ValidationMessagesFunction validationMessages,
    ShowErrorsFunction showErrors,
    DropdownButtonBuilder selectedItemBuilder,
    Widget hint,
    VoidCallback onTap,
    InputDecoration decoration = const InputDecoration(),
    Widget disabledHint,
    int elevation = 8,
    TextStyle style,
    Widget icon,
    Color iconDisabledColor,
    Color iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double itemHeight,
    ValueChanged<T> onChanged,
  })  : assert(items != null),
        assert(decoration != null),
        assert(elevation != null),
        assert(iconSize != null),
        assert(isDense != null),
        assert(isExpanded != null),
        assert(itemHeight == null || itemHeight > 0),
        super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (ReactiveFormFieldState field) {
            final state = field as _ReactiveDropdownFieldState<T>;

            final InputDecoration effectiveDecoration =
                decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            T effectiveValue = field.value;
            if (effectiveValue != null &&
                !items.any((item) => item.value == effectiveValue)) {
              effectiveValue = null;
            }

            return InputDecorator(
              decoration:
                  effectiveDecoration.copyWith(errorText: field.errorText),
              isEmpty: effectiveValue == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: effectiveValue,
                  items: items,
                  selectedItemBuilder: selectedItemBuilder,
                  hint: hint,
                  onChanged: field.control.enabled
                      ? (T value) => state._onChanged(value, onChanged)
                      : null,
                  onTap: onTap,
                  disabledHint: disabledHint,
                  elevation: elevation,
                  style: style,
                  icon: icon,
                  iconDisabledColor: iconDisabledColor,
                  iconEnabledColor: iconEnabledColor,
                  iconSize: iconSize,
                  isDense: isDense,
                  isExpanded: isExpanded,
                  itemHeight: itemHeight,
                  focusNode: state._focusController.focusNode,
                ),
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<T> createState() => _ReactiveDropdownFieldState<T>();
}

class _ReactiveDropdownFieldState<T> extends ReactiveFormFieldState<T> {
  FocusNodeController _focusController = FocusNodeController();

  @override
  void subscribeControl() {
    this.control.registerFocusController(_focusController);
    super.subscribeControl();
  }

  @override
  void dispose() {
    this.control.unregisterFocusController(_focusController);
    _focusController.dispose();
    super.dispose();
  }

  void _onChanged(T value, ValueChanged<T> callBack) {
    this.didChange(value);
    if (callBack != null) {
      callBack(value);
    }
  }
}
