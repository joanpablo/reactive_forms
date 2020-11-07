import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('AtLeastOne Validator tests', () {
    test('At least one control in array has not empty value (valid)', () {
      // Given: an array of String with one not empty control and a validator
      final array = FormArray<String>([
        FormControl<String>(value: ''),
        FormControl<String>(value: ''),
        FormControl<String>(value: 'not empty'),
      ], validators: [
        Validators.any((String value) => value?.isNotEmpty)
      ]);

      // Expect: array is valid
      expect(array.valid, true);
    });

    test('At least one control in array has not empty value (invalid)', () {
      // Given: an array of String with empty controls and a validator
      final array = FormArray<String>([
        FormControl<String>(value: ''),
        FormControl<String>(value: ''),
        FormControl<String>(value: ''),
      ], validators: [
        Validators.any((String value) => value?.isNotEmpty)
      ]);

      // Expect: array is invalid and has
      expect(array.invalid, true);
      expect(array.hasError(ValidationMessage.any), true);
    });

    test(
        'At least one control in array has not empty value and controls with null values (valid)',
        () {
      final array = FormArray<String>([
        // Given: an array of String with one not empty control and a validator
        FormControl<String>(value: null),
        FormControl<String>(value: ''),
        FormControl<String>(value: 'not empty'),
      ], validators: [
        Validators.any((String value) => value?.isNotEmpty)
      ]);

      // Expect: array is valid
      expect(array.valid, true);
    });

    test(
        'At least one control in array has not empty value and controls with null values (invalid)',
        () {
      final array = FormArray<String>([
        // Given: an array with empty and null values and the validator
        FormControl<String>(value: null),
        FormControl<String>(value: ''),
        FormControl<String>(value: null),
      ], validators: [
        Validators.any((String value) => value?.isNotEmpty)
      ]);

      // Expect: array is invalid and has
      expect(array.invalid, true);
      expect(array.hasError(ValidationMessage.any), true);
    });
  });
}
