import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Email Validator Tests', () {
    test('FormControl valid with null email', () {
      final control = FormControl(validators: [Validators.email]);

      expect(control.valid, true);
    });

    test('FormControl invalid with invalid email', () {
      final control = FormControl(validators: [Validators.email]);

      control.value = 'johndoe@email';

      expect(control.invalid, true);
    });

    test('FormControl valid with valid email', () {
      final control = FormControl(validators: [Validators.email]);

      control.value = 'johndoe@email.com';

      expect(control.valid, true);
    });

    test('FormControl invalid with not String email', () {
      final control = FormControl(validators: [Validators.email]);

      control.value = 123;

      expect(control.invalid, true);
    });
  });

  group('MinLength Validator Tests', () {
    test('FormControl invalid if minLength invalid', () {
      final control = FormControl(
        defaultValue: 'Hello',
        validators: [Validators.minLength(6)],
      );

      expect(control.invalid, true);
      expect(control.errors[ValidationMessage.minLength] != null, true);
    });
  });

  group('MaxLength Validator Tests', () {
    test('FormControl invalid if maxLength invalid', () {
      final control = FormControl(
        defaultValue: 'Hello Reactive Forms',
        validators: [Validators.maxLength(10)],
      );

      expect(control.invalid, true);
      expect(control.errors[ValidationMessage.maxLength] != null, true);
    });
  });

  group('MustMatch Validator Tests', () {
    test('FormGroup invalid if passwords mismatch', () {
      final form = FormGroup({
        'password': FormControl(defaultValue: '1234'),
        'passwordConfirmation': FormControl(defaultValue: '123'),
      }, validators: [
        Validators.mustMatch('password', 'passwordConfirmation'),
      ]);

      expect(form.invalid, true);
      expect(
        form.errors['passwordConfirmation'][ValidationMessage.mustMatch],
        true,
      );
    });

    test('FormGroup valid if passwords match', () {
      final form = FormGroup({
        'password': FormControl(defaultValue: '1234'),
        'passwordConfirmation': FormControl(defaultValue: '123'),
      }, validators: [
        Validators.mustMatch('password', 'passwordConfirmation'),
      ]);

      final passwordConfirmation = form.formControl('passwordConfirmation');
      passwordConfirmation.value = '1234';

      expect(form.valid, true);
      expect(form.hasErrors, false);
    });
  });

  group('Pattern Validator Tests', () {
    test('FormControl invalid if value not matched pattern', () {
      const AmericanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl(
        validators: [Validators.pattern(AmericanExpressPattern)],
      );

      cardNumber.value = '395465465421'; // not a valid number

      expect(cardNumber.valid, false);
      expect(cardNumber.errors.containsKey(ValidationMessage.pattern), true);
    });

    test('FormControl valid if value matched pattern', () {
      const AmericanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl(
        validators: [Validators.pattern(AmericanExpressPattern)],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true);
      expect(cardNumber.errors.keys.isEmpty, true);
    });
  });

  group('Number Validator Tests', () {
    test('FormControl invalid if not a number', () {
      final control = FormControl<String>(validators: [Validators.number]);

      control.value = 'hello';

      expect(control.valid, false);
      expect(control.errors.containsKey(ValidationMessage.number), true);
    });

    test('FormControl valid if a number', () {
      final control = FormControl<String>(validators: [Validators.number]);

      control.value = '10';

      expect(control.valid, true);
    });
  });
}
