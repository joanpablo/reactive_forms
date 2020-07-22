// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Tracks the value and validity state of a group of FormControl instances.
///
/// A FormGroup aggregates the values of each child FormControl into one object,
/// with each control name as the key.
///
/// It calculates its status by reducing the status values of its children.
/// For example, if one of the controls in a group is invalid, the entire group
/// becomes invalid.
class FormGroup extends AbstractControl<Map<String, dynamic>>
    implements FormControlCollection {
  final Map<String, AbstractControl> _controls;
  final _onCollectionChanged = ValueNotifier<Iterable<AbstractControl>>([]);

  /// Creates a new FormGroup instance.
  ///
  /// When instantiating a [FormGroup], pass in a [Map] of child controls
  /// as the first argument.
  ///
  /// The key for each child registers the name for the control.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final form = FromGroup({
  ///   'name': FormControl(defaultValue: 'John Doe'),
  ///   'email': FormControl(),
  /// });
  /// ```
  /// You can also set [validators] as optionally argument.
  ///
  /// See also [AbstractControl.validators]
  FormGroup(
    Map<String, AbstractControl> controls, {
    List<ValidatorFunction> validators,
  })  : assert(controls != null),
        _controls = controls,
        super(
          validators: validators,
        ) {
    this.validate();
    _registerControlListeners();
  }

  /// Returns a [AbstractControl] by [name].
  ///
  /// Throws [FormControlNotFoundException] if no control founded with
  /// the specified [name].
  @override
  AbstractControl control(String name) {
    if (!this._controls.containsKey(name)) {
      throw FormControlNotFoundException(controlName: name);
    }

    return this._controls[name];
  }

  /// Gets the collection of child controls.
  ///
  /// The key for each child is the name under which it is registered.
  Map<String, AbstractControl> get controls => Map.unmodifiable(this._controls);

  /// Emits when a control is added or removed from collection.
  @override
  Listenable get onCollectionChanged => this._onCollectionChanged;

  /// Returns the current value of the group.
  ///
  /// Value of the group is a key-value pair for each control in the group.
  ///
  /// ### Example:
  ///
  ///```dart
  /// final form = FormGroup({
  ///   'name': FormControl(defaultValue: 'John Doe'),
  ///   'email': FormControl(defaultValue: 'johndoe@email.com'),
  /// });
  ///
  /// print(form.value);
  ///```
  ///
  /// ```json
  /// { "name": "John Doe", "email": "johndoe@email.com" }
  ///```
  Map<String, dynamic> get value {
    final map = Map<String, dynamic>();
    this._controls.forEach((key, formControl) {
      map[key] = formControl.value;
    });

    return map;
  }

  /// Set the complete value for the form group.
  ///
  /// ### Example
  ///
  /// ```dart
  /// final form = FormGroup({
  ///   'name': FormControl(),
  ///   'email': FormControl(),
  /// });
  ///
  /// form.value = { 'name': 'John Doe', 'email': 'johndoe@email.com' }
  ///
  /// print(form.value);
  /// ```
  /// ```json
  /// { "name": "John Doe", "email": "johndoe@email.com" }
  ///```
  @override
  set value(Map<String, dynamic> newValue) {
    newValue.forEach((key, value) {
      if (this._controls.containsKey(key)) {
        this._controls[key].value = value;
      }
    });
  }

  /// Resets all the controls of the group to default.
  ///
  /// Marks them as untouched and sets the
  /// [FormControl.value] to [FormControl.defaultValue].
  ///
  /// See also [FormControl.reset()]
  @override
  void reset() {
    this._controls.forEach((key, formControl) {
      formControl.reset();
    });
  }

  @override
  void disable({bool onlySelf: false}) {
    this._controls.forEach((key, formControl) {
      formControl.disable();
    });
    super.disable();
  }

  /// A group is touched if at least one of its children is mark as touched.
  @override
  bool get touched => this._controls.values.any((control) => control.touched);

  /// Marks all controls as touched
  @override
  void touch() {
    this._controls.values.forEach((control) => control.touch());
  }

  /// Marks all controls as untouched
  @override
  void untouch() {
    this._controls.values.forEach((control) => control.untouch());
  }

  /// Calculates status based on status of controls
  @override
  ControlStatus get childrenStatus {
    final isPending = this._controls.values.any((control) => control.pending);
    if (isPending) {
      return ControlStatus.pending;
    }

    final isInvalid = this._controls.values.any((control) => control.invalid);
    return isInvalid ? ControlStatus.invalid : ControlStatus.valid;
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

    this._controls.forEach((key, control) {
      if (control.hasErrors) {
        errors.addAll({key: control.errors});
      }
    });

    this.setErrors(errors);
  }

  @override
  void dispose() {
    this._controls.values.forEach((control) {
      control.onStatusChanged.removeListener(this._onControlStatusChanged);
      control.onValueChanged.removeListener(this._onControlValueChanged);
    });
    super.dispose();
  }

  void _registerControlListeners() {
    this._controls.values.forEach((control) {
      control.onValueChanged.addListener(this._onControlValueChanged);
      control.onStatusChanged.addListener(this._onControlStatusChanged);
    });
  }

  void _onControlValueChanged() {
    if (this.childrenStatus == ControlStatus.pending) {
      this.notifyValueChanged(this.value);
    } else {
      this.validate();
      this.notifyValueChanged(this.value);
    }
  }

  void _onControlStatusChanged() {
    if (this.childrenStatus == ControlStatus.pending) {
      notifyStatusChanged(ControlStatus.pending);
    } else {
      this.validate();
    }
  }
}
