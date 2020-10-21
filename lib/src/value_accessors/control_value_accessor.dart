// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Type of the function to be called when the control emits a value changes
/// event.
typedef ChangeFunction<K> = dynamic Function(K value);

/// Defines an interface that acts as a bridge between [FormControl] and a
/// reactive native widget.
abstract class ControlValueAccessor<T, K> {
  FormControl<T> _control;
  ChangeFunction<K> _onChange;
  bool _viewToModelChange = false;
  StreamSubscription _onChangeSubscription;

  /// Gets the control bind to this value accessor.
  FormControl<T> get control => _control;

  /// Returns the value that must be supplied to the [control].
  ///
  /// Converts value from UI data type to [control] data type.
  T viewToModelValue(K viewValue);

  /// Returns the value that must be supplied to the UI widget.
  ///
  /// Converts value from [control] data type to UI data type.
  K modelToViewValue(T modelValue);

  /// Updates the [control] with the provided value.
  ///
  /// Marks the control as dirty if the [viewValue] is different from the
  /// [control] value.
  ///
  /// Throws [ValueAccessorException] if no control is registered with this
  /// value accessor.
  ///
  /// See also [registerControl].
  void updateModel(K viewValue) {
    if (_control == null) {
      throw ValueAccessorException(
          'No control registered. Call [ControlValueAccessor.registerControl] to register a control first.');
    }

    _viewToModelChange = true;

    final modelValue = this.viewToModelValue(viewValue);
    if (_control.value != modelValue) {
      _control.markAsDirty(emitEvent: false);
      _control.updateValue(modelValue);
    } else {
      _viewToModelChange = false;
    }
  }

  /// Registers a the [control] with the value accessor.
  ///
  /// The [control] argument must not be null.
  ///
  /// The argument [onChange] is optionally and will be called every time the
  /// [control] emits the value change event.
  void registerControl(FormControl<T> control, {ChangeFunction<K> onChange}) {
    assert(control != null);
    _control = control;
    _onChangeSubscription = _control.valueChanges.listen(_updateView);

    _onChange = onChange;
  }

  /// Disposes the value accessors.
  @mustCallSuper
  void dispose() {
    _onChangeSubscription.cancel();
  }

  void _updateView(T modelValue) {
    if (_viewToModelChange) {
      _viewToModelChange = false;
      return;
    }

    final viewValue = this.modelToViewValue(_control.value);

    if (_onChange != null) {
      _onChange(viewValue);
    }
  }
}
