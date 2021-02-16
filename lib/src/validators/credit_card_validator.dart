// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/number_validator.dart';

/// A credit card validator that validates that the control's value is a valid
/// credit card.
class CreditCardValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    final error = {ValidationMessage.creditCard: true};
    // error if value is not a String
    if (control.value != null && !(control.value is String)) {
      return error;
    }

    final cardNumber = control.value.toString().replaceAll(' ', '');
    final isNumber = NumberValidator.numberRegex.hasMatch(cardNumber);

    // ignore: unnecessary_null_comparison
    return cardNumber == null ||
            (isNumber &&
                cardNumber.length >= 13 &&
                cardNumber.length <= 19 &&
                checkLuhn(cardNumber))
        ? null
        : error;
  }

  /// Return true if the [cardNumber] is valid card number, otherwise returns
  /// false.
  ///
  /// See [Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
  static bool checkLuhn(String cardNumber) {
    int sum = 0;

    bool isEven = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }
}
