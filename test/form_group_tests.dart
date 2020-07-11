import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Form Group', () {
    test('FormGroup is valid by default', () {
      final form = FormGroup({});

      expect(form.valid, true);
    });

    test('FormGroup is valid if FormControl is valid', () {
      final form = FormGroup({
        'name': FormControl(),
      });

      expect(form.valid, true);
    });

    test('FormGroup is invalid if FormControl is invalid', () {
      final form = FormGroup({
        'name': FormControl(validators: [Validators.required]),
      });

      expect(form.valid, false);
    });

    test('FormGroup is valid if required FormControl has default value', () {
      final form = FormGroup({
        'name': FormControl(
          defaultValue: 'hello',
          validators: [Validators.required],
        ),
      });

      expect(form.valid, true);
    });

    test('FormGroup is invalid if set invalid value to FormControl', () {
      final form = FormGroup({
        'name': FormControl(
          defaultValue: 'hello',
          validators: [Validators.required],
        ),
      });

      form.formControl('name').value = null;

      expect(form.invalid, true);
    });

    test('FormGroup is valid if set valid value to FormControl', () {
      final form = FormGroup({
        'name': FormControl(
          validators: [Validators.required],
        ),
      });

      form.formControl('name').value = 'hello';

      expect(form.valid, true);
    });

    test('FormGroup is invalid if all FormControl are invalid', () {
      final form = FormGroup({
        'name': FormControl(validators: [Validators.required]),
        'email': FormControl(validators: [Validators.email]),
      });

      expect(form.invalid, true);
    });

    test('FormGroup is invalid if at least one FormControl is invalid', () {
      final form = FormGroup({
        'name': FormControl(
          defaultValue: 'hello',
          validators: [Validators.required],
        ),
        'email': FormControl(validators: [
          Validators.required,
          Validators.email,
        ]),
      });

      expect(form.valid, false);
    });

    test('FormControl has no errors by default', () {
      final formControl = FormControl(
        defaultValue: 'hello',
        validators: [Validators.required],
      );

      expect(formControl.errors.length, 0);
    });

    test('FormControl has no errors if is valid', () {
      final formControl = FormControl(
        validators: [Validators.required],
      );

      formControl.value = 'hello';

      expect(formControl.errors.length, 0);
    });

    test('FormControl errors contains error', () {
      final formControl = FormControl(
        defaultValue: 'hello',
        validators: [Validators.required],
      );

      formControl.value = null;

      expect(formControl.errors.containsKey(ValidationMessage.required), true);
    });

    test('FormControl.errors contains all errors', () {
      final formControl = FormControl(
        defaultValue: 'hi',
        validators: [
          Validators.email,
          Validators.minLength(5),
        ],
      );

      expect(formControl.errors.keys.length, 2);
      expect(formControl.errors[ValidationMessage.email], true, reason: 'mail');
      expect(formControl.errors[ValidationMessage.minLength] != null, true,
          reason: 'minLength');
    });

    test('FormControl.errors contains all matching errors', () {
      final formControl = FormControl(
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      );

      formControl.value = 'hi';

      expect(formControl.errors.keys.length, 1);
      expect(formControl.errors[ValidationMessage.minLength] != null, true);
    });

    test('FormControl with default value contains all matching errors', () {
      final formControl = FormControl(
        defaultValue: 'hi',
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      );

      expect(formControl.errors.keys.length, 1);
      expect(formControl.errors[ValidationMessage.minLength] != null, true);
    });

    test('FormGroup contains all matching errors of nested controls', () {
      final form = FormGroup({
        'name': FormControl(
          defaultValue: 'hi',
          validators: [
            Validators.required,
            Validators.minLength(5),
          ],
        ),
      });

      expect(form.errors.keys.length, 1);
      expect(form.errors['name'] != null, true, reason: 'Name');
      expect(form.errors['name'][ValidationMessage.minLength] != null, true,
          reason: 'name.minLength');
    });

    test('Reset a control restore default value', () {
      final defaultValue = 'john doe';
      final formControl = FormControl(
        defaultValue: defaultValue,
      );

      formControl.value = 'hello john';

      formControl.reset();

      expect(formControl.value, defaultValue);
    });

    test('Reset FormGroup restore default value of all controls', () {
      final defaultName = 'john doe';
      final defaultEmail = 'johndoe@reactiveforms.com';
      final formGroup = FormGroup({
        'name': FormControl(defaultValue: defaultName),
        'email': FormControl(defaultValue: defaultEmail),
      });

      formGroup.formControl('name').value = 'hello john';
      formGroup.formControl('email').value = 'john@reactiveforms.com';

      formGroup.reset();

      expect(formGroup.formControl('name').value, defaultName);
      expect(formGroup.formControl('email').value, defaultEmail);
    });

    test('Set value to FormGroup', () {
      final form = FormGroup({
        'name': FormControl(),
        'email': FormControl(),
      });

      form.value = {
        'name': 'John Doe',
        'email': 'johndoe@email.com',
      };

      expect(form.formControl('name').value, 'John Doe');
      expect(form.formControl('email').value, 'johndoe@email.com');
    });

    test('Get value returns a Map with controls name and values', () {
      final form = FormGroup({
        'name': FormControl(defaultValue: 'john'),
        'email': FormControl(defaultValue: 'john@email.com'),
      });

      final value = form.value;

      expect(jsonEncode(value), '{"name":"john","email":"john@email.com"}');
    });

    test('Assertion Error if passing null controls to constructor', () {
      expect(() => FormGroup(null), throwsAssertionError);
    });

    test('Throws FormControlInvalidNameException if invalid control name', () {
      final form = FormGroup({});

      expect(() => form.formControl('does not exist'),
          throwsA(isInstanceOf<FormControlInvalidNameException>()));
    });
  });
}
