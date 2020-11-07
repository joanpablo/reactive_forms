import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Any Validator tests', () {
    test('Any control in array with not empty value (valid)', () {
      final array = FormArray<String>([
        FormControl<String>(value: 'not empty'),
        FormControl<String>(value: ''),
        FormControl<String>(value: ''),
      ], validators: [
        Validators.any((String value) => value.isNotEmpty)
      ]);

      // Expect: control invalid
      expect(array.valid, true);
      expect(array.hasError(ValidationMessage.any), false);
    });

    test('Any control in array with not empty value (invalid)', () {
      final array = FormArray<String>([
        FormControl<String>(value: ''),
        FormControl<String>(value: ''),
        FormControl<String>(value: ''),
      ], validators: [
        Validators.any((String value) => value.isNotEmpty)
      ]);

      // Expect: array invalid
      expect(array.invalid, true);
      expect(array.hasError(ValidationMessage.any), true);
    });
  });
}
