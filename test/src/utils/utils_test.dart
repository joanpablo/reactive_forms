import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Utils tests', () {
    test('Test control is null', () {
      // Given: a control
      final control = FormControl();

      // Expect: value is null
      expect(control.isNull, true);
    });

    test('Test string control is null or empty whites paces', () {
      // Given: a control with null value
      final control = FormControl<String>();

      // Expect: value is null
      expect(control.isNullOrEmpty, true);
    });

    test('Test string control is empty', () {
      // Given: a control with null value
      final control = FormControl<String>(defaultValue: '');

      // Expect: value is null
      expect(control.isNullOrEmpty, true);
    });

    test('Test string control is empty white spaces', () {
      // Given: a control with null value
      final control = FormControl<String>(defaultValue: ' ');

      // Expect: value is null
      expect(control.isNullOrEmpty, true);
    });
  });
}
