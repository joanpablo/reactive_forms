import 'package:reactive_forms/validators/validator.dart';

class MinLengthValidator extends Validator {
  final int minLength;

  MinLengthValidator(this.minLength);

  @override
  Map<String, dynamic> validate(dynamic value) {
    return (value == null || value.length >= this.minLength)
        ? null
        : {
            'minLength': {
              'requiredLength': this.minLength,
              'actualLength': value.length,
            }
          };
  }
}
