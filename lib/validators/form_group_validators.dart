import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/validators/must_match_validator.dart';

typedef FormGroupValidatorFunction = Map<String, dynamic> Function(
    FormGroup formGroup);

class FormGroupValidators {
  static FormGroupValidatorFunction mustMatch(
      String controlName, String matchingControlName) {
    return MustMatchValidator(controlName, matchingControlName).validate;
  }
}
