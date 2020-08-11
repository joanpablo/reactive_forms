import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/number_validator.dart';

/// A credit card validator that validates that the control's value is a valid
/// credit card.
class CreditCardValidator extends Validator {
  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final error = {ValidationMessage.creditCard: true};
    // error if value is not a String
    if (control.value != null && !(control.value is String)) {
      return error;
    }

    final cardNumber = control.value.toString().replaceAll(' ', '');
    final isNumber = NumberValidator.numberRegex.hasMatch(cardNumber);

    return cardNumber == null || (isNumber && checkLuhn(cardNumber))
        ? null
        : error;
  }

  /// Return true if the [cardNumber] is valid card number, otherwise returns
  /// false.
  ///
  /// See [Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
  static bool checkLuhn(String cardNumber) {
    int sum = int.parse(cardNumber[cardNumber.length - 1]);

    for (int i = 0; i < cardNumber.length - 2; i++) {
      int digit = int.parse(cardNumber[i]);

      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
    }

    return sum % 10 == 0;
  }
}
