import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Tracks the value and validation status of an individual form control.
class FormControl<T> extends AbstractControl<T> {
  final _onFocusChanged = ValueNotifier<bool>(false);
  final _onValueChanged = ValueNotifier<T>(null);
  T _defaultValue;
  T _value;

  /// The list of functions that determines the validity of this control.
  final List<ValidatorFunction> validators;

  /// Represents if the control is touched or not. A control is touched when
  /// the user taps on the ReactiveFormField widget and then remove focus or
  /// completes the text edition. Validation messages will begin to show up
  /// when the FormControl is touched.
  bool touched;

  /// Creates a new FormControl instance, optionally pass [defaultValue]
  /// and [validators]. You can set [touched] to true to force the validation
  /// messages to show up at the very first time the widget builds.
  ///
  /// You can also force the data type of this control by specifying it
  ///
  /// ### Example:
  /// ```dart
  /// final priceControl = FormControl<double>(defaultValue: 0.0);
  /// ```
  ///
  FormControl({
    T defaultValue,
    this.validators = const [],
    this.touched = false,
  }) : _defaultValue = defaultValue {
    this.value = _defaultValue;
  }

  /// Returns the current value of the control.
  @override
  T get value => this._value;

  /// Returns the default value of the control.
  T get defaultValue => _defaultValue;

  /// True if the control is marked as focused.
  bool get focused => _onFocusChanged.value;

  /// Sets the [newValue] as value for the form control.
  @override
  set value(T newValue) {
    this._value = newValue;
    _validate();
    _onValueChanged.value = this._value;
  }

  /// Disposes the control
  @override
  void dispose() {
    _onFocusChanged.dispose();
    _onValueChanged.dispose();

    super.dispose();
  }

  /// A [ValueListenable] that emits an event every time the value
  /// of the control changes.
  @override
  ValueListenable<T> get onValueChanged => _onValueChanged;

  /// A [ChangeNotifier] that emits an event every time the focus status of
  /// the control changes.
  ChangeNotifier get onFocusChanged => _onFocusChanged;

  /// Resets the form control, marking it as untouched,
  /// and setting the [value] to [defaultValue].
  @override
  void reset() {
    this.touched = false;
    this.value = this.defaultValue;
  }

  /// Remove focus on a ReactiveFormField widget without the interaction
  /// of the user.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final formControl = form.formControl('name');
  ///
  /// // UI text field lose focus
  /// formControl.unfocus();
  ///```
  ///
  void unfocus() {
    if (this.focused) {
      _onFocusChanged.value = false;
    }
  }

  /// Sets focus on a ReactiveFormField widget without the interaction
  /// of the user.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final formControl = form.formControl('name');
  ///
  /// // UI text field get focus and the device keyboard pop up
  /// formControl.focus();
  ///```
  ///
  void focus() {
    if (!this.focused) {
      _onFocusChanged.value = true;
    }
  }

  void _validate() {
    final errors = Map<String, dynamic>();
    this.validators.forEach((validator) {
      final error = validator(this);
      if (error != null) {
        errors.addAll(error);
      }
    });

    this.setErrors(errors);
  }
}
