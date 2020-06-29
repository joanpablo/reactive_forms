import 'package:reactive_forms/validators/email_validator.dart';
import 'package:reactive_forms/validators/max_length_validator.dart';
import 'package:reactive_forms/validators/min_length_validator.dart';
import 'package:reactive_forms/validators/number_validator.dart';
import 'package:reactive_forms/validators/pattern_validator.dart';
import 'package:reactive_forms/validators/required_validator.dart';

typedef ValidatorFunction = Map<String, dynamic> Function(String value);

class Validators {
  static ValidatorFunction get required => RequiredValidator().validate;

  static ValidatorFunction get email => EmailValidator().validate;

  static ValidatorFunction get number => NumberValidator().validate;

  static ValidatorFunction minLength(int minLength) =>
      MinLengthValidator(minLength).validate;

  static ValidatorFunction maxLength(int maxLength) =>
      MaxLengthValidator(maxLength).validate;

  static ValidatorFunction pattern(Pattern pattern) =>
      PatternValidator(pattern).validate;
}
