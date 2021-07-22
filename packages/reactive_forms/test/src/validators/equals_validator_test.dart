import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Equals validator tests', () {
    test('FormControl is valid if value equals to validator value', () {
      // Given: an invalid control
      final control = FormControl<double>(
        value: 0.0,
        validators: [Validators.equals(20.0)],
      );

      // Expect: control is invalid
      expect(control.valid, false, reason: 'init state of control is valid');

      // When: change the value to true
      control.value = 20.0;

      // Then: control is valid
      expect(control.valid, true, reason: 'last state of control is invalid');
    });
  });
}
