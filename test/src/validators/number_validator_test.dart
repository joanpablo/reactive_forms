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

    test('FormControl of type String valid decimal numbers with .00', () {
      final control = FormControl<String>(
        validators: [Validators.number(allowedDecimals: 2)],
      );

      control.value = '10.00';

      expect(control.valid, true);
      expect(control.errors.isEmpty, true);
    });

    test('FormControl of type double valid decimal numbers with .00', () {
      final control = FormControl<double>(
        validators: [Validators.number(allowedDecimals: 2)],
      );

      control.value = 10.00;

      expect(control.valid, true);
      expect(control.errors.isEmpty, true);
    });

    test(
      'FormControl invalid negative number when allowNegatives is false',
      () {
        final control = FormControl<String>(
          validators: [Validators.number(allowNegatives: false)],
        );

        control.value = '-10';

        expect(control.valid, false);
        expect(
          control.errors[ValidationMessage.number],
          NumberValidatorError.unsignedNumber,
        );
      },
    );

    test('FormControl invalid with multiple decimal points', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '10.1.0';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidDecimals,
      );
    });

    test('FormControl valid with leading/trailing spaces', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = ' 10 ';

      expect(control.valid, true);
    });

    test('FormControl invalid with invalid characters', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '10a.5';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidDecimals,
      );
    });

    test('FormControl invalid with only spaces', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '   ';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidNumber,
      );
    });

    test('FormControl invalid with a single dot', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '.';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidDecimals,
      );
    });

    test('FormControl invalid with a dot at the end', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '10.';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidDecimals,
      );
    });

    test('FormControl invalid with invalid characters and no decimal point', () {
      final control = FormControl<String>(validators: [Validators.number()]);

      control.value = '1a0';

      expect(control.valid, false);
      expect(
        control.errors[ValidationMessage.number],
        NumberValidatorError.invalidNumber,
      );
    });

    test('FormControl valid with a dot at the beginning', () {
      final control = FormControl<String>(
        validators: [Validators.number(allowedDecimals: 1)],
      );

      control.value = '.5';

      expect(control.valid, true);
    });
  });
}
