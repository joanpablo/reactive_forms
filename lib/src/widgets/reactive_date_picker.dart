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
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate selectableDayPredicate,
    String helpText,
    String cancelText,
    String confirmText,
    Locale locale,
    bool useRootNavigator = true,
    RouteSettings routeSettings,
    TextDirection textDirection,
    TransitionBuilder transitionBuilder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String errorFormatText,
    String errorInvalidText,
    String fieldHintText,
    String fieldLabelText,
    Widget child,
  })  : assert(builder != null),
        super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<DateTime> field) {
            return builder(
                field.context,
                ReactiveDatePickerDelegate._(
                  field,
                  () => showDatePicker(
                    context: field.context,
                    initialDate: field.value ?? DateTime.now(),
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
                  ).then(field.didChange),
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
  final VoidCallback _showPickerCallback;

  ReactiveDatePickerDelegate._(this._field, this._showPickerCallback);

  AbstractControl<DateTime> get control =>
      _field.control as AbstractControl<DateTime>;

  DateTime get value => this.control.value;

  void showPicker() {
    this._showPickerCallback();
  }
}
