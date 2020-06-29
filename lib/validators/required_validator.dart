import 'package:reactive_forms/validators/validator.dart';

class RequiredValidator extends Validator {
  @override
  Map<String, dynamic> validate(dynamic value) {
    if (value == null) {
      return {'required': true};
    }

    if (value is String) {
      return value.trim().isNotEmpty ? null : {'required': true};
    }

    return null;
  }
}
