import 'package:reactive_forms/validators/validator.dart';

class MaxLengthValidator extends Validator {
  final int maxLength;

  MaxLengthValidator(this.maxLength);

  @override
  Map<String, dynamic> validate(dynamic value) {
    return (value == null || value.length <= this.maxLength)
        ? null
        : {
            'maxLength': {
              'requiredLength': this.maxLength,
              'actualLength': value.length,
            }
          };
  }
}
