// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// A FormArray aggregates the values of each child FormControl into an array.
///
/// It calculates its status by reducing the status values of its children.
/// For example, if one of the controls in a FormArray is invalid, the entire
/// array becomes invalid.
///
/// FormArray is one of the three fundamental building blocks used to define
/// forms in Reactive Forms, along with [FormControl] and [FormGroup].
class FormArray<T> extends AbstractControl<Iterable<T>>
    with FormControlCollection {
  final List<AbstractControl<T>> _controls = [];

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
  FormArray(
    Iterable<AbstractControl<T>> controls, {
    List<ValidatorFunction> validators,
  })  : assert(controls != null),
        super(validators: validators) {
    this.addAll(controls);
  }

  /// Gets the list of child controls.
  List<AbstractControl<T>> get controls => List.unmodifiable(this._controls);

  /// Sets the value of the [FormArray].
  ///
  /// It accepts an array that matches the structure of the control.
  /// It accepts both super-sets and sub-sets of the array.
  @override
  set value(Iterable<T> newValue) {
    newValue.toList().asMap().forEach((index, value) {
      if (index < this._controls.length) {
        this._controls[index].value = value;
      } else {
        this.insert(index, FormControl<T>(defaultValue: value));
      }
    });
  }

  /// Gets the values of controls as an [Iterable].
  ///
  /// This method is for internal use only.
  @override
  List<T> reduceValue() {
    return this
        ._controls
        .where((control) => control.enabled || this.disabled)
        .map((control) => control.value)
        .toList();
  }

  /// Resets all the controls of the array to default.
  ///
  /// Marks them as untouched and sets the
  /// [FormControl.value] to [FormControl.defaultValue].
  ///
  /// See also [FormControl.reset()]
  @override
  void reset([Iterable<T> value]) {
    this._controls.forEach((control) => control.reset());
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
    this._controls.forEach((control) {
      control.disable(onlySelf: true);
    });
    super.disable(onlySelf: onlySelf);
  }

  /// Enables the control. This means the control is included in validation
  /// checks and the aggregate value of its parent. Its status recalculates
  /// based on its value and its validators.
  @override
  void enable({bool onlySelf: false}) {
    this.controls.forEach((control) {
      control.enable(onlySelf: true);
    });
    super.enable(onlySelf: onlySelf);
  }

  /// Insert a new [control] at the [index] position.
  void insert(int index, AbstractControl<T> control) {
    _controls.insert(index, control);
    control.parent = this;
    this.updateValueAndValidity();
    this.emitsCollectionChanged(_controls);
  }

  /// Insert a new [control] at the end of the array.
  void add(AbstractControl<T> control) {
    this.addAll([control]);
  }

  /// Appends all [controls] to the end of this array.
  void addAll(Iterable<AbstractControl<T>> controls) {
    this._controls.addAll(controls);
    controls.forEach((control) {
      control.parent = this;
    });
    this.updateValueAndValidity();
    this.emitsCollectionChanged(_controls);
  }

  /// Removes control at [index]
  void removeAt(int index) {
    final removedControl = _controls.removeAt(index);
    removedControl.parent = null;
    this.updateValueAndValidity();
    this.emitsCollectionChanged(_controls);
  }

  /// Removes [control].
  ///
  /// Throws [FormControlNotFoundException] if no control found.
  void remove(AbstractControl<T> control) {
    final index = _controls.indexOf(control);
    if (index == -1) {
      throw FormControlNotFoundException();
    }
    this.removeAt(index);
  }

  /// Returns a control by name where [name].
  ///
  /// The [name] is the String representation of the index position
  /// of the control in array.
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
  AbstractControl<T> control(String name) {
    int index = int.tryParse(name);
    if (index == null) {
      throw FormArrayInvalidIndexException(name);
    } else if (index >= _controls.length) {
      throw FormControlNotFoundException(controlName: name);
    }

    return _controls[index];
  }

  /// Disposes the array.
  @override
  void dispose() {
    _controls.forEach((control) {
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
    return _controls.every((control) => control.disabled);
  }

  /// Returns true if all children has the specified [status], otherwise
  /// returns false.
  ///
  /// This is for internal use only.
  @override
  bool anyControlsHaveStatus(ControlStatus status) {
    return _controls.any((control) => control.status == status);
  }

  /// Gets all errors of the array.
  ///
  /// Contains all the errors of the array and the child errors.
  @override
  Map<String, dynamic> get errors {
    final allErrors = Map.of(super.errors);
    _controls.asMap().entries.forEach((entry) {
      final control = entry.value;
      final name = entry.key.toString();
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
