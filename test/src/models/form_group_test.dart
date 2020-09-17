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
          value: 'hello',
          validators: [Validators.required],
        ),
      });

      expect(form.valid, true);
    });

    test('FormGroup is invalid if set invalid value to FormControl', () {
      final form = FormGroup({
        'name': FormControl(
          value: 'hello',
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
          value: 'hello',
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
          value: 'hi',
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

    test('Reset group restores value of all controls to null', () {
      final formGroup = FormGroup({
        'name': FormControl(value: 'john doe'),
        'email': FormControl(value: 'johndoe@reactiveforms.com'),
      });

      formGroup.control('name').value = 'hello john';
      formGroup.control('email').value = 'john@reactiveforms.com';

      formGroup.reset();

      expect(formGroup.control('name').value, null);
      expect(formGroup.control('email').value, null);
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
        'name': FormControl(value: 'john'),
        'email': FormControl(value: 'john@email.com'),
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

      // When: marks all descendants to touched
      form.markAllAsTouched();

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
      form.markAsUntouched();

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

      final value = 'Reactive Forms';

      // Expect: form notify value changes
      expectLater(form.valueChanges, emits({'name': value}));

      // When: change value of the control
      form.control('name').value = 'Reactive Forms';
    });

    test('When a group is disable then all children are disabled', () {
      // Given: a form with controls
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: disable group
      form.markAsDisabled();

      // Then: children are disabled
      expect(form.control('name').disabled, true);
      expect(form.disabled, true);
    });

    test('A control disabled is not part of group value', () {
      // Given: a form with a disable control
      final form = FormGroup({
        'name': FormControl(value: 'Reactive'),
        'email': FormControl(value: 'Forms', disabled: true),
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
        'name': FormControl(value: 'Reactive'),
        'email': FormControl(value: 'Forms', disabled: true),
      });

      // When: enable form
      form.markAsEnabled();

      // Then: all controls are enabled
      expect(form.controls.values.every((control) => control.enabled), true);
    });

    test('Group valid when invalid control is disable', () {
      // Given: a form with an invalid disable control
      final form = FormGroup({
        'name': FormControl(value: 'Reactive'),
        'email': FormControl(disabled: true, validators: [Validators.required]),
      });

      // Expect: form is valid
      expect(form.valid, true);
      expect(form.hasErrors, false);
    });

    test('Group valid when invalid control is disable', () {
      // Given: a form with an invalid control
      final form = FormGroup({
        'name': FormControl(value: 'Reactive'),
        'email': FormControl(validators: [Validators.required]),
      });

      // When: disable invalid control
      form.control('email').markAsDisabled();

      // Then: form is valid
      expect(form.valid, true);
      expect(form.hasErrors, false);
    });

    test('Group invalid when enable invalid control', () {
      // Given: a form with a invalid disable control
      final form = FormGroup({
        'name': FormControl(value: 'Reactive'),
        'email': FormControl(disabled: true, validators: [Validators.required]),
      });

      // When: enable invalid control
      form.control('email').markAsEnabled();

      // Then: form is invalid
      expect(form.invalid, true, reason: 'form is valid');
      expect(form.hasErrors, true, reason: 'form has errors');
    });

    test('State error if dispose a Group and try to change control value', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: dispose the form
      form.dispose();

      // And: try to change value of children
      final addValue = () => form.control('name').value = 'some';

      // Then: state error
      expect(() => addValue(), throwsStateError);
    });

    test('Resets a group and set initial values', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(
          value: 'someInitialValue',
          touched: true,
        ),
      });

      // When: resets the group
      final initialValue = 'otherInitialValue';
      form.reset(value: {
        'name': initialValue,
      });

      // Then: value of the control has the new initial value
      expect(form.control('name').value, initialValue);
      expect(form.control('name').touched, false);
    });

    test('Resets a group and set initial values and disabled', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(
          value: 'someInitialValue',
          touched: true,
        ),
      });

      // When: resets the group
      final initialValue = 'otherInitialValue';
      form.resetState({
        'name': ControlState(value: initialValue, disabled: true),
      });

      // Then: value of the control has the new initial value
      expect(form.control('name').value, initialValue);
      expect(form.control('name').touched, false);
      expect(form.control('name').disabled, true);
    });

    test('Resets a group with null state', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(
          value: 'someInitialValue',
          touched: true,
        ),
      });

      // When: resets the group
      form.resetState(null);

      // Then: all controls has null value
      expect(form.control('name').value, null);
      expect(form.control('name').touched, false);
    });

    test('Resets a group with empty {} state', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(
          value: 'someInitialValue',
          touched: true,
        ),
      });

      // When: resets the group
      form.resetState({});

      // Then: all controls has null value
      expect(form.control('name').value, null, reason: 'value is not null');
      expect(form.control('name').touched, false, reason: 'control is touched');
    });

    test('Reset a group marks it as pristine', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: marks it as dirty
      form.markAsDirty();

      // Expect: is dity
      expect(form.dirty, true);

      // When: resets the group
      form.reset();

      // Then: value of the control has the new initial value
      expect(form.pristine, true);
    });

    test('Resets a group state marks it as pristine', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(),
      });

      // When: marks it as dirty
      form.markAsDirty();

      // Expect: form is dirty
      expect(form.dirty, true);

      // When: resets the group
      form.resetState({});

      // Then: all controls has null value
      expect(form.dirty, false, reason: 'form is dirty');
      expect(form.pristine, true, reason: 'form is dirty');
    });

    test('Resets a group state marks it as pristine', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl(value: 'initial value'),
      });

      // When: marks it as dirty
      form.markAsDirty();

      // Expect: form is dirty
      expect(form.dirty, true);

      // When: resets the group
      form.resetState({'name': null});

      // Then: all controls has null value
      expect(form.dirty, false, reason: 'form is pristine');
      expect(form.pristine, true, reason: 'form is dirty');
    });

    test('Get control with nested name', () {
      // Given: a nested group
      final form = FormGroup({
        'address': FormGroup({
          'zipCode': FormControl<int>(value: 1000),
          'city': FormControl<String>(value: 'Sofia'),
        }),
      });

      // When: gets nested control value
      final city = form.control('address.city');

      // Then: control is not null
      expect(city is FormControl<String>, true,
          reason: '$city is not a control');
      expect(city.value, 'Sofia', reason: 'control without correct value');
    });

    test('Get control with nested deep name', () {
      // Given: a nested group
      final form = FormGroup({
        'address': FormArray([
          FormGroup({
            'zipCode': FormControl<int>(value: 1000),
            'city': FormControl<String>(value: 'Sofia'),
          })
        ]),
      });

      // When: gets nested control value
      final city = form.control('address.0.city');

      // Then: control is not null
      expect(city is FormControl<String>, true,
          reason: '$city is not a control');
      expect(city.value, 'Sofia', reason: 'control without correct value');
    });

    test('Focused a control', () {
      // Given: a group
      final form = FormGroup({
        'name': FormControl<String>(),
      });

      // When: set a control focus
      form.focus('name');

      // Then: control is focused
      expect((form.control('name') as FormControl).focused, true,
          reason: 'control is not focused');
    });

    test('Focused a nested control', () {
      // Given: a group
      final form = FormGroup({
        'person': FormGroup({
          'name': FormControl<String>(),
        }),
      });

      // When: set a control focus
      form.focus('person.name');

      // Then: control is focused
      expect((form.control('person.name') as FormControl).focused, true,
          reason: 'control is not focused');
    });
  });
}
