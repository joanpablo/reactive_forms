import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Required Validator Tests', () {
    test('FormControl is invalid if value is null', () {
      // Given: a control with null value
      final control = FormControl<String>(
        validators: [Validators.required],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl is invalid if value is empty string', () {
      // Given: a control with empty string value
      final control = FormControl<String>(
        value: '',
        validators: [Validators.required],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl is invalid if value is whitespace string', () {
      // Given: a control with whitespace-only string value
      final control = FormControl<String>(
        value: '   ',
        validators: [Validators.required],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl is valid if value is non-empty string', () {
      // Given: a control with a non-empty string value
      final control = FormControl<String>(
        value: 'Hello',
        validators: [Validators.required],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl is invalid if value is empty Map', () {
      // Given: a control with an empty map
      final control = FormControl<Map<String, dynamic>>(
        value: {},
        validators: [Validators.required],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl is valid if value is non-empty Map', () {
      // Given: a control with a non-empty map
      final control = FormControl<Map<String, dynamic>>(
        value: {'key': 'value'},
        validators: [Validators.required],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl is invalid if value is empty List', () {
      // Given: a control with an empty list
      final control = FormControl<List<String>>(
        value: [],
        validators: [Validators.required],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl is valid if value is non-empty List', () {
      // Given: a control with a non-empty list
      final control = FormControl<List<String>>(
        value: ['item'],
        validators: [Validators.required],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl is invalid if value is empty Set', () {
      // Given: a control with an empty set
      final control = FormControl<Set<String>>(
        value: <String>{},
        validators: [Validators.required],
      );

      // Expect: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl is valid if value is non-empty Set', () {
      // Given: a control with a non-empty set
      final control = FormControl<Set<String>>(
        value: {'item'},
        validators: [Validators.required],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl is valid if value is a non-collection type', () {
      // Given: a control with an integer value
      final control = FormControl<int>(
        value: 42,
        validators: [Validators.required],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl becomes invalid when value changes to null', () {
      // Given: a valid control
      final control = FormControl<String>(
        value: 'Hello',
        validators: [Validators.required],
      );

      // When: value is set to null
      control.value = null;

      // Then: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl becomes valid when value changes from null', () {
      // Given: an invalid control
      final control = FormControl<String>(
        validators: [Validators.required],
      );

      // When: value is set
      control.value = 'Hello';

      // Then: control is valid
      expect(control.valid, true);
    });

    test('FormControl becomes invalid when List value changes to empty', () {
      // Given: a valid control with a non-empty list
      final control = FormControl<List<String>>(
        value: ['item'],
        validators: [Validators.required],
      );

      // When: value is set to empty list
      control.value = [];

      // Then: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('FormControl becomes invalid when Map value changes to empty', () {
      // Given: a valid control with a non-empty map
      final control = FormControl<Map<String, dynamic>>(
        value: {'key': 'value'},
        validators: [Validators.required],
      );

      // When: value is set to empty map
      control.value = {};

      // Then: control is invalid
      expect(control.invalid, true);
      expect(control.hasError(ValidationMessage.required), true);
    });
  });
}
