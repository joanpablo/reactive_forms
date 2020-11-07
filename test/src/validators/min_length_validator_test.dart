import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('MinLength Validator Tests', () {
    test('FormControl invalid if minLength invalid', () {
      // Given: a invalid control
      final control = FormControl(
        value: 'Hello',
        validators: [Validators.minLength(6)],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.minLength), true);
    });

    test('FormControl valid if minLength valid', () {
      // Given: a valid control
      final control = FormControl(
        value: 'Reactive Forms',
        validators: [Validators.minLength(6)],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormGroup valid if minLength valid', () {
      // Given: a valid control
      final form = FormGroup({
        'name': FormControl(
          value: 'Reactive Forms',
          validators: [Validators.minLength(6)],
        ),
      });

      // Expect: control is valid
      expect(form.valid, true);
    });

    test('FormGroup valid if control value is null', () {
      // Given: a valid control
      final form = FormGroup({
        'name': FormControl(
          validators: [Validators.minLength(6)],
        ),
      });

      // Expect: control is valid
      expect(form.valid, true);
    });

    test('FormGroup invalid if minLength invalid', () {
      // Given: an invalid control
      final form = FormGroup({
        'name': FormControl(
          value: 'Forms',
          validators: [Validators.minLength(6)],
        ),
      });

      // Expect: control is invalid
      expect(form.valid, false);
    });

    test('FormArray invalid if minLength invalid', () {
      // Given: an invalid array
      final array = FormArray([
        FormControl(),
        FormControl(),
      ], validators: [
        Validators.minLength(3)
      ]);

      // Expect: array is invalid
      expect(array.invalid, true);
      expect(array.hasError(ValidationMessage.minLength), true);
    });

    test('FormArray valid if minLength valid', () {
      // Given: a valid array
      final array = FormArray([
        FormControl(),
        FormControl(),
        FormControl(),
      ], validators: [
        Validators.minLength(3)
      ]);

      // Expect: array is valid
      expect(array.valid, true);
    });

    test('FormGroup valid if minLength valid', () {
      // Given: a valid group
      final array = FormGroup({
        'name': FormControl(),
        'email': FormControl(),
      }, validators: [
        Validators.minLength(2)
      ]);

      // Expect: group is valid
      expect(array.valid, true);
    });

    test('FormGroup invalid if minLength invalid', () {
      // Given: an invalid group
      final array = FormGroup({
        'name': FormControl(),
      }, validators: [
        Validators.minLength(2)
      ]);

      // Expect: group is invalid
      expect(array.valid, false);
    });
  });
}
