// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
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
class ReactiveTimePicker extends ReactiveFormField<TimeOfDay, TimeOfDay> {
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
    super.key,
    super.formControlName,
    super.formControl,
    required ReactiveTimePickerBuilder builder,
    TransitionBuilder? transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Widget? child,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? errorInvalidText,
    String? hourLabelText,
    String? minuteLabelText,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    EntryModeChangeCallback? onEntryModeChanged,
    Offset? anchorPoint,
  }) : super(
          builder: (ReactiveFormFieldState<TimeOfDay, TimeOfDay> field) {
            return builder(
              field.context,
              ReactiveTimePickerDelegate._(
                field,
                (field) => showTimePicker(
                  context: field.context,
                  initialTime: field.value ?? TimeOfDay.now(),
                  builder: transitionBuilder,
                  useRootNavigator: useRootNavigator,
                  initialEntryMode: initialEntryMode,
                  cancelText: cancelText,
                  confirmText: confirmText,
                  helpText: helpText,
                  errorInvalidText: errorInvalidText,
                  hourLabelText: hourLabelText,
                  minuteLabelText: minuteLabelText,
                  routeSettings: routeSettings,
                  onEntryModeChanged: onEntryModeChanged,
                  anchorPoint: anchorPoint,
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
  ReactiveFormFieldState<TimeOfDay, TimeOfDay> createState() =>
      ReactiveFormFieldState<TimeOfDay, TimeOfDay>();
}

/// Definition of the function responsible for show the time picker.
typedef _ShowTimePickerCallback = void Function(
    ReactiveFormFieldState<TimeOfDay, TimeOfDay> field);

/// This class is responsible of showing the picker dialog.
///
/// See also [ReactiveTimePicker].
class ReactiveTimePickerDelegate {
  final ReactiveFormFieldState<TimeOfDay, TimeOfDay> _field;
  final _ShowTimePickerCallback _showPickerCallback;

  ReactiveTimePickerDelegate._(this._field, this._showPickerCallback);

  /// Gets the control bound to the [ReactiveTimePicker] widget
  FormControl<TimeOfDay> get control => _field.control;

  /// Gets the value selected in the time picker.
  TimeOfDay? get value => control.value;

  /// Shows the time picker dialog.
  void showPicker() {
    _showPickerCallback(_field);
  }
}
