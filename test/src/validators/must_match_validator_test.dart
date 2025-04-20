import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('MustMatch Validator Tests', () {
    test('FormGroup invalid if passwords mismatch', () {
      final form = FormGroup(
        {
          'password': FormControl<String>(value: '1234'),
          'passwordConfirmation': FormControl<String>(value: '123'),
        },
        validators: [Validators.mustMatch('password', 'passwordConfirmation')],
      );

      expect(form.invalid, true);
      expect(
        form.hasError(ValidationMessage.mustMatch, 'passwordConfirmation'),
        true,
      );
    });

    test('FormGroup valid if passwords match', () {
      final form = FormGroup(
        {
          'password': FormControl<String>(value: '1234'),
          'passwordConfirmation': FormControl<String>(value: '123'),
        },
        validators: [Validators.mustMatch('password', 'passwordConfirmation')],
      );

      final passwordConfirmation = form.control('passwordConfirmation');
      passwordConfirmation.value = '1234';

      expect(form.valid, true);
      expect(form.hasErrors, false);
    });

    test('Must Match validator does not marks child as dirty', () {
      // Given: a form definition
      final form = FormGroup(
        {
          'password': FormControl<String>(),
          'passwordConfirmation': FormControl<String>(),
        },
        validators: [
          Validators.mustMatch(
            'password',
            'passwordConfirmation',
            markAsDirty: false,
          ),
        ],
      );

      // When: set a value to the password control
      final passwordConfirmation = form.control('passwordConfirmation');
      passwordConfirmation.value = '1234';

      // Then: passwordConfirmation control is not dirty
      expect(
        form.control('passwordConfirmation').dirty,
        false,
        reason: 'passwordConfirmation is dirty',
      );
    });

    test('Must Match validator marks child as dirty by default', () {
      // Given: a form definition
      final form = FormGroup(
        {
          'password': FormControl<String>(),
          'passwordConfirmation': FormControl<String>(),
        },
        validators: [Validators.mustMatch('password', 'passwordConfirmation')],
      );

      // When: set a value to the password control
      final passwordConfirmation = form.control('passwordConfirmation');
      passwordConfirmation.value = '1234';

      // Then: passwordConfirmation control is dirty
      expect(
        form.control('passwordConfirmation').dirty,
        true,
        reason: 'passwordConfirmation is not dirty',
      );
    });
  });
}
