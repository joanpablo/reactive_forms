// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/exceptions/form_builder_invalid_initialization_exception.dart';

/// Creates an [AbstractControl] from a user-specified configuration.
class FormBuilder {
  /// Construct a new [FormGroup] instance.
  ///
  /// The [controls] argument must not be null.
  ///
  /// Can optionally provide a [validators] collection for the group.
  ///
  /// ### Example:
  ///
  /// Creates a group with a control that has a default value.
  /// ```dart
  /// final form = fb.group({
  ///   'name': 'John Doe',
  /// });
  /// ```
  ///
  /// Creates a group with a control that has a default value.
  /// ```dart
  /// final form = fb.group({
  ///   'name': ['John Doe'],
  /// });
  /// ```
  ///
  /// Creates a group with a control that has a default value and a validator.
  /// ```dart
  /// final form = fb.group({
  ///   'name': ['John Doe', Validators.required],
  /// });
  /// ```
  ///
  /// Creates a group with a control that has a validator.
  /// ```dart
  /// final form = fb.group({
  ///   'name': Validators.required,
  /// });
  /// ```
  ///
  /// Creates a group with a control that has several validators.
  /// ```dart
  /// final form = fb.group({
  ///   'email': [Validators.required, Validators.email],
  /// });
  /// ```
  ///
  /// Creates a group with a group's validator.
  /// ```dart
  /// final form = fb.group({
  ///   'email': ['', Validators.required, Validators.email],
  ///   'emailConfirmation': '',
  ///  },
  ///  [Validators.mustMatch('email', 'emailConfirmation')],
  /// );
  /// ```
  FormGroup group(
    Map<String, dynamic> controls, [
    List<ValidatorFunction> validators = const [],
    List<AsyncValidatorFunction> asyncValidators = const [],
  ]) {
    final map = controls.map((String key, dynamic value) {
      if (value is String) {
        return MapEntry(key, FormControl<String>(value: value));
      } else if (value is int) {
        return MapEntry(key, FormControl<int>(value: value));
      } else if (value is bool) {
        return MapEntry(key, FormControl<bool>(value: value));
      } else if (value is double) {
        return MapEntry(key, FormControl<double>(value: value));
      } else if (value is DateTime) {
        return MapEntry(key, FormControl<DateTime>(value: value));
      } else if (value is TimeOfDay) {
        return MapEntry(key, FormControl<TimeOfDay>(value: value));
      } else if (value is AbstractControl) {
        return MapEntry(key, value);
      } else if (value is ValidatorFunction) {
        return MapEntry(key, FormControl(validators: [value]));
      } else if (value is List<ValidatorFunction> &&
          value.isNotEmpty &&
          value.first != null) {
        return MapEntry(key, FormControl(validators: value));
      } else if (value is List<dynamic>) {
        if (value.isEmpty) {
          return MapEntry(key, FormControl());
        } else {
          final defaultValue = value.first;
          final validators = List.of(value.skip(1));

          if (validators.isNotEmpty &&
              validators
                  .any((validator) => !(validator is ValidatorFunction))) {
            throw FormBuilderInvalidInitializationException(
                'Invalid validators initialization');
          }

          if (defaultValue is ValidatorFunction) {
            throw FormBuilderInvalidInitializationException(
                'Expected first value in array to be default value of the control and not a validator.');
          }

          final effectiveValidators = validators
              .map<ValidatorFunction>((v) => v as ValidatorFunction)
              .toList();
          final control = _control(defaultValue, effectiveValidators);
          return MapEntry(key, control);
        }
      }

      return MapEntry(key, FormControl(value: value));
    });

    return FormGroup(
      map,
      validators: validators,
      asyncValidators: asyncValidators,
    );
  }

  /// Creates a ControlState.
  ///
  /// You can pass the optional arguments [value] and [disabled] to the
  /// control state.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final form = fb.group({
  ///   'name': 'first name'
  /// });
  ///
  /// form.resetState({
  ///   'name': fb.state(value: 'name'),
  /// });
  ///
  /// print(form.value); // output: {'name': 'name'}
  /// ```
  ControlState<T> state<T>({T value, bool disabled}) {
    return ControlState<T>(value: value, disabled: disabled);
  }

  /// Construct a new [FormControl] instance.
  ///
  /// Can optionally provide a [validators] collection for the control.
  ///
  /// Can optionally provide a [asyncValidators] collection for the control.
  ///
  /// ### Example:
  ///
  /// Creates a control with default value.
  /// ````dart
  /// final name = fb.control('John Doe');
  /// ```
  ///
  /// Creates a control with required validator.
  /// ````dart
  /// final control = fb.control('', [Validators.required]);
  /// ```
  FormControl<T> control<T>(
    T value, [
    List<ValidatorFunction> validators = const [],
    List<AsyncValidatorFunction> asyncValidators = const [],
  ]) {
    return FormControl<T>(
      value: value,
      validators: validators,
      asyncValidators: asyncValidators,
    );
  }

  /// Construct a new [FormArray] instance.
  ///
  /// The [value] must not be null.
  ///
  /// Can optionally provide a [validators] collection for the control.
  ///
  /// ### Example:
  ///
  /// Constructs an array of strings
  /// ```dart
  /// final aliases = fb.array(['john', 'little john']);
  /// ```
  /// Constructs an array of groups defined as Maps
  /// ```dart
  /// final addressArray = fb.array([
  ///   {'city': 'Sofia'},
  ///   {'city': 'Havana'},
  /// ]);
  /// ```
  ///
  /// Constructs an array of groups
  /// ```dart
  /// final addressArray = fb.array([
  ///   fb.group({'city': 'Sofia'}),
  ///   fb.group({'city': 'Havana'}),
  /// ]);
  /// ```
  ///
  FormArray<T> array<T>(
    List<dynamic> value, [
    List<ValidatorFunction> validators = const [],
    List<AsyncValidatorFunction> asyncValidators = const [],
  ]) {
    return FormArray<T>(
      value?.map<AbstractControl<T>>((v) {
        if (v is Map<String, dynamic>) {
          return this.group(v) as AbstractControl<T>;
        }
        if (v is AbstractControl) {
          return v as AbstractControl<T>;
        }

        return this.control<T>(v);
      })?.toList(),
      validators: validators,
      asyncValidators: asyncValidators,
    );
  }

  FormControl _control(dynamic value, List<ValidatorFunction> validators) {
    if (value is AbstractControl) {
      throw FormBuilderInvalidInitializationException(
          'Default value of control must not be an AbstractControl.');
    }

    if (value is String) {
      return FormControl<String>(value: value, validators: validators);
    } else if (value is int) {
      return FormControl<int>(value: value, validators: validators);
    } else if (value is bool) {
      return FormControl<bool>(value: value, validators: validators);
    } else if (value is double) {
      return FormControl<double>(value: value, validators: validators);
    } else if (value is DateTime) {
      return FormControl<DateTime>(value: value);
    } else if (value is TimeOfDay) {
      return FormControl<TimeOfDay>(value: value);
    }

    return FormControl(value: value, validators: validators);
  }
}

/// Global [FormBuilder] instance.
final fb = FormBuilder();
