import 'package:reactive_forms/models/abstract_control.dart';
import 'package:reactive_forms/validators/validator.dart';

class MaxLengthValidator extends Validator {
  final int maxLength;

  MaxLengthValidator(this.maxLength);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return (control.value == null || control.value.length <= this.maxLength)
        ? null
        : {
            'maxLength': {
              'requiredLength': this.maxLength,
              'actualLength': control.value.length,
            }
          };
  }
}
