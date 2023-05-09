import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Required validator tests', () {
    test('FormControl is invalid if value is null', () {
      final control = FormControl<String>(
        value: null,
        validators: [Validators.required],
      );

      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.required: true,
      });
    });

    test('FormControl is invalid if value is empty string', () {
      final control = FormControl<String>(
        value: '',
        validators: [Validators.required],
      );

      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.required: true,
      });
    });

    test('FormControl is valid if value is non empty string', () {
      final control = FormControl<String>(
        value: 'non empty string',
        validators: [Validators.required],
      );

      expect(control.valid, true);
      expect(control.errors, <String, dynamic>{});
    });

    test('FormControl is invalid if value is empty list', () {
      final control = FormControl<List<String>>(
        value: [],
        validators: [Validators.required],
      );

      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.required: true,
      });
    });

    test('FormControl is valid if value is non empty list', () {
      final control = FormControl<List<String>>(
        value: ['non empty string'],
        validators: [Validators.required],
      );

      expect(control.valid, true);
      expect(control.errors, <String, dynamic>{});
    });

    test('FormControl is invalid if value is empty map', () {
      final control = FormControl<Map<String, dynamic>>(
        value: <String, dynamic>{},
        validators: [Validators.required],
      );

      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.required: true,
      });
    });

    test('FormControl is valid if value is non empty map', () {
      final control = FormControl<Map<String, String>>(
        value: {'key': 'value'},
        validators: [Validators.required],
      );

      expect(control.valid, true);
      expect(control.errors, <String, dynamic>{});
    });

    test('FormControl is invalid if value is empty set', () {
      final control = FormControl<Set<String>>(
        value: <String>{},
        validators: [Validators.required],
      );

      expect(control.valid, false);
      expect(control.errors, {
        ValidationMessage.required: true,
      });
    });

    test('FormControl is valid if value is non empty set', () {
      final control = FormControl<Set<String>>(
        value: {'value'},
        validators: [Validators.required],
      );

      expect(control.valid, true);
      expect(control.errors, <String, dynamic>{});
    });
  });
}
