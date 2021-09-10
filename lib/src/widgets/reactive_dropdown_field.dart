// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A reactive widget that wraps a [DropdownButton].
class ReactiveDropdownField<T, V> extends ReactiveFormField<T, V> {
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
  /// If [readOnly] is true, the button will be disabled, the down arrow will
  /// be grayed out, and the disabledHint will be shown (if provided).
  ///
  /// The [DropdownButton] [items] parameters must not be null.
  ReactiveDropdownField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ControlValueAccessor<T, V>? valueAccessor,
    required List<DropdownMenuItem<V>> items,
    ValidationMessagesFunction<T>? validationMessages,
    ShowErrorsFunction? showErrors,
    DropdownButtonBuilder? selectedItemBuilder,
    Widget? hint,
    VoidCallback? onTap,
    InputDecoration decoration = const InputDecoration(),
    Widget? disabledHint,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    bool readOnly = false,
    double? itemHeight,
    Color? dropdownColor,
    Color? focusColor,
    Widget? underline,
    bool autofocus = false,
    double? menuMaxHeight,
  })  : assert(itemHeight == null || itemHeight > 0),
        super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveDropdownFieldState<T, V>;

            final effectiveDecoration = decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            var effectiveValue = field.value;
            if (effectiveValue != null &&
                !items.any((item) => item.value == effectiveValue)) {
              effectiveValue = null;
            }

            final isDisabled = readOnly || field.control.disabled;
            var effectiveDisabledHint = disabledHint;
            if (isDisabled && disabledHint == null) {
              final selectedItemIndex =
                  items.indexWhere((item) => item.value == effectiveValue);
              if (selectedItemIndex > -1) {
                effectiveDisabledHint = selectedItemBuilder != null
                    ? selectedItemBuilder(field.context)
                        .elementAt(selectedItemIndex)
                    : items.elementAt(selectedItemIndex).child;
              }
            }

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: !isDisabled,
              ),
              isEmpty: effectiveValue == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<V>(
                  value: effectiveValue,
                  items: items,
                  selectedItemBuilder: selectedItemBuilder,
                  hint: hint,
                  onChanged: isDisabled ? null : field.didChange,
                  onTap: onTap,
                  disabledHint: effectiveDisabledHint,
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
                  dropdownColor: dropdownColor,
                  focusColor: focusColor,
                  underline: underline,
                  autofocus: autofocus,
                  menuMaxHeight: menuMaxHeight,
                ),
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<T, V> createState() =>
      _ReactiveDropdownFieldState<T, V>();
}

class _ReactiveDropdownFieldState<T, V> extends ReactiveFormFieldState<T, V> {
  final _focusController = FocusController();

  @override
  void subscribeControl() {
    control.registerFocusController(_focusController);
    super.subscribeControl();
  }

  @override
  void dispose() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
    super.dispose();
  }
}
