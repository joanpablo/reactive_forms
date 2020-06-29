import 'package:reactive_forms/validators/validator.dart';

class EmailValidator extends Validator {
  static final Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  Map<String, dynamic> validate(dynamic value) {
    RegExp regex = new RegExp(EmailValidator.pattern);
    return (value == null || value == '' || regex.hasMatch(value))
        ? null
        : {'email': true};
  }
}
