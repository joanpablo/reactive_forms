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

      form.control('name').value = null;

      expect(form.invalid, true);
    });

    test('FormGroup is valid if set valid value to FormControl', () {
      final form = FormGroup({
        'name': FormControl(
          validators: [Validators.required],
        ),
      });

      form.control('name').value = 'hello';

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

    test('Reset group restores default value of all controls', () {
      final defaultName = 'john doe';
      final defaultEmail = 'johndoe@reactiveforms.com';
      final formGroup = FormGroup({
        'name': FormControl(defaultValue: defaultName),
        'email': FormControl(defaultValue: defaultEmail),
      });

      formGroup.control('name').value = 'hello john';
      formGroup.control('email').value = 'john@reactiveforms.com';

      formGroup.reset();

      expect(formGroup.control('name').value, defaultName);
      expect(formGroup.control('email').value, defaultEmail);
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

      expect(form.control('name').value, 'John Doe');
      expect(form.control('email').value, 'johndoe@email.com');
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

    test('Throws FormControlNotFoundException if invalid control name', () {
      final form = FormGroup({});

      expect(() => form.control('does not exist'),
          throwsA(isInstanceOf<FormControlNotFoundException>()));
    });

    test('Mark form as touched mark all controls in the form as touched', () {
      // Given: an untouched form
      final form = FormGroup({
        'name': FormControl(),
        'email': FormControl(),
      });

      // Expect: all controls are untouched
      expect(form.control('name').touched, false);
      expect(form.control('email').touched, false);

      // When: touch the form
      form.touch();

      // Then: all controls are touched
      expect(form.control('name').touched, true);
      expect(form.control('email').touched, true);
    });

    test('Mark form as untouched mark all controls as untouched', () {
      // Given: a form with touched controls
      final form = FormGroup({
        'name': FormControl(touched: true),
        'email': FormControl(touched: true),
      });

      // Expect: all controls are touched
      expect(form.control('name').touched, true);
      expect(form.control('email').touched, true);

      // When: untouch the form
      form.untouch();

      // Then: all controls are untouched
      expect(form.control('name').touched, false);
      expect(form.control('email').touched, false);
    });

    test('The form is touched if at least one control is touched', () {
      // Given: a form with only one control touched
      final form = FormGroup({
        'name': FormControl(),
        'email': FormControl(touched: true),
      });

      // Expect: the form is touched
      expect(form.touched, true);
    });

    test('The form is untouched if all control are untouched', () {
      // Given: a form with no touched controls
      final form = FormGroup({
        'name': FormControl(),
        'email': FormControl(),
      });

      // Expect: the form is touched
      expect(form.touched, false);
    });

    test('FormGroup.controls contains controls collection', () {
      // Given: a group with three controls
      final group = FormGroup({
        'name': FormControl(),
        'email': FormControl(),
        'password': FormControl(),
      });

      // When: count children of array
      int count = group.controls.length;

      // And: get names of controls
      List names = group.controls.keys.toList();

      // Then: count is three
      expect(count, 3);

      // And: names are correct
      expect(names.contains('name'), true);
      expect(names.contains('email'), true);
      expect(names.contains('password'), true);
    });

    test('Group notify value changes when control value changes', () {
      // Given: a form with a controls
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: listen to changes notification
      bool valueChanged = false;
      form.onValueChanged.addListener(() {
        valueChanged = true;
      });

      // And: change value to control
      form.control('name').value = 'Reactive Forms';

      // Then: form value changed fires
      expect(valueChanged, true);
    });

    test('Group stop listing controls when disposed', () {
      // Given: a form with a control
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: dispose form
      form.dispose();

      // And: change value to control
      final setValue = () => form.control('name').value = 'Reactive Forms';

      // Then: assert error
      expect(setValue, throwsAssertionError);
    });

    test('When a group is disable then all children are disabled', () {
      // Given: a form with controls
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: disable group
      form.disable();

      // Then: children are disabled
      expect(form.control('name').disabled, true);
      expect(form.disabled, true);
    });

    test('A control disabled is not part of group value', () {
      // Given: a form with a disable control
      final form = FormGroup({
        'name': FormControl(defaultValue: 'Reactive'),
        'email': FormControl(defaultValue: 'Forms', disabled: true),
      });

      // When: get form value
      final formValue = form.value;

      // Then: disabled control not in value
      expect(formValue.length, 1);
      expect(formValue.keys.first, 'name');
      expect(formValue.values.first, 'Reactive');
    });

    test('Enable a group enable children and recalculate validity', () {
      // Given: a form with a disable control
      final form = FormGroup({
        'name': FormControl(defaultValue: 'Reactive'),
        'email': FormControl(defaultValue: 'Forms', disabled: true),
      });

      // When: enable form
      form.enable();

      // Then: all controls are enabled
      expect(form.controls.values.every((control) => control.enabled), true);
    });
  });
}
