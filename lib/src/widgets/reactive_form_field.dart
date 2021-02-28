// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/exceptions/binding_cast_exception.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/default_value_accessor.dart';

/// Signature for building the widget representing the form field.
///
/// Used by [FormField.builder].
typedef ReactiveFormFieldBuilder<T> = Widget Function(
    ReactiveFormFieldState<T> field);

/// Signature for customize when to show errors in a widget.
typedef ShowErrorsFunction = bool Function(AbstractControl<dynamic> control);

/// Signature of the function that returns the [Map] that store custom
/// validation messages for each error.
typedef ValidationMessagesFunction<T> = Map<String, String> Function(
    FormControl<T> control);

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

  /// The name of the [FormControl] that is bound to this widget.
  final String? formControlName;

  /// The control that is bound to this widget.

  final FormControl<T>? formControl;

  /// A function that returns the [Map] that store custom validation messages
  /// for each error.
  final ValidationMessagesFunction<T>? validationMessages;

  /// Gets the widget control value accessor
  final ControlValueAccessor<T, dynamic>? valueAccessor;

  /// Gets the callback that define when to show errors in UI.
  final ShowErrorsFunction? showErrors;

  /// Creates an instance of the [ReactiveFormField].
  ///
  /// Must provide a [forControlName] or a [formControl] but not both
  /// at the same time.
  ///
  /// The [builder] arguments are required.
  const ReactiveFormField({
    Key? key,
    this.formControl,
    this.formControlName,
    this.valueAccessor,
    this.showErrors,
    required ReactiveFormFieldBuilder<T> builder,
    ValidationMessagesFunction<T>? validationMessages,
  })  : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.'),
        _builder = builder,
        validationMessages = validationMessages,
        super(key: key);

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}

/// Represents the state of the [ReactiveFormField] stateful widget.
class ReactiveFormFieldState<T> extends State<ReactiveFormField<T>> {
  /// The [FormControl] that is bound to this state.

  FormControl<T>? control;
  StreamSubscription? _statusChangesSubscription;
  StreamSubscription? _touchChangesSubscription;
  ControlValueAccessor<T, dynamic>? _valueAccessor;

  /// Gets the value of the [FormControl] given by the [valueAccessor].
  dynamic get value =>
      this.valueAccessor?.modelToViewValue(this.control?.value);

  /// Gets true if the widget is touched, otherwise return false.
  bool get touched => this.control?.touched == true;

  /// Gets the widget control value accessor

  ControlValueAccessor<T, dynamic>? get valueAccessor => _valueAccessor;

  /// Gets the error text calculated from validators of the control.
  ///
  /// If the control has several errors, then the first error is selected
  /// for visualizing in UI.
  String? get errorText {
    if (_showErrors()) {
      final validationMessages = _getValidationMessages(this.control);
      return validationMessages.containsKey(this.control?.errors.keys.first)
          ? validationMessages[this.control?.errors.keys.first]
          : this.control?.errors.keys.first;
    }

    return null;
  }

  bool _showErrors() {
    if (widget.showErrors != null && this.control != null) {
      return widget.showErrors!(this.control!);
    }

    return this.control?.invalid == true && this.touched;
  }

  Map<String, String> _getValidationMessages(FormControl<T>? control) {
    return widget.validationMessages != null && control != null
        ? widget.validationMessages!(control)
        : Map<String, String>();
  }

  @override
  void initState() {
    this.control = _resolveFormControl();
    _valueAccessor = _resolveValueAccessor();
    this.subscribeControl();

    super.initState();
  }

  /// Returns the value accessor for the reactive widget.
  ///
  /// Must be override by children widgets to provide custom [valueAccessor]
  /// implementations to the widget.
  ///
  /// See [ControlValueAccessor].
  @protected
  @visibleForTesting
  ControlValueAccessor<T, dynamic> selectValueAccessor() {
    return DefaultValueAccessor<T>();
  }

  @override
  void didUpdateWidget(ReactiveFormField<T> oldWidget) {
    if (widget.valueAccessor != null &&
        widget.valueAccessor != this.valueAccessor) {
      this.valueAccessor?.dispose();
      _valueAccessor = widget.valueAccessor!;
      _subscribeValueAccessor();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    final newControl = _resolveFormControl();
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
    _valueAccessor?.dispose();
    super.dispose();
  }

  @protected
  @mustCallSuper
  void subscribeControl() {
    _statusChangesSubscription =
        this.control?.statusChanged.listen(_onControlStatusChanged);
    _touchChangesSubscription =
        this.control?.touchChanges.listen(_onControlTouchChanged);
    _subscribeValueAccessor();
  }

  @protected
  @mustCallSuper
  void unsubscribeControl() {
    _statusChangesSubscription?.cancel();
    _touchChangesSubscription?.cancel();
    this.valueAccessor?.dispose();
  }

  @protected
  @mustCallSuper
  void onControlValueChanged(dynamic value) {
    _checkTouchedState();
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes.
  ///
  /// Updates the value of the [FormControl] bound to this widget.

  void didChange(T? value) {
    _valueAccessor?.updateModel(value);
    _checkTouchedState();
  }

  void _subscribeValueAccessor() {
    if (valueAccessor != null && this.control != null) {
      _valueAccessor!.registerControl(
        this.control!,
        onChange: this.onControlValueChanged,
      );
    }
  }

  void _checkTouchedState() {
    if (this.touched) {
      setState(() {});
    }
  }

  void _onControlStatusChanged(ControlStatus status) {
    setState(() {});
  }

  void _onControlTouchChanged(bool touched) {
    setState(() {});
  }

  ControlValueAccessor<T, dynamic> _resolveValueAccessor() {
    return widget.valueAccessor ?? this.selectValueAccessor();
  }

  FormControl<T> _resolveFormControl() {
    if (widget.formControl != null) {
      return widget.formControl!;
    }

    final FormControlCollection? form =
        ReactiveForm.of(context, listen: false) as FormControlCollection?;
    // ignore: unnecessary_null_comparison
    if (form == null) {
      throw FormControlParentNotFoundException(widget);
    }

    final control = form.control(widget.formControlName!);
    if (control is FormControl) {
      if (!(control is FormControl<T>)) {
        throw BindingCastException<T>(this.widget, control);
      }
      return control;
    }
    throw FormControlParentNotFoundException(widget);
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(this);
  }
}
