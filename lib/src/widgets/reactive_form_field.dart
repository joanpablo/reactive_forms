// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Signature for building the widget representing the form field.
///
/// Used by [FormField.builder].
typedef ReactiveFormFieldBuilder<T> = Widget Function(
    ReactiveFormFieldState<T> field);

/// A single reactive form field.
///
/// This widget maintains the current state of the reactive form field,
/// so that updates and validation errors are visually reflected in the UI.
///
/// It is the base class for all other reactive widgets.
class ReactiveFormField<T> extends StatefulWidget {
  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final ReactiveFormFieldBuilder<T> _builder;
  final String formControlName;
  final Map<String, String> validationMessages;

  /// Creates an instance of the [ReactiveFormField].
  ///
  /// The [formControlName] and [builder] arguments are required.
  const ReactiveFormField({
    Key key,
    @required this.formControlName,
    @required ReactiveFormFieldBuilder<T> builder,
    Map<String, String> validationMessages,
  })  : assert(formControlName != null),
        assert(builder != null),
        _builder = builder,
        validationMessages = validationMessages ?? const {},
        super(key: key);

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}

/// Represents the state of the [ReactiveFormField] stateful widget.
class ReactiveFormFieldState<T> extends State<ReactiveFormField<T>> {
  FormControl control;
  bool _touched;

  /// The current value of the [FormControl].
  T get value => this.control.value;

  /// Gets true if the widget is touched, otherwise return false.
  bool get touched => _touched;

  /// Sets the value of [touched] and rebuilds the widget.
  set touched(bool value) {
    if (this._touched != value) {
      setState(() {
        this._touched = value;
      });
    }
  }

  /// Gets the error text calculated from validators of the control.
  ///
  /// If the control has several errors, then the first error is selected
  /// for visualizing in UI.
  String get errorText {
    if (this.control.invalid && this.touched) {
      return widget.validationMessages
              .containsKey(this.control.errors.keys.first)
          ? widget.validationMessages[this.control.errors.keys.first]
          : this.control.errors.keys.first;
    }

    return null;
  }

  @override
  void initState() {
    this.control = _getFormControl();
    this.subscribeControl();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final newControl = _getFormControl();
    if (this.control != newControl) {
      this.unsubscribeControl();
      this.control = newControl;
      subscribeControl();
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this.unsubscribeControl();
    super.dispose();
  }

  @protected
  void subscribeControl() {
    this.control.onStatusChanged.addListener(_onControlStatusChanged);
    this.control.onValueChanged.addListener(_onControlValueChanged);
    this.control.onTouched.addListener(_onControlTouched);

    this._touched = this.control.touched;
  }

  @protected
  void unsubscribeControl() {
    this.control.onStatusChanged.removeListener(_onControlStatusChanged);
    this.control.onValueChanged.removeListener(_onControlValueChanged);
    this.control.onTouched.removeListener(_onControlTouched);
  }

  FormControl _getFormControl() {
    final form =
        ReactiveForm.of(context, listen: false) as FormControlCollection;
    if (form == null) {
      throw FormControlParentNotFoundException(widget);
    }

    return form.control(widget.formControlName);
  }

  void _onControlValueChanged() {
    this.updateValueFromControl();
  }

  @protected
  void updateValueFromControl() {
    touch();
  }

  @protected
  void touch() {
    this.control.touch();
  }

  void _onControlStatusChanged() {
    setState(() {});
  }

  void _onControlTouched() {
    this.touched = this.control.touched;
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes.
  ///
  /// Updates the value of the [FormControl] bound to this widget.
  void didChange(T value) {
    this.control.value = value;
    if (this.touched) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(this);
  }
}
