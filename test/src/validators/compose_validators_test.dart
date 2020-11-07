import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/compose_validator.dart';

void main() {
  group('Composing Validator Tests', () {
    test(
      'If none validators validate to VALID then the control is INVALID',
      () {
        // Given: a control that is email and min length in 20
        final control = FormControl<String>(
          value: 'john@',
          validators: [
            Validators.compose([
              Validators.email,
              Validators.minLength(20),
            ])
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
            Validators.compose([
              Validators.email,
              Validators.minLength(20),
            ])
          ],
        );

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'If at least on validator is valid then control is VALID',
      () {
        // Given: a control that is email and min length in 20
        final control = FormControl<String>(
          value: 'johndoe@email.com',
          validators: [
            Validators.composeOR([
              Validators.email,
              Validators.minLength(20),
            ])
          ],
        );

        // Expect: control invalid
        expect(control.valid, true);
      },
    );

    test(
      'If at least on validator is valid then control is VALID',
      () {
        // Given: a control that is email and min length in 20
        final control = FormControl<String>(
          value: 'johndoeemailemail.com',
          validators: [
            Validators.composeOR([
              Validators.email,
              Validators.minLength(20),
            ])
          ],
        );

        // Expect: control invalid
        expect(control.valid, true);
      },
    );

    test(
      'If at least on validator is valid then control is VALID',
      () {
        // Given: a control that is email and min length in 20
        final control = FormControl<String>(
          value: 'johndoe.com',
          validators: [
            Validators.composeOR([
              Validators.email,
              Validators.minLength(20),
            ])
          ],
        );

        // Expect: control invalid
        expect(control.valid, false);
      },
    );

    test(
      'assert error if null validators',
      () {
        expect(() => ComposeValidator(null), throwsAssertionError);
      },
    );
  });
}
