import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Composing Validator Tests', () {
    test(
      'If none validators validate to VALID then the control is INVALID',
      () {
        // Given: a control that is email and min length in 20
        final control = FormControl<String>(
          value: 'john@',
          validators: [
            Validators.compose([Validators.email, Validators.minLength(20)]),
          ],
        );

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'If none validators validate to VALID then the control is INVALID',
      () {
        // Given: a control that is email and min length in 20
        // but with valid email default value
        final control = FormControl<String>(
          value: 'john@email.com',
          validators: [
            Validators.compose([Validators.email, Validators.minLength(20)]),
          ],
        );

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test('If at least on validator is valid then control is VALID', () {
      // Given: a control that is email and min length in 20
      final control = FormControl<String>(
        value: 'johndoe@email.com',
        validators: [
          Validators.composeOR([Validators.email, Validators.minLength(20)]),
        ],
      );

      // Expect: control invalid
      expect(control.valid, true);
    });

    test('If at least on validator is valid then control is VALID', () {
      // Given: a control that is email and min length in 20
      final control = FormControl<String>(
        value: 'johndoeemailemail.com',
        validators: [
          Validators.composeOR([Validators.email, Validators.minLength(20)]),
        ],
      );

      // Expect: control invalid
      expect(control.valid, true);
    });

    test('If at least on validator is valid then control is VALID', () {
      // Given: a control that is email and min length in 20
      final control = FormControl<String>(
        value: 'johndoe.com',
        validators: [
          Validators.composeOR([Validators.email, Validators.minLength(20)]),
        ],
      );

      // Expect: control invalid
      expect(control.valid, false);
    });

    test('Validates with a control that can be an empty string', () {
      // Given: a control
      final control = FormControl<String>(
        value: '1234567890',
        validators: [
          Validators.composeOR([
            Validators.composeOR([
              Validators.equals(''),
              Validators.equals(null),
            ]),
            Validators.compose([
              Validators.minLength(10),
              Validators.maxLength(10),
              Validators.number(),
            ]),
          ]),
        ],
      );

      // Expect: control is valid
      expect(control.valid, true);

      // When: set value to empty string
      control.value = '';
      // Expect: control is valid
      expect(control.valid, true);

      // When: set value with length < 10
      control.value = '12345678';
      // Then: control is invalid
      expect(control.valid, false);

      // When: set value with length > 10
      control.value = '12345678901';
      // Expect: control is invalid
      expect(control.valid, false);

      // When: set value to null
      control.value = null;
      // Expect: control is invalid
      expect(control.valid, true);
    });
  });
}
