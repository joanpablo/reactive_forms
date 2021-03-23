import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'pattern/mock_pattern.dart';

void main() {
  group('Pattern Validator Tests', () {
    test('FormControl invalid if value not matched pattern', () {
      const americanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl<String>(
        validators: [Validators.pattern(americanExpressPattern)],
      );

      cardNumber.value = '395465465421'; // not a valid number

      expect(cardNumber.valid, false);
      expect(cardNumber.hasError(ValidationMessage.pattern), true);
    });

    test('FormControl valid if value matched pattern', () {
      const americanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl<String>(
        validators: [Validators.pattern(americanExpressPattern)],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true);
      expect(cardNumber.errors.keys.isEmpty, true);
    });

    test("Passing a Regex to Pattern validator", () {
      const americanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl<String>(
        validators: [Validators.pattern(RegExp(americanExpressPattern))],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true);
      expect(cardNumber.errors.keys.isEmpty, true);
    });

    test("Passing a MockPattern to Pattern validator", () {
      const americanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl<String>(
        validators: [
          Validators.pattern(MockPattern(RegExp(americanExpressPattern)))
        ],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true, reason: "card number is not valid");
      expect(cardNumber.errors.keys.isEmpty, true, reason: "has errors");
    });
  });
}
