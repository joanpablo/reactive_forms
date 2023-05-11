import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Required Non Empty validator tests', () {
    test('FormControl is invalid if value is null', () {
      // Given: an invalid control
      final control = FormControl<dynamic>(
        value: null,
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {ValidationMessage.requiredNonEmpty: true});
    });

    test('FormControl is valid if value is not null', () {
      // Given: a valid control
      final control = FormControl<num>(
        value: 42,
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });

    test('FormControl is invalid if value is an emtpy list', () {
      // Given: a valid control
      final control = FormControl<List<dynamic>>(
        value: <dynamic>[],
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {ValidationMessage.requiredNonEmpty: true});
    });

    test('FormControl is valid if value is non emtpy list', () {
      // Given: a valid control
      final control = FormControl<List<dynamic>>(
        value: <dynamic>[1],
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });
  });
}
