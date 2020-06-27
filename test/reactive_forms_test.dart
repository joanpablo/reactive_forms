import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/models/form_control.dart';
import 'package:reactive_forms/models/form_group.dart';
import 'package:reactive_forms/validators/validators.dart';

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

      expect(form.valid, false);
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

      expect(form.valid, false);
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

      expect(formControl.errors.containsKey('required'), true);
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
      expect(formControl.errors['email'], true, reason: 'mail');
      expect(formControl.errors['minLength'] != null, true,
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
      expect(formControl.errors['minLength'] != null, true);
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
      expect(formControl.errors['minLength'] != null, true);
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
  });
}
