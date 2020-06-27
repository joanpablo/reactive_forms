import 'package:flutter/foundation.dart';
import 'package:reactive_forms/models/form_control.dart';
import 'package:reactive_forms/validators/validators.dart';

class FormGroup extends ChangeNotifier {
  final Map<String, FormControl> _controls;
  final List<FormGroupValidatorFunction> validators;

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

  bool _valid = true;
  bool get valid => _valid;

  bool get invalid => !this.valid;

  FormControl formControl(String name) {
    return this._controls[name];
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
