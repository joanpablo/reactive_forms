// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

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
    with FormControlCollection {
  final Map<String, AbstractControl> _controls = {};

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
        super(validators: validators) {
    this.addAll(controls);
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

  /// Reduce the value of the group is a key-value pair for each control
  /// in the group.
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
  ///
  /// This method is for internal use only.
  @override
  Map<String, dynamic> reduceValue() {
    final map = Map<String, dynamic>();
    this._controls.forEach((key, control) {
      if (control.enabled || this.disabled) {
        map[key] = control.value;
      }
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
    this._controls.forEach((key, control) {
      control.reset();
    });
  }

  /// Disables the control.
  ///
  /// This means the control is exempt from validation checks and excluded
  /// from the aggregate value of any parent. Its status is `DISABLED`.
  ///
  /// If the control has children, all children are also disabled.
  ///
  /// When [onlySelf] is true, mark only this control.
  /// When false or not supplied, marks all direct ancestors.
  /// Default is false.
  @override
  void disable({bool onlySelf: false}) {
    this._controls.forEach((_, control) {
      control.disable(onlySelf: true);
    });
    super.disable(onlySelf: onlySelf);
  }

  /// Enables the control. This means the control is included in validation
  /// checks and the aggregate value of its parent. Its status recalculates
  /// based on its value and its validators.
  ///
  /// When [onlySelf] is true, mark only this control.
  /// When false or not supplied, marks all direct ancestors.
  /// Default is false.
  @override
  void enable({bool onlySelf: false}) {
    this.controls.forEach((_, control) {
      control.enable(onlySelf: true);
    });
    super.enable(onlySelf: onlySelf);
  }

  /// Appends all [controls] to the group.
  void addAll(Map<String, AbstractControl> controls) {
    _controls.addAll(controls);
    controls.forEach((name, control) {
      control.parent = this;
    });
    this.updateValueAndValidity();
  }

  /// A group is touched if at least one of its children is mark as touched.
  @override
  bool get touched => this._controls.values.any((control) => control.touched);

  /// Marks all controls as touched
  @override
  void touch({bool emitEvent = true}) {
    this._controls.values.forEach((control) => control.touch(
          emitEvent: emitEvent,
        ));
  }

  /// Marks all controls as untouched
  @override
  void untouch({bool emitEvent = true}) {
    this._controls.values.forEach((control) => control.untouch(
          emitEvent: emitEvent,
        ));
  }

  /// Disposes the group.
  @override
  void dispose() {
    this._controls.forEach((_, control) {
      control.parent = null;
      control.dispose();
    });
    this.closeCollectionEvents();
    super.dispose();
  }

  /// Returns true if all children disabled, otherwise returns false.
  ///
  /// This is for internal use only.
  @override
  bool allControlsDisabled() {
    if (_controls.isEmpty) {
      return false;
    }
    return _controls.values.every((control) => control.disabled);
  }

  /// Returns true if all children has the specified [status], otherwise
  /// returns false.
  ///
  /// This is for internal use only.
  @override
  bool anyControlsHaveStatus(ControlStatus status) {
    return _controls.values.any((control) => control.status == status);
  }

  /// Gets all errors of the group.
  ///
  /// Contains all the errors of the group and the child errors.
  @override
  Map<String, dynamic> get errors {
    final allErrors = Map.of(super.errors);
    _controls.forEach((name, control) {
      if (control.enabled && control.hasErrors) {
        allErrors.update(
          name,
          (_) => control.errors,
          ifAbsent: () => control.errors,
        );
      }
    });

    return allErrors;
  }
}
