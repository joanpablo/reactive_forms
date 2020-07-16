import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveTimePickerBuilder = Widget Function(
    BuildContext context, ReactiveTimePickerHandler picker, Widget child);

class ReactiveTimePicker extends ReactiveFormField<TimeOfDay> {
  ReactiveTimePicker({
    Key key,
    @required String formControlName,
    @required ReactiveTimePickerBuilder builder,
    Widget child,
  })  : assert(builder != null),
        super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<TimeOfDay> field) {
            return builder(
                field.context, ReactiveTimePickerHandler._(field), child);
          },
        );

  @override
  ReactiveFormFieldState<TimeOfDay> createState() =>
      ReactiveFormFieldState<TimeOfDay>();
}

class ReactiveTimePickerHandler {
  final ReactiveFormFieldState<TimeOfDay> _field;

  ReactiveTimePickerHandler._(this._field);

  AbstractControl<TimeOfDay> get control =>
      _field.control as AbstractControl<TimeOfDay>;

  TimeOfDay get timeOfDay => control.value;

  void openPicker() {
    showTimePicker(
      context: _field.context,
      initialTime: TimeOfDay.now(),
    ).then(_field.didChange);
  }
}
