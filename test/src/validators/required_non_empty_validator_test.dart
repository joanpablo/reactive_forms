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

    test('FormControl is invalid if string value is null', () {
      // Given: an invalid control
      final control = FormControl<String>(
        value: null,
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {ValidationMessage.requiredNonEmpty: true});
    });

    test('FormControl is invalid if string value is empty', () {
      // Given: an invalid control
      final control = FormControl<String>(
        value: " ",
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {ValidationMessage.requiredNonEmpty: true});
    });

    test('FormControl is valid if string value is not null', () {
      // Given: a valid control
      final control = FormControl<String>(
        value: "42",
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

    test('FormControl is invalid if value is an emtpy map', () {
      // Given: a valid control
      final control = FormControl<Map<String, dynamic>>(
        value: <String, dynamic>{},
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is invalid
      expect(control.valid, false);
      expect(control.errors, {ValidationMessage.requiredNonEmpty: true});
    });

    test('FormControl is valid if value is non emtpy map', () {
      // Given: a valid control
      final control = FormControl<Map<String, dynamic>>(
        value: <String, dynamic>{"answer": 42},
        validators: [Validators.requiredNonEmpty],
      );

      // Expect: control is valid
      expect(control.valid, true);
    });
  });
}
