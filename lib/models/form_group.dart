import 'package:flutter/foundation.dart';
import 'package:reactive_forms/models/form_control.dart';
import 'package:reactive_forms/validators/form_group_validators.dart';

/// Tracks the value and validity state of a group of FormControl instances.
///
/// A FormGroup aggregates the values of each child FormControl into one object,
/// with each control name as the key.
///
/// It calculates its status by reducing the status values of its children.
/// For example, if one of the controls in a group is invalid, the entire group
/// becomes invalid.
///
class FormGroup extends ChangeNotifier {
  final Map<String, FormControl> _controls;

  bool _valid = true;

  /// These come in handy when you want to perform validation that considers
  /// the value of more than one child control.
  final List<FormGroupValidatorFunction> validators;

  /// Creates a new FormGroup instance.
  ///
  /// When instantiating a [FormGroup], pass in a collection of child controls
  /// as the first argument.
  ///
  /// The key for each child registers the name for the control.
  ///
  /// ### Example:
  ///
  ///     final form = FromGroup({
  ///       'name': FormControl(defaultValue: 'John Doe'),
  ///       'email': FormControl(),
  ///     });
  ///
  /// You can also set [validators] as optionally argument.
  ///
  /// See also [FormGroup.validators]
  ///
  FormGroup(
    Map<String, FormControl> controls, {
    this.validators = const [],
  })  : assert(controls != null),
        _controls = controls {
    _validate();
    this._controls.forEach((_, formControl) {
      formControl.addListener(() {
        _validate();
      });
    });
  }

  /// True if all the controls contained in this group are valid. If at least
  /// one [FormControl] is invalid then the [FormGroup] is invalid.
  bool get valid => _valid;

  /// True if at least one [FormControl] is invalid.
  bool get invalid => !this.valid;

  /// Returns a [FormControl] by its name.
  FormControl formControl(String name) {
    return this._controls[name];
  }

  /// Returns the current value of the group.
  /// The values of controls as an object with
  /// a key-value pair for each control in the group.
  ///
  /// ### Example:
  ///
  ///     final form = FormGroup({
  ///       'name': FormControl(defaultValue: 'John Doe'),
  ///       'email': FormControl(defaultValue: 'johndoe@email.com'),
  ///     });
  ///
  ///     print(form.value);
  ///
  ///     { "name": "John Doe", "email": "johndoe@email.com" }
  ///
  Map<String, dynamic> get value {
    final map = Map<String, dynamic>();
    this._controls.forEach((key, formControl) {
      map[key] = formControl.value;
    });

    return map;
  }

  /// Resets all the form controls of the group, marking them as untouched,
  /// and setting the [FormControl.value] to [FormControl.defaultValue].
  ///
  /// See also [FormControl.reset()]
  ///
  void reset() {
    this._controls.forEach((key, formControl) {
      formControl.reset();
    });
  }

  void _validate() {
    final validity =
        this.validators.any((validator) => validator(this) != null);

    final controlsValidity = _controls.keys.any((formControlName) {
      return _controls[formControlName].invalid;
    });

    this._setValidity(!validity && !controlsValidity);
  }

  void _setValidity(bool validity) {
    if (this.valid != validity) {
      this._valid = validity;
      notifyListeners();
    }
  }
}
