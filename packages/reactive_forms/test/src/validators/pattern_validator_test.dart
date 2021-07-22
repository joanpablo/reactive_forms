import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

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

    test('Passing a Regex to Pattern validator', () {
      const americanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl<String>(
        validators: [Validators.pattern(RegExp(americanExpressPattern))],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true);
      expect(cardNumber.errors.keys.isEmpty, true);
    });

    test('Passing a MockPattern to Pattern validator', () {
      const americanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl<String>(
        validators: [
          Validators.pattern(MockPattern(RegExp(americanExpressPattern)))
        ],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true, reason: 'card number is not valid');
      expect(cardNumber.errors.keys.isEmpty, true, reason: 'has errors');
    });

    test('Customize Validation Message', () {
      // Give: some regular expressions
      const containsLettersPattern = r'[a-z]+';
      const containsNumbersPattern = r'\d+';

      const containsLettersValidationMessage = 'containsLetters';
      const containsNumbersValidationMessage = 'containsNumbers';

      // And: a control with pattern validators
      final password = FormControl<String>(
        value: '123abc',
        validators: [
          Validators.pattern(
            containsLettersPattern,
            validationMessage: containsLettersValidationMessage,
          ),
          Validators.pattern(
            containsNumbersPattern,
            validationMessage: containsNumbersValidationMessage,
          ),
        ],
      );

      // When: set an invalid value
      password.value = '_';

      // Then: password contains all pattern errors
      expect(password.valid, false, reason: 'password is valid');
      expect(password.hasError(containsLettersValidationMessage), true,
          reason:
              'password does not contains the containsLettersValidationMessage error');
      expect(password.hasError(containsNumbersValidationMessage), true,
          reason:
              'password does not contains the containsNumbersValidationMessage error');
    });

    test('Customize Validation Message with one valid pattern', () {
      // Give: some regular expressions
      const containsLettersPattern = r'[a-z]+';
      const containsNumbersPattern = r'\d+';

      const containsLettersValidationMessage = 'containsLetters';
      const containsNumbersValidationMessage = 'containsNumbers';

      // And: a control with pattern validators
      final password = FormControl<String>(
        validators: [
          Validators.pattern(
            containsLettersPattern,
            validationMessage: containsLettersValidationMessage,
          ),
          Validators.pattern(
            containsNumbersPattern,
            validationMessage: containsNumbersValidationMessage,
          ),
        ],
      );

      // When: set an invalid value
      password.value = '123';

      // Then: password contains all pattern errors
      expect(password.valid, false, reason: 'password is valid');
      expect(password.hasError(containsLettersValidationMessage), true,
          reason:
              'password does not contains the containsLettersValidationMessage error');
      expect(password.hasError(containsNumbersValidationMessage), false,
          reason:
              'password contains the containsNumbersValidationMessage error');
    });

    test('Customize Validation Message with all valid pattern', () {
      // Give: some regular expressions
      const containsLettersPattern = r'[a-z]+';
      const containsNumbersPattern = r'\d+';

      const containsLettersValidationMessage = 'containsLetters';
      const containsNumbersValidationMessage = 'containsNumbers';

      // And: a control with pattern validators
      final password = FormControl<String>(
        validators: [
          Validators.pattern(
            containsLettersPattern,
            validationMessage: containsLettersValidationMessage,
          ),
          Validators.pattern(
            containsNumbersPattern,
            validationMessage: containsNumbersValidationMessage,
          ),
        ],
      );

      // When: set a valid value
      password.value = '123abc';

      // Then: password is valid without errors
      expect(password.valid, true, reason: 'password is valid');
      expect(password.hasError(containsLettersValidationMessage), false,
          reason:
              'password contains the containsLettersValidationMessage error');
      expect(password.hasError(containsNumbersValidationMessage), false,
          reason:
              'password contains the containsNumbersValidationMessage error');
    });
  });
}
