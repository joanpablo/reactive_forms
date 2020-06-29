import 'package:reactive_forms/validators/validator.dart';

class RequiredValidator extends Validator {
  @override
  Map<String, dynamic> validate(dynamic value) {
    final error = {'required': true};

    if (value == null) {
      return error;
    } else if (value is String) {
      return value.trim().isEmpty ? error : null;
    }

    return null;
  }
}
