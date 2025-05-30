import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/number_validator_error.dart';

void main() {
  group('Number Validator Tests', () {
    test('FormControl invalid if not a number', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = 'hello';

      expect(control.valid, false);
      expect(control.hasError(ValidationMessage.number), true);
    });

    test('FormControl invalid if value is null', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      expect(control.valid, false);
      expect(control.hasError(ValidationMessage.number), true);
      expect(control.errors, {
        ValidationMessage.number: NumberValidatorError.nullValue,
      });
    });

    test('FormControl valid if value is null and null values is allowed', () {
      final control = FormControl<String>(
        validators: [Validators.number(allowNull: true)],
      );

      expect(control.valid, true);
      expect(control.hasError(ValidationMessage.number), false);
    });

    test('FormControl valid if a number', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '10';

      expect(control.valid, true);
    });

    test('FormControl negative number', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '-10';

      expect(control.valid, true);
    });

    test('FormControl decimal numbers', () {
      final control = FormControl<String>(
        validators: [Validators.number(allowedDecimals: 3)],
      );

      control.value = '10.123';

      expect(control.valid, true);
    });

    test('FormControl invalid decimal number with default allowedDecimals', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '10.123';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidDecimals,
      );
    });

    test('FormControl invalid decimal numbers', () {
      final control = FormControl<String>(
        validators: [Validators.number(allowedDecimals: 2)],
      );

      control.value = '10.123';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidDecimals,
      );
    });
  });
}
