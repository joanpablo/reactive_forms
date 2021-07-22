import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

void main() {
  group('MaxLength Validator Tests', () {
    test('FormControl invalid if maxLength invalid', () {
      final control = FormControl(
        value: 'Hello Reactive Forms',
        validators: [Validators.maxLength(10)],
      );

      expect(control.invalid, true);
      expect(control.errors[ValidationMessage.maxLength] != null, true);
    });

    test('FormControl valid if maxLength is valid', () {
      // Given: a valid control
      final control = FormControl(
        value: 'Reactive',
        validators: [Validators.maxLength(10)],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormGroup invalid if maxLength invalid', () {
      final form = FormGroup({
        'name': FormControl<String>(
          value: 'Hello Reactive Forms',
          validators: [Validators.maxLength(10)],
        ),
      });

      expect(form.invalid, true);
      expect(form.hasError(ValidationMessage.maxLength, 'name'), true);
    });

    test('FormGroup is valid if maxLength valid', () {
      final form = FormGroup({
        'name': FormControl<String>(
          value: 'Reactive',
          validators: [Validators.maxLength(10)],
        ),
      });

      expect(form.valid, true);
    });

    test('FormGroup is valid if control value is null', () {
      final form = FormGroup({
        'name': FormControl<String>(
          validators: [Validators.maxLength(10)],
        ),
      });

      expect(form.valid, true);
    });

    test('FormControl of list valid if maxLength is valid', () {
      // Given: a valid control
      final control = FormControl<List<int>>(
        value: [1, 2, 3],
        validators: [Validators.maxLength(3)],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl of list invalid if maxLength is invalid', () {
      // Given: an invalid control
      final control = FormControl<List<int>>(
        value: [1, 2, 3],
        validators: [Validators.maxLength(2)],
      );

      // Expect: control is invalid
      expect(control.valid, false);
    });

    test('FormArray valid if maxLength is valid', () {
      // Given: a valid array
      final array = FormArray<int>([
        FormControl<int>(),
        FormControl<int>(),
        FormControl<int>(),
      ], validators: [
        Validators.maxLength(4)
      ]);

      // Expect: array is valid
      expect(array.valid, true);
    });

    test('FormArray invalid if maxLength is invalid', () {
      // Given: an invalid array
      final array = FormArray<int>([
        FormControl<int>(),
        FormControl<int>(),
        FormControl<int>(),
      ], validators: [
        Validators.maxLength(2)
      ]);

      // Expect: array is valid
      expect(array.valid, false);
    });

    test('FormGroup valid if maxLength is valid', () {
      // Given: a valid group
      final form = FormGroup({
        'name': FormControl<String>(),
        'email': FormControl<String>(),
        'password': FormControl<String>(),
      }, validators: [
        Validators.maxLength(4)
      ]);

      // Expect: group is valid
      expect(form.valid, true);
    });

    test('FormGroup invalid if maxLength is invalid', () {
      // Given: an invalid group
      final form = FormGroup({
        'name': FormControl<String>(),
        'email': FormControl<String>(),
        'password': FormControl<String>(),
      }, validators: [
        Validators.maxLength(2)
      ]);

      // Expect: group is invalid
      expect(form.valid, false);
    });
  });
}
