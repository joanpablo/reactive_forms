import 'package:reactive_forms/models/abstract_control.dart';
import 'package:reactive_forms/validators/validator.dart';

class PatternValidator extends Validator {
  final Pattern pattern;

  PatternValidator(this.pattern);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    RegExp regex = new RegExp(this.pattern);
    return (control.value == null ||
            control.value == '' ||
            regex.hasMatch(control.value))
        ? null
        : {
            'pattern': {
              'requiredPattern': this.pattern.toString(),
              'actualValue': control.value,
            }
          };
  }
}
