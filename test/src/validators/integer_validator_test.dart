import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Integer Validator Tests', () {
    test('FormControl invalid if not a integer string', () {
      final control = FormControl<String>(validators: [Validators.integer]);

      control.value = 'hello';

      expect(control.valid, false);
      expect(control.hasError(ValidationMessage.integer), true);
    });

    test('FormControl invalid if not a integer integer', () {
      final control = FormControl<String>(validators: [Validators.integer]);

      control.value = 10.2.toString();

      expect(control.valid, false);
      expect(control.hasError(ValidationMessage.integer), true);
    });

    test('FormControl valid if a integer integer', () {
      final control = FormControl<String>(validators: [Validators.integer]);

      control.value = '10';

      expect(control.valid, true);
    });
  });
}
