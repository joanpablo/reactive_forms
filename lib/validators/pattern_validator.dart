import 'package:reactive_forms/validators/validator.dart';

class PatternValidator extends Validator {
  final Pattern pattern;

  PatternValidator(this.pattern);

  @override
  Map<String, dynamic> validate(dynamic value) {
    RegExp regex = new RegExp(this.pattern);
    return (value == null || value == '' || regex.hasMatch(value))
        ? null
        : {
            'pattern': {
              'requiredPattern': this.pattern.toString(),
              'actualValue': value,
            }
          };
  }
}
