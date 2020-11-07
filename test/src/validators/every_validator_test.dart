import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Every Validator tests', () {
    test('Every control with not empty controls (valid)', () {
      final array = FormArray<String>([
        FormControl<String>(value: 'not'),
        FormControl<String>(value: 'empty'),
        FormControl<String>(value: 'array'),
      ], validators: [
        Validators.every((String value) => value.isNotEmpty)
      ]);

      // Expect: control invalid
      expect(array.valid, true);
      expect(array.hasError(ValidationMessage.every), false);
    });

    test('Every control with empty controls (invalid)', () {
      final array = FormArray<String>([
        FormControl<String>(value: 'not'),
        FormControl<String>(value: 'empty'),
        FormControl<String>(value: ''),
      ], validators: [
        Validators.every((String value) => value.isNotEmpty)
      ]);

      // Expect: array invalid
      expect(array.invalid, true);
      expect(array.hasError(ValidationMessage.every), true);
    });
  });
}
