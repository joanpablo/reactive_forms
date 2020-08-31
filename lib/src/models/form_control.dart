// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Tracks the value and validation status of an individual form control.
class FormControl<T> extends AbstractControl<T> {
  final _focusChanges = StreamController<bool>.broadcast();
  bool _focused = false;
  T _defaultValue;

  /// Creates a new FormControl instance.
  ///
  /// The control can optionally be initialized with a [defaultValue].
  ///
  /// The control can optionally have [validators] that validates
  /// the control each time the value changes.
  ///
  /// The control can optionally have [asyncValidators] that validates
  /// asynchronously the control each time the value changes.
  ///
  /// You can set an [asyncValidatorsDebounceTime] in millisecond to set
  /// a delay time before trigger async validators. This is useful for
  /// minimizing request to a server. The default value is 250 milliseconds.
  ///
  /// You can set [touched] as true to force the validation messages
  /// to show up at the very first time the widget that is bound to this
  /// control builds in the UI.
  ///
  /// ### Example:
  /// ```dart
  /// final priceControl = FormControl<double>(defaultValue: 0.0);
  /// ```
  ///
  FormControl({
    T defaultValue,
    List<ValidatorFunction> validators,
    List<AsyncValidatorFunction> asyncValidators,
    bool touched = false,
    int asyncValidatorsDebounceTime = 250,
    bool disabled = false,
  })  : _defaultValue = defaultValue,
        super(
          validators: validators,
          asyncValidators: asyncValidators,
          touched: touched,
          asyncValidatorsDebounceTime: asyncValidatorsDebounceTime,
          disabled: disabled,
        ) {
    if (_defaultValue != null) {
      this.value = _defaultValue;
    } else {
      this.updateValueAndValidity();
    }
  }

  /// Returns the default value of the control.
  T get defaultValue => _defaultValue;

  /// True if the control is marked as focused.
  bool get focused => _focused;

  /// Disposes the control
  @override
  void dispose() {
    _focusChanges.close();
    super.dispose();
  }

  /// A [ChangeNotifier] that emits an event every time the focus status of
  /// the control changes.
  Stream<bool> get focusChanges => _focusChanges.stream;

  /// Resets the form control, marking it as untouched,
  /// and setting the [value] to [defaultValue].
  @override
  void reset([dynamic formState]) {
    this.untouch();

    if (formState is FormControlState) {
      if (formState.disabled != null && formState.disabled) {
        this.disable(onlySelf: true, emitEvent: false);
      } else if (formState.disabled != null && !formState.disabled) {
        this.enable(onlySelf: true, emitEvent: false);
      }
      this.value = formState.value ?? this.defaultValue;
    } else {
      this.value = formState ?? this.defaultValue;
    }
  }

  /// Remove focus on a ReactiveFormField widget without the interaction
  /// of the user.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final formControl = form.formControl('name');
  ///
  /// // UI text field lose focus
  /// formControl.unfocus();
  ///```
  ///
  void unfocus() {
    if (this.focused) {
      _updateFocused(false);
    }
  }

  /// Sets focus on a ReactiveFormField widget without the interaction
  /// of the user.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final formControl = form.formControl('name');
  ///
  /// // UI text field get focus and the device keyboard pop up
  /// formControl.focus();
  ///```
  ///
  void focus() {
    if (!this.focused) {
      _updateFocused(true);
    }
  }

  void _updateFocused(bool value) {
    _focused = value;
    _focusChanges.add(value);
  }

  /// This method is for internal use only.
  @override
  T reduceValue() => this.value;
}
