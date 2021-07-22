import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Number Validator Tests', () {
    test('FormControl invalid if not a number', () {
      final control = FormControl<String>(validators: [Validators.number]);

      control.value = 'hello';

      expect(control.valid, false);
      expect(control.hasError(ValidationMessage.number), true);
    });

    test('FormControl valid if a number', () {
      final control = FormControl<String>(validators: [Validators.number]);

      control.value = '10';

      expect(control.valid, true);
    });
  });
}
