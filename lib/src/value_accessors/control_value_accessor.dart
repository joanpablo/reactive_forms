// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ModelToViewCallback<ModelDataType, ViewDataType> = ViewDataType?
    Function(ModelDataType? modelValue);

typedef ViewToModelCallback<ModelDataType, ViewDataType> = ModelDataType?
    Function(ViewDataType? modelValue);

/// Type of the function to be called when the control emits a value changes
/// event.
typedef ChangeFunction<K> = dynamic Function(K? value);

/// Defines an interface that acts as a bridge between [FormControl] and a
/// reactive native widget.
abstract class ControlValueAccessor<ModelDataType, ViewDataType> {
  ControlValueAccessor();

  /// Create simple [ControlValueAccessor] that maps the [FormControl] value
  factory ControlValueAccessor.create({
    required ModelToViewCallback<ModelDataType, ViewDataType> modelToView,
    required ViewToModelCallback<ModelDataType, ViewDataType> valueToModel,
  }) =>
      _WrapperValueAccessor<ModelDataType, ViewDataType>(
        modelToViewValue: modelToView,
        valueToModelValue: valueToModel,
      );

  FormControl<ModelDataType>? _control;
  ChangeFunction<ViewDataType>? _onChange;
  bool _viewToModelChange = false;
  StreamSubscription<ModelDataType?>? _onChangeSubscription;

  /// Gets the control bind to this value accessor.
  FormControl<ModelDataType>? get control => _control;

  /// Returns the value that must be supplied to the [control].
  ///
  /// Converts value from UI data type to [control] data type.
  ModelDataType? viewToModelValue(ViewDataType? viewValue);

  /// Returns the value that must be supplied to the UI widget.
  ///
  /// Converts value from [control] data type to UI data type.
  ViewDataType? modelToViewValue(ModelDataType? modelValue);

  /// Updates the [control] with the provided value.
  ///
  /// Marks the control as dirty if the [viewValue] is different from the
  /// [control] value.
  ///
  /// Throws [ValueAccessorException] if no control is registered with this
  /// value accessor.
  ///
  /// See also [registerControl].
  void updateModel(ViewDataType? viewValue) {
    if (_control == null) {
      throw ValueAccessorException(
        'No control registered. Call [ControlValueAccessor.registerControl] to register a control first.',
      );
    }

    _viewToModelChange = true;

    final modelValue = viewToModelValue(viewValue);
    if (_control?.value != modelValue) {
      _control?.markAsDirty(emitEvent: false);
      _control?.updateValue(modelValue);
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
  void registerControl(
    FormControl<ModelDataType> control, {
    ChangeFunction<ViewDataType>? onChange,
  }) {
    _control = control;
    _onChangeSubscription = _control!.valueChanges.listen(_updateView);

    _onChange = onChange;
  }

  /// Disposes the value accessors.
  @mustCallSuper
  void dispose() {
    _onChangeSubscription?.cancel();
  }

  void _updateView(ModelDataType? modelValue) {
    if (_viewToModelChange) {
      _viewToModelChange = false;
      return;
    }

    final viewValue = modelToViewValue(_control?.value);

    if (_onChange != null) {
      _onChange!(viewValue);
    }
  }
}

class _WrapperValueAccessor<ModelDataType, ViewDataType>
    extends ControlValueAccessor<ModelDataType, ViewDataType> {
  final ModelToViewCallback<ModelDataType, ViewDataType> _modelToViewValue;
  final ViewToModelCallback<ModelDataType, ViewDataType> _valueToModelValue;

  _WrapperValueAccessor({
    required ModelToViewCallback<ModelDataType, ViewDataType> modelToViewValue,
    required ViewToModelCallback<ModelDataType, ViewDataType> valueToModelValue,
  })  : _modelToViewValue = modelToViewValue,
        _valueToModelValue = valueToModelValue;

  @override
  ViewDataType? modelToViewValue(ModelDataType? modelValue) =>
      _modelToViewValue(modelValue);

  @override
  ModelDataType? viewToModelValue(ViewDataType? viewValue) =>
      _valueToModelValue(viewValue);
}
