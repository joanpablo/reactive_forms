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
  FormArray(
    Iterable<AbstractControl<T>> controls, {
    List<ValidatorFunction> validators,
  })  : assert(controls != null),
        super(validators: validators) {
    this.addAll(controls);
  }

  /// Gets the values of controls as an [Iterable].
  @override
  Iterable<T> get value => this
      ._controls
      .where((control) => control.enabled)
      .map((control) => control.value)
      .toList();

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

  /// Emits when a control is added or removed from collection.
  @override
  Listenable get onCollectionChanged => this._onCollectionChanged;

  /// Resets all the controls of the array to default.
  ///
  /// Marks them as untouched and sets the
  /// [FormControl.value] to [FormControl.defaultValue].
  ///
  /// See also [FormControl.reset()]
  @override
  void reset() {
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
    this._controls.insert(index, control);
    this.validate();
    control.parent = this;
    _notifyCollectionChanged();
  }

  /// Insert a new [control] at the end of the array.
  void add(AbstractControl<T> control) {
    this.addAll([control]);
  }

  /// Appends all [controls] to the end of this array.
  void addAll(Iterable<AbstractControl<T>> controls) {
    this._controls.addAll(controls);
    this.validate();
    controls.forEach((control) {
      control.parent = this;
    });
    _notifyCollectionChanged();
  }

  /// Removes control at [index]
  void removeAt(int index) {
    final removedControl = this._controls.removeAt(index);
    this.validate();
    removedControl.parent = null;
    this._notifyCollectionChanged();
  }

  /// Removes [control].
  ///
  /// Throws [FormControlNotFoundException] if no control found.
  void remove(AbstractControl<T> control) {
    final index = this._controls.indexOf(control);
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
    } else if (index >= this._controls.length) {
      throw FormControlNotFoundException(controlName: name);
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
  void validate() {
    this.updateStatus(ControlStatus.pending);

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

  @override
  void dispose() {
    this._controls.forEach((control) {
      control.parent = null;
      control.dispose();
    });
    super.dispose();
  }

  @override
  void updateValueAndValidity() {
    if (this.childrenStatus == ControlStatus.pending) {
      this.updateValue(this.value);
    } else {
      this.validate();
      this.updateValue(this.value);
    }
  }

  @override
  void updateStatusAndValidity() {
    switch (this.childrenStatus) {
      case ControlStatus.pending:
        this.updateStatus(ControlStatus.pending);
        break;
      case ControlStatus.valid:
        this.setErrors({});
        break;
      case ControlStatus.invalid:
        final errors = Map<String, dynamic>();
        this._controls.asMap().entries.forEach((entry) {
          if (entry.value.hasErrors) {
            errors.addAll({'${entry.key}': entry.value.errors});
          }
        });

        this.setErrors(errors);
        break;
      case ControlStatus.disabled:
        break;
    }
  }

  void _notifyCollectionChanged() {
    this._onCollectionChanged.value = List.unmodifiable(this._controls);
  }
}
