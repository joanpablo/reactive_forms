// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Signature for building the widget representing the form field.
///
/// Used by [FormField.builder].
typedef ReactiveFormFieldBuilder<T, K> = Widget Function(
    ReactiveFormFieldState<T, K> field);

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
class ReactiveFormField<ModelDataType, ViewDataType> extends StatefulWidget {
  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final ReactiveFormFieldBuilder<ModelDataType, ViewDataType> _builder;

  /// The name of the [FormControl] that is bound to this widget.
  final String? formControlName;

  /// The control that is bound to this widget.
  final FormControl<ModelDataType>? formControl;

  /// A function that returns the [Map] that store custom validation messages
  /// for each error.
  final ValidationMessagesFunction<ModelDataType>? validationMessages;

  /// Gets the widget control value accessor
  final ControlValueAccessor<ModelDataType, ViewDataType>? valueAccessor;

  /// Gets the callback that define when to show errors in UI.
  final ShowErrorsFunction? showErrors;

  /// Creates an instance of the [ReactiveFormField].
  ///
  /// Must provide a [forControlName] or a [formControl] but not both
  /// at the same time.
  ///
  /// The [builder] arguments are required.
  ReactiveFormField({
    Key? key,
    this.formControl,
    this.formControlName,
    this.valueAccessor,
    this.showErrors,
    this.validationMessages,
    required ReactiveFormFieldBuilder<ModelDataType, ViewDataType> builder,
  })  : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.'),
        _builder = builder,
        super(key: key);

  @override
  ReactiveFormFieldState<ModelDataType, ViewDataType> createState() =>
      ReactiveFormFieldState<ModelDataType, ViewDataType>();
}

/// Represents the state of the [ReactiveFormField] stateful widget.
class ReactiveFormFieldState<ModelDataType, ViewDataType>
    extends State<ReactiveFormField<ModelDataType, ViewDataType>> {
  /// The [FormControl] that is bound to this state.
  late FormControl<ModelDataType> control;
  late StreamSubscription<ControlStatus> _statusChangesSubscription;
  late StreamSubscription<bool> _touchChangesSubscription;
  late ControlValueAccessor<ModelDataType, ViewDataType> _valueAccessor;

  /// Gets the value of the [FormControl] given by the [valueAccessor].
  ViewDataType? get value => valueAccessor.modelToViewValue(control.value);

  /// Gets true if the widget is touched, otherwise return false.
  bool get touched => control.touched;

  /// Gets the widget control value accessor
  ControlValueAccessor<ModelDataType, ViewDataType> get valueAccessor =>
      _valueAccessor;

  /// Gets the error text calculated from validators of the control.
  ///
  /// If the control has several errors, then the first error is selected
  /// for visualizing in UI.
  String? get errorText {
    if (_showErrors()) {
      final validationMessages = _getValidationMessages(control);
      return validationMessages.containsKey(control.errors.keys.first)
          ? validationMessages[control.errors.keys.first]
          : control.errors.keys.first;
    }

    return null;
  }

  bool _showErrors() {
    if (widget.showErrors != null) {
      return widget.showErrors!(control);
    }

    return control.invalid && touched;
  }

  Map<String, String> _getValidationMessages(FormControl<dynamic> control) {
    return widget.validationMessages != null
        ? widget.validationMessages!(this.control)
        : <String, String>{};
  }

  @override
  void initState() {
    control = _resolveFormControl();
    _valueAccessor = _resolveValueAccessor();
    subscribeControl();

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
  ControlValueAccessor<ModelDataType, ViewDataType> selectValueAccessor() {
    return DefaultValueAccessor();
  }

  @override
  void didUpdateWidget(
      ReactiveFormField<ModelDataType, ViewDataType> oldWidget) {
    if (widget.valueAccessor != null && widget.valueAccessor != valueAccessor) {
      valueAccessor.dispose();
      _valueAccessor = widget.valueAccessor!;
      _subscribeValueAccessor();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    final newControl = _resolveFormControl();
    if (control != newControl) {
      unsubscribeControl();
      control = newControl;
      subscribeControl();
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    unsubscribeControl();
    _valueAccessor.dispose();
    super.dispose();
  }

  @protected
  @mustCallSuper
  void subscribeControl() {
    _statusChangesSubscription =
        control.statusChanged.listen(_onControlStatusChanged);
    _touchChangesSubscription =
        control.touchChanges.listen(_onControlTouchChanged);
    _subscribeValueAccessor();
  }

  @protected
  @mustCallSuper
  void unsubscribeControl() {
    _statusChangesSubscription.cancel();
    _touchChangesSubscription.cancel();
    valueAccessor.dispose();
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
  void didChange(ViewDataType? value) {
    _valueAccessor.updateModel(value);
    _checkTouchedState();
  }

  void _subscribeValueAccessor() {
    _valueAccessor.registerControl(
      control,
      onChange: onControlValueChanged,
    );
  }

  void _checkTouchedState() {
    if (touched) {
      setState(() {});
    }
  }

  void _onControlStatusChanged(ControlStatus status) {
    setState(() {});
  }

  void _onControlTouchChanged(bool touched) {
    setState(() {});
  }

  ControlValueAccessor<ModelDataType, ViewDataType> _resolveValueAccessor() {
    return widget.valueAccessor ?? selectValueAccessor();
  }

  FormControl<ModelDataType> _resolveFormControl() {
    if (widget.formControl != null) {
      return widget.formControl!;
    }

    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(widget);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(widget.formControlName!);
    if (control is! FormControl<ModelDataType>) {
      throw BindingCastException<ModelDataType, ViewDataType>(widget, control);
    }

    return control;
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(this);
  }
}
