import 'package:reactive_forms/validators/validator.dart';

class NumberValidator extends Validator {
  @override
  Map<String, dynamic> validate(dynamic value) {
    return (value == null || int.tryParse(value) == null)
        ? {'number': true}
        : null;
  }
}
