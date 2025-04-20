import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Max validator tests', () {
    test('FormControl with lower value is valid', () {
      // Given: a valid control
      final control = FormControl<int>(
        value: 10,
        validators: [Validators.max(20)],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl with equals value is valid', () {
      // Given: an invalid control
      final control = FormControl<int>(
        value: 20,
        validators: [Validators.max(20)],
      );

      // Expect: control is invalid
      expect(control.valid, true);
    });

    test('FormControl with a grater than value is invalid', () {
      // Given: an invalid control
      final control = FormControl<int>(
        value: 30,
        validators: [Validators.max(20)],
      );

      // Expect: control is invalid
      expect(control.valid, false);
    });

    test('FormControl with lower value is valid', () {
      // Given: a valid control
      final control = FormControl<int>(validators: [Validators.max(20)]);

      // Expect: control is valid
      expect(control.valid, false);
    });
  });
}
