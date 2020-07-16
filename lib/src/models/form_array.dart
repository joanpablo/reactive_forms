// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A FormArray aggregates the values of each child FormControl into an array.
///
/// It calculates its status by reducing the status values of its children.
/// For example, if one of the controls in a FormArray is invalid, the entire
/// array becomes invalid.
///
/// FormArray is one of the three fundamental building blocks used to define
/// forms in Reactive Forms, along with [FormControl] and [FormGroup].
///
class FormArray<T> extends AbstractControl<Iterable<T>>
    implements FormControlCollection {
  final List<AbstractControl<T>> _controls = [];
  final _onCollectionChanged = ValueNotifier<Iterable<AbstractControl<T>>>([]);

  /// Creates a new [FormArray] instance.
  ///
  /// When instantiating a [FormGroup], pass in a collection of child controls
  /// as the first argument.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final form = FromGroup({
  ///   'name': FormControl(defaultValue: 'John Doe'),
  ///   'aliases': FormArray([
  ///     FormControl(defaultValue: 'john'),
  ///     FormControl(defaultValue: 'little john'),
  ///   ]),
  /// });
  /// ```
  /// You can also set [validators] as optionally argument.
  ///
  /// See also [AbstractControl.validators]
  ///
  FormArray(
    Iterable<AbstractControl<T>> controls, {
    List<ValidatorFunction> validators,
  })  : assert(controls != null),
        super(validators: validators) {
    this.addAll(controls);
  }

  /// Returns the values of controls as an [Iterable].
  ///
  @override
  Iterable<T> get value =>
      this._controls.map((control) => control.value).toList();

  /// Sets the value of the [FormArray].
  /// It accepts an array that matches the structure of the control.
  @override
  set value(Iterable<T> newValue) {
    newValue.toList().asMap().forEach((index, value) {
      if (index < this._controls.length) {
        this._controls[index].value = value;
      }
    });
  }

  /// Emits when a control is added or removed from collection.
  ///
  @override
  Listenable get onCollectionChanged => this._onCollectionChanged;

  /// Resets all the controls of the array, marking them as untouched,
  /// and setting the [FormControl.value] to [FormControl.defaultValue].
  ///
  /// See also [FormControl.reset()]
  ///
  @override
  void reset() {
    this._controls.forEach((control) => control.reset());
  }

  /// Insert a new [AbstractControl] at the end of the array.
  ///
  void add(AbstractControl<T> control) {
    this.addAll([control]);
  }

  /// Appends all [AbstractControl] of [iterable] to the end of this array.
  ///
  void addAll(Iterable<AbstractControl<T>> controls) {
    this._controls.addAll(controls);
    this.validate();
    _registerControlListeners(controls);
    _notifyCollectionChanged();
  }

  /// Removes control at [index]
  ///
  void removeAt(int index) {
    final removedControl = this._controls.removeAt(index);
    this.validate();
    this._removeControlListeners([removedControl]);
    this._notifyCollectionChanged();
  }

  /// Returns a [AbstractControl] by [name].
  /// The key represents the index of the control.
  ///
  /// Throws [FormArrayInvalidIndexException] if [name] is not e valid [int]
  /// number.
  ///
  /// Throws [FormControlNotFoundException] if no [FormControl] founded with
  /// the specified [name].
  ///
  /// ## Example:
  ///
  /// ```dart
  /// final array = FormArray([
  ///   FormControl(defaultValue: 'hello'),
  /// ]);
  ///
  /// final control = array.formControl('0');
  ///
  /// print(control.value);
  /// ```
  ///
  /// ```shell
  /// >hello
  /// ```
  @override
  AbstractControl control(String name) {
    int index = int.tryParse(name);
    if (index == null) {
      throw FormArrayInvalidIndexException(name);
    } else if (index >= this._controls.length) {
      throw FormControlNotFoundException(name);
    }

    return this._controls[index];
  }

  @override
  ControlStatus get childrenStatus {
    final isPending = this._controls.any((control) => control.pending);
    if (isPending) {
      return ControlStatus.pending;
    }

    final isInvalid = this._controls.any((control) => control.invalid);
    return isInvalid ? ControlStatus.invalid : ControlStatus.valid;
  }

  @override
  void dispose() {
    this._removeControlListeners(this._controls);
    super.dispose();
  }

  @override
  void validate() {
    this.notifyStatusChanged(ControlStatus.pending);

    final errors = Map<String, dynamic>();

    this.validators.forEach((validator) {
      final error = validator(this);
      if (error != null) {
        errors.addAll(error);
      }
    });

    this._controls.asMap().entries.forEach((entry) {
      final control = entry.value;
      final key = entry.key.toString();
      if (control.hasErrors) {
        errors.addAll({key: control.errors});
      }
    });

    this.setErrors(errors);
  }

  void _registerControlListeners(Iterable<AbstractControl> controls) {
    controls.toList().forEach((control) {
      control.onStatusChanged.addListener(this._onControlStatusChanged);
      control.onValueChanged.addListener(this._onControlValueChanged);
    });
  }

  void _removeControlListeners(Iterable<AbstractControl> controls) {
    controls.forEach((control) {
      control.onStatusChanged.removeListener(this._onControlStatusChanged);
      control.onValueChanged.removeListener(this._onControlValueChanged);
    });
  }

  void _onControlValueChanged() {
    if (this.childrenStatus == ControlStatus.pending) {
      this.notifyValueChanged(this.value);
    } else {
      this.validate();
    }
  }

  void _onControlStatusChanged() {
    if (this.childrenStatus == ControlStatus.pending) {
      notifyStatusChanged(ControlStatus.pending);
    } else {
      this.validate();
    }
  }

  void _notifyCollectionChanged() {
    this._onCollectionChanged.value = List.unmodifiable(this._controls);
  }
}
