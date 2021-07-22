import 'dart:async';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

/// Tracks the value and validation status of an individual form control.
class FormControl<T> extends AbstractControl<T> {
  final _focusChanges = StreamController<bool>.broadcast();
  FocusController? _focusController;
  bool _hasFocus = false;

  /// Creates a new FormControl instance.
  ///
  /// The control can optionally be initialized with a [value].
  ///
  /// The control can optionally have [validators] that validates
  /// the control each time the value changes.
  ///
  /// The control can optionally have [asyncValidators] that validates
  /// asynchronously the control each time the value changes. Asynchronous
  /// validation executes after the synchronous validation, and is performed
  /// only if the synchronous validation is successful. This check allows
  /// forms to avoid potentially expensive async validation processes
  /// (such as an HTTP request) if the more basic validation methods have
  /// already found invalid input.
  ///
  /// You can set an [asyncValidatorsDebounceTime] in millisecond to set
  /// a delay time before trigger async validators. This is useful for
  /// minimizing request to a server. The default value is 250 milliseconds.
  ///
  /// You can set [touched] as true to force the validation messages
  /// to show up at the very first time the widget that is bound to this
  /// control builds in the UI.
  ///
  /// If [disabled] is true then the control is disabled by default.
  ///
  /// ### Example:
  /// ```dart
  /// final priceControl = FormControl<double>(defaultValue: 0.0);
  /// ```
  ///
  FormControl({
    T? value,
    List<ValidatorFunction> validators = const [],
    List<AsyncValidatorFunction> asyncValidators = const [],
    int asyncValidatorsDebounceTime = 250,
    bool touched = false,
    bool disabled = false,
  }) : super(
          validators: validators,
          asyncValidators: asyncValidators,
          asyncValidatorsDebounceTime: asyncValidatorsDebounceTime,
          disabled: disabled,
          touched: touched,
        ) {
    if (value != null) {
      this.value = value;
    } else {
      updateValueAndValidity();
    }
  }

  /// True if the control is marked as focused.
  bool get hasFocus => _hasFocus;

  /// Gets the focus controller registered with in this control.
  ///
  /// Don't use [focusController] to add/remove focus to a control,
  /// use instead **control.focus()** and **control.unfocus()**.
  ///
  /// Don't use [focusController] to know if the control has focus, use instead
  /// **control.hasFocus**.
  ///
  /// Use only [focusController] if you want to access the inner UI [FocusNode]
  /// of the control.
  ///
  /// ## Example
  /// Access the inner UI [FocusNode] of the control
  /// ```dart
  /// FormControl control = this.form.control('email');
  ///
  /// final focusNode =  control.focusController.focusNode;
  /// ```
  /// See also [focus()].
  ///
  /// See also [unfocus()].
  ///
  /// See also [hasFocus].
  FocusController? get focusController => _focusController;

  /// Disposes the control
  @override
  void dispose() {
    _focusChanges.close();
    super.dispose();
  }

  /// A [ChangeNotifier] that emits an event every time the focus status of
  /// the control changes.
  Stream<bool> get focusChanges => _focusChanges.stream;

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
  @override
  void unfocus({bool touched = true}) {
    if (hasFocus) {
      _updateFocusState(false);
    }

    if (touched == false) {
      markAsUntouched();
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
  @override
  void focus() {
    if (!hasFocus) {
      _updateFocusState(true);
    }
  }

  // TODO: there is something wrong with this method, it need an evaluation
  /// Removes the provided [focusController] from the control.
  void unregisterFocusController(FocusController focusController) {
    if (_focusController != null && _focusController == focusController) {
      _focusController!.removeListener(_onFocusControllerChanged);
      _focusController = null;
    }
  }

  /// Registers a focus controller.
  ///
  /// The [focusController] represents the focus controller of this control.
  void registerFocusController(FocusController focusController) {
    if (_focusController == focusController) {
      return;
    }

    if (_focusController != null) {
      unregisterFocusController(_focusController!);
    }

    _focusController = focusController;
    _focusController!.addListener(_onFocusControllerChanged);
  }

  void _onFocusControllerChanged() {
    _updateFocusState(
      _focusController!.hasFocus,
      notifyFocusController: false,
    );

    if (_focusController!.hasFocus == false) {
      markAsTouched();
    }
  }

  void _updateFocusState(bool value, {bool notifyFocusController = true}) {
    _hasFocus = value;
    _focusChanges.add(_hasFocus);

    if (notifyFocusController) {
      _focusController?.onControlFocusChanged(_hasFocus);
    }
  }

  @override
  T? reduceValue() => value;

  /// Sets the [value] of the [FormControl].
  ///
  /// When [updateParent] is true or not supplied (the default) each change
  /// affects this control and its parent, otherwise only affects to this
  /// control.
  ///
  /// When [emitEvent] is true or not supplied (the default), both the
  /// *statusChanges* and *valueChanges* emit events with the latest status
  /// and value when the control is reset. When false, no events are emitted.
  @override
  void updateValue(
    T? value, {
    bool updateParent = true,
    bool emitEvent = true,
  }) {
    if (val != value) {
      val = value;

      updateValueAndValidity(
        updateParent: updateParent,
        emitEvent: emitEvent,
      );
    }
  }

  /// Patches the [value] of a control.
  ///
  /// This function is functionally the same as [FormControl.updateValue] at
  /// this level. It exists for symmetry with [FormGroup.patchValue] on
  /// [FormGroup] and [FormArray.patchValue] in [FormArray] where it does
  /// behave differently.
  ///
  /// When [updateParent] is true or not supplied (the default) each change
  /// affects this control and its parent, otherwise only affects to this
  /// control.
  ///
  /// When [emitEvent] is true or not supplied (the default), both the
  /// *statusChanges* and *valueChanges* emit events with the latest status
  /// and value when the control is reset. When false, no events are emitted.
  @override
  void patchValue(T? value, {bool updateParent = true, bool emitEvent = true}) {
    updateValue(value, updateParent: updateParent, emitEvent: emitEvent);
  }

  @override
  void forEachChild(void Function(AbstractControl<dynamic>) callback) =>
      <AbstractControl<dynamic>>[];

  @override
  bool anyControls(bool Function(AbstractControl<dynamic>) condition) => false;

  @override
  AbstractControl<dynamic> findControl(String path) => this;
}
