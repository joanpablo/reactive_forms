import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/exceptions/form_control_not_found_exception.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Signature for building the widget representing the form field.
///
/// Used by [FormField.builder].
typedef ReactiveFormFieldBuilder<T> = Widget Function(
    ReactiveFormFieldState<T> field);

class ReactiveFormField<T> extends StatefulWidget {
  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final ReactiveFormFieldBuilder<T> builder;
  final String formControlName;
  final Map<String, String> validationMessages;

  const ReactiveFormField({
    Key key,
    @required this.formControlName,
    @required this.builder,
    @required this.validationMessages,
  }) : super(key: key);

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}

class ReactiveFormFieldState<T> extends State<ReactiveFormField<T>> {
  FormControl control;

  StreamSubscription _statusChangeSubscription;

  /// The current value of the [FormControl].
  T get value => control.value;

  String get errorText {
    if (control.invalid && control.touched) {
      return widget.validationMessages.containsKey(control.errors.keys.first)
          ? widget.validationMessages[control.errors.keys.first]
          : control.errors.keys.first;
    }

    return null;
  }

  @override
  void initState() {
    final form = ReactiveForm.of(context, listen: false);
    this.control = form.formControl(widget.formControlName);
    if (this.control == null) {
      throw FormControlNotFoundException(widget.formControlName);
    }

    this.subscribeFormControl();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final form = ReactiveForm.of(context, listen: false);
    final newControl = form.formControl(widget.formControlName);
    if (this.control != newControl) {
      this.unsubscribeFormControl();
      this.control = newControl;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this.unsubscribeFormControl();
    super.dispose();
  }

  @protected
  void subscribeFormControl() {
    _statusChangeSubscription =
        this.control.onStatusChanged.listen(_onFormControlStatusChanged);

    control.addListener(_onFormControlValueChanged);
  }

  @protected
  void unsubscribeFormControl() {
    control.removeListener(_onFormControlValueChanged);
    _statusChangeSubscription.cancel();
  }

  void _onFormControlValueChanged() {
    this.updateValueFromControl();
  }

  @protected
  void updateValueFromControl() {
    touch();
  }

  void _onFormControlStatusChanged(_) {
    touch();
  }

  void didChange(T value) {
    this.control.value = value;
    if (this.control.touched) {
      setState(() {});
    }
  }

  void touch() {
    setState(() {
      control.touched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }
}
