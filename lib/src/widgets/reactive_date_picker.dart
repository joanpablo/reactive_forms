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
/// See also [ReactiveDatePickerDelegate].
typedef ReactiveDatePickerBuilder = Widget Function(
    BuildContext context, ReactiveDatePickerDelegate picker, Widget child);

/// This is a convenience widget that wraps the function
/// [showDatePicker] in a [ReactiveDatePicker].
///
/// The [formControlName] is required to bind this [ReactiveDatePicker]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveDatePicker(
///   formControlName: 'birthday',
///   builder: (context, picker, child) {
///     return IconButton(
///       onPressed: picker.showPicker,
///       icon: Icon(Icons.date_range),
///     );
///   },
/// )
/// ```
class ReactiveDatePicker extends ReactiveFormField<dynamic> {
  /// Creates a [ReactiveDatePicker] that wraps the function [showDatePicker].
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
  ReactiveDatePicker({
    Key? key,
    String? formControlName,
    FormControl? formControl,
    required ReactiveDatePickerBuilder builder,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? transitionBuilder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    Widget? child,
  })  : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<dynamic> field) {
            return builder(
              field.context,
              ReactiveDatePickerDelegate._(
                field,
                (field) => showDatePicker(
                  context: field.context,
                  initialDate: _getInitialDate(field.value, lastDate),
                  firstDate: firstDate,
                  lastDate: lastDate,
                  initialEntryMode: initialEntryMode,
                  selectableDayPredicate: selectableDayPredicate,
                  helpText: helpText,
                  cancelText: cancelText,
                  confirmText: confirmText,
                  locale: locale,
                  useRootNavigator: useRootNavigator,
                  routeSettings: routeSettings,
                  textDirection: textDirection,
                  builder: transitionBuilder,
                  initialDatePickerMode: initialDatePickerMode,
                  errorFormatText: errorFormatText,
                  errorInvalidText: errorInvalidText,
                  fieldHintText: fieldHintText,
                  fieldLabelText: fieldLabelText,
                ).then((value) {
                  if (value != null) {
                    field.didChange(value);
                  }
                }),
              ),
              child!,
            );
          },
        );

  static DateTime _getInitialDate(DateTime? fieldValue, DateTime lastDate) {
    if (fieldValue != null) {
      return fieldValue;
    }

    final now = DateTime.now();
    return now.compareTo(lastDate) > 0 ? lastDate : now;
  }

  @override
  ReactiveFormFieldState<dynamic> createState() => _ReactiveDatePickerState();
}

/// Definition of the function responsible for show the date picker.
typedef _ShowDatePickerCallback = Function(
    ReactiveFormFieldState<dynamic> field);

/// This class is responsible of showing the picker dialog.
///
/// See also [ReactiveDatePicker].
class ReactiveDatePickerDelegate {
  final ReactiveFormFieldState<dynamic> _field;
  final _ShowDatePickerCallback _showPickerCallback;

  ReactiveDatePickerDelegate._(this._field, this._showPickerCallback);

  /// Gets the control bound to the [ReactiveTimePicker] widget
  AbstractControl<dynamic> get control => _field.control;

  /// Gets the value selected in the date picker.
  DateTime get value => _field.value;

  /// Shows the time picker dialog.
  void showPicker() {
    this._showPickerCallback(_field);
  }
}

class _ReactiveDatePickerState extends ReactiveFormFieldState<dynamic> {
  @override
  ControlValueAccessor selectValueAccessor() {
    if (this.control is AbstractControl<String>) {
      return Iso8601DateTimeValueAccessor();
    } else if (this.control is AbstractControl<DateTime>) {
      return DefaultValueAccessor();
    }

    throw ValueAccessorException('Invalid widget binding. ReactiveDatePicker '
        'widget must be bound to a control that inherited from '
        'AbstractControl<String> or AbstractControl<DateTime>. '
        'Control of type: ${this.control.runtimeType} is not valid.');
  }
}
