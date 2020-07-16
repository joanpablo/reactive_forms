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

class ReactiveFormField<T> extends StatefulWidget {
  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final ReactiveFormFieldBuilder<T> _builder;
  final String formControlName;
  final Map<String, String> validationMessages;

  const ReactiveFormField({
    Key key,
    @required this.formControlName,
    @required ReactiveFormFieldBuilder<T> builder,
    Map<String, String> validationMessages,
  })  : assert(formControlName != null),
        assert(builder != null),
        validationMessages = validationMessages ?? const {},
        _builder = builder,
        super(key: key);

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}

class ReactiveFormFieldState<T> extends State<ReactiveFormField<T>> {
  FormControl control;
  bool _touched;

  /// The current value of the [FormControl].
  T get value => this.control.value;

  bool get touched => _touched;

  set touched(bool value) {
    if (this._touched != value) {
      setState(() {
        this._touched = value;
      });
    }
  }

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
