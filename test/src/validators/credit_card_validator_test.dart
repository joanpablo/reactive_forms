import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Credit Card Validator Tests', () {
    test('Test card number with empty white spaces is valid', () {
      // Given: a credit card number
      final control = FormControl<String>(
        value: '5500 0000 0000 0004',
        validators: [Validators.creditCard],
      );

      // Expect: number is valid
      expect(control.valid, true);
    });

    test('Validates a valid credit card number', () {
      // Given: a credit card number
      final control = FormControl<String>(
        value: '5555555555554444',
        validators: [Validators.creditCard],
      );

      // Expect: number is valid
      expect(control.valid, true);
    });

    test('Validates an invalid credit card number', () {
      // Given: a credit card number
      final control = FormControl<String>(
        value: '7992739871',
        validators: [Validators.creditCard],
      );

      // Expect: number is not valid
      expect(control.valid, false);
    });

    test('Validates invalid number string', () {
      // Given: an invalid credit card number
      final control = FormControl<String>(
        value: '5500abc000000004',
        validators: [Validators.creditCard],
      );

      // Expect: number is not valid
      expect(control.valid, false);
    });

    test('Validates that card number must not bee empty', () {
      // Given: an invalid credit card number
      final control = FormControl<String>(
        value: '',
        validators: [Validators.creditCard],
      );

      // Expect: number is not valid
      expect(control.valid, false);
    });

    test('Validates a card number with length lower than 13 is invalid', () {
      // Given: an invalid credit card number
      final control = FormControl<String>(
        value: '123456789123',
        validators: [Validators.creditCard],
      );

      // Expect: number is not valid
      expect(control.valid, false);
    });

    test('Validates a card number exceed 19 numbers is invalid', () {
      // Given: an invalid credit card number
      final control = FormControl<String>(
        value: '12345678912345678909',
        validators: [Validators.creditCard],
      );

      // Expect: number is not valid
      expect(control.valid, false);
    });

    test('Test some valid credit cards', () {
      // Given: an invalid credit card number
      final cardNumbers = [
        '4111 1111 1111 1111',
        '5500 0000 0000 0004',
        '3400 0000 0000 009',
        '3000 0000 0000 04',
        '6011 0000 0000 0004',
        '2014 0000 0000 009',
        '3088 0000 0000 0009',
      ];

      final control = FormControl<String>(
        validators: [Validators.creditCard],
      );

      cardNumbers.forEach((cardNumber) {
        control.value = cardNumber;
        expect(control.valid, true, reason: '[$cardNumber] is not valid');
      });
    });
  });
}
