import 'package:reactive_forms/validators/validator.dart';

class RequiredValidator extends Validator {
  @override
  Map<String, dynamic> validate(String value) {
    return (value != null && value.trim().isNotEmpty)
        ? null
        : {'required': true};
  }
}
