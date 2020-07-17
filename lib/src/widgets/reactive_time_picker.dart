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
    BuildContext context, ReactiveTimePickerDelegate picker, Widget child);

/// This is a convenience widget that wraps the function
/// [showTimePicker] in a [ReactiveTimePicker].
///
/// The [formControlName] is required to bind this [ReactiveTimePicker]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showTimePicker]
/// function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveTimePicker(
///   formControlName: 'dateTime',
///   builder: (context, picker, child) {
///     return IconButton(
///       onPressed: picker.showPicker,
///       icon: Icon(Icons.date_range),
///     );
///   },
/// )
/// ```
class ReactiveTimePicker extends ReactiveFormField<TimeOfDay> {
  /// Creates a [ReactiveTimePicker] that wraps the function [showTimePicker].
  ///
  /// The [formControlName] is required to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// The parameter [transitionBuilder] is the equivalent of [builder]
  /// parameter in the [showTimePicker].
  ///
  /// For documentation about the various parameters, see the [showTimePicker]
  /// function parameters.
  ReactiveTimePicker({
    Key key,
    @required String formControlName,
    @required ReactiveTimePickerBuilder builder,
    TransitionBuilder transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings routeSettings,
    Widget child,
  })  : assert(builder != null),
        super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<TimeOfDay> field) {
            return builder(
              field.context,
              ReactiveTimePickerDelegate._(
                field,
                () => showTimePicker(
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

/// This class is responsible of showing the picker dialog.
///
/// See also [ReactiveTimePicker].
class ReactiveTimePickerDelegate {
  final ReactiveFormFieldState<TimeOfDay> _field;
  final VoidCallback _showPickerCallback;

  ReactiveTimePickerDelegate._(this._field, this._showPickerCallback);

  /// Gets the control bound to the [ReactiveTimePicker] widget
  AbstractControl<TimeOfDay> get control =>
      _field.control as AbstractControl<TimeOfDay>;

  /// Gets the value selected in the time picker.
  TimeOfDay get value => this.control.value;

  /// Shows the time picker dialog.
  void showPicker() {
    this._showPickerCallback();
  }
}
