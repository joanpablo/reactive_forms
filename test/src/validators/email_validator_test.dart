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
}
