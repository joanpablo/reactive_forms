// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// The builder passes a delegate [picker] as argument that has a method
/// to show the dialog, it also has a property to access the [FormControl]
/// that is bound to [ReactiveTimePicker].
///
/// See also [ReactiveTimePickerDelegate].
typedef ReactiveTimePickerBuilder = Widget Function(
    BuildContext context, ReactiveTimePickerDelegate picker, Widget? child);

/// This is a convenience widget that wraps the function
/// [showTimePicker] in a [ReactiveTimePicker].
///
/// Can optionally provide a [formControl] to bind this widget to a control.
///
/// Can optionally provide a [formControlName] to bind this ReactiveFormField
/// to a [FormControl].
///
/// Must provide one of the arguments [formControl] or a [formControlName],
/// but not both at the same time.
///
/// For documentation about the various parameters, see the [showTimePicker]
/// function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveTimePicker(
///   formControlName: 'time',
///   builder: (context, picker, child) {
///     return IconButton(
///       onPressed: picker.showPicker,
///       icon: Icon(Icons.access_time),
///     );
///   },
/// )
/// ```
class ReactiveTimePicker extends ReactiveFormField<TimeOfDay> {
  /// Creates a [ReactiveTimePicker] that wraps the function [showTimePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The parameter [transitionBuilder] is the equivalent of [builder]
  /// parameter in the [showTimePicker].
  ///
  /// For documentation about the various parameters, see the [showTimePicker]
  /// function parameters.
  ReactiveTimePicker({
    Key? key,
    String? formControlName,
    FormControl<TimeOfDay>? formControl,
    required ReactiveTimePickerBuilder builder,
    TransitionBuilder? transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Widget? child,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<TimeOfDay> field) {
            return builder(
              field.context,
              ReactiveTimePickerDelegate._(
                field,
                (field) => showTimePicker(
                  context: field.context,
                  initialTime: field.value ?? TimeOfDay.now(),
                  builder: transitionBuilder,
                  useRootNavigator: useRootNavigator,
                  routeSettings: routeSettings,
                ).then((value) {
                  if (value != null) {
                    field.didChange(value);
                  }
                }),
              ),
              child,
            );
          },
        );

  @override
  ReactiveFormFieldState<TimeOfDay> createState() =>
      ReactiveFormFieldState<TimeOfDay>();
}

/// Definition of the function responsible for show the time picker.
typedef _ShowTimePickerCallback = Function(
    ReactiveFormFieldState<TimeOfDay> field);

/// This class is responsible of showing the picker dialog.
///
/// See also [ReactiveTimePicker].
class ReactiveTimePickerDelegate {
  final ReactiveFormFieldState<TimeOfDay> _field;
  final _ShowTimePickerCallback _showPickerCallback;

  ReactiveTimePickerDelegate._(this._field, this._showPickerCallback);

  /// Gets the control bound to the [ReactiveTimePicker] widget
  AbstractControl<TimeOfDay> get control =>
      _field.control as AbstractControl<TimeOfDay>;

  /// Gets the value selected in the time picker.
  TimeOfDay? get value => this.control.value;

  /// Shows the time picker dialog.
  void showPicker() {
    this._showPickerCallback(_field);
  }
}
