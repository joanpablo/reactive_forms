import 'package:reactive_forms/models/abstract_control.dart';
import 'package:reactive_forms/validators/validator.dart';

class NumberValidator extends Validator {
  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return (control.value == null || int.tryParse(control.value) == null)
        ? {'number': true}
        : null;
  }
}
