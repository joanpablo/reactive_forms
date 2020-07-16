import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveDatePickerBuilder = Widget Function(
    BuildContext context, ReactiveDatePickerDelegate picker, Widget child);

class ReactiveDatePicker extends ReactiveFormField<DateTime> {
  ReactiveDatePicker({
    Key key,
    @required String formControlName,
    @required ReactiveDatePickerBuilder builder,
    @required DateTime firstDate,
    @required DateTime lastDate,
    Widget child,
  })  : assert(builder != null),
        super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<DateTime> field) {
            return builder(
                field.context,
                ReactiveDatePickerDelegate._(
                  field,
                  firstDate: firstDate,
                  lastDate: lastDate,
                ),
                child);
          },
        );

  @override
  ReactiveFormFieldState<DateTime> createState() =>
      ReactiveFormFieldState<DateTime>();
}

class ReactiveDatePickerDelegate {
  final ReactiveFormFieldState<DateTime> _field;
  final DateTime firstDate;
  final DateTime lastDate;

  ReactiveDatePickerDelegate._(
    this._field, {
    @required this.firstDate,
    @required this.lastDate,
  });

  AbstractControl<DateTime> get control =>
      _field.control as AbstractControl<DateTime>;

  DateTime get dateTime => control.value;

  void openPicker() {
    showDatePicker(
      context: _field.context,
      initialDate: this.control.value ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then(_field.didChange);
  }
}
