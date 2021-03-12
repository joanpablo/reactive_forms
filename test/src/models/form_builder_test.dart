import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Form Builder', () {
    test('Build a group', () {
      // Given: a form group builder creation
      final form = fb.group({
        'name': 'John',
      });

      // Expect a form group created
      expect(form is FormGroup, true,
          reason: 'form is not instance of FormGroup');
      expect(form.control('name') is FormControl<String>, true,
          reason:
              '${form.control('name').runtimeType} is not instance of FormControl<String>');
    });

    test('Build a group with int control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'age': 33,
      });

      // Expect a form group created
      expect(form.control('age') is FormControl<int>, true,
          reason:
              '${form.control('age').runtimeType} is not instance of FormControl<int>');
    });

    test('Build a group with bool control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'checked': true,
      });

      // Expect a form group created
      expect(form.control('checked') is FormControl<bool>, true,
          reason:
              '${form.control('checked').runtimeType} is not instance of FormControl<bool>');
    });

    test('Build a group with double control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'value': 50.0,
      });

      // Expect a form group created
      expect(form.control('value') is FormControl<double>, true,
          reason:
              '${form.control('value').runtimeType} is not instance of FormControl<double>');
    });

    test('Build a group with datetime control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'value': DateTime.now(),
      });

      // Expect a form group created
      expect(form.control('value') is FormControl<DateTime>, true,
          reason:
              '${form.control('value').runtimeType} is not instance of FormControl<DateTime>');
    });

    test('Build a group with TimeOfDay control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'value': TimeOfDay.now(),
      });

      // Expect a form group created
      expect(form.control('value') is FormControl<TimeOfDay>, true,
          reason:
              '${form.control('value').runtimeType} is not instance of FormControl<TimeOfDay>');
    });

    test('Build a group with dynamic control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'instance': DummyTestClass(),
      });

      // Expect a form group created
      expect(form.control('instance') is FormControl<dynamic>, true,
          reason:
              '${form.control('instance').runtimeType} is not instance of FormControl<dynamic>');
    });

    test('Build a group with form control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': FormControl<String>(),
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<String>, true,
          reason: 'control is not instance of FormControl<String>');
    });

    test('Build a group with single validator', () {
      // Given: a form group builder creation
      final validator = Validators.required;
      final form = fb.group({
        'control': validator,
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<Object>, true,
          reason: 'control is not instance of FormControl<dynamic>');
      expect(form.control('control').validators.first, validator,
          reason: 'validator not set');
    });

    test('Build a group with multiple validators', () {
      // Given: a form group builder creation
      final requiredValidator = Validators.required;
      final emailValidator = Validators.email;

      final form = fb.group({
        'control': [requiredValidator, emailValidator],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<dynamic>, true,
          reason: 'control is not instance of FormControl<dynamic>');
      expect(form.control('control').validators.length, 2,
          reason: 'not set validators');
      expect(form.control('control').validators[0], requiredValidator,
          reason: 'not set required validator');
      expect(form.control('control').validators[1], emailValidator,
          reason: 'not set email validator');
    });

    test('Build a group with multiple validators and implicit type', () {
      // Given: a form group builder creation
      final requiredValidator = Validators.required;
      final emailValidator = Validators.email;

      final form = fb.group({
        'control': ['', requiredValidator, emailValidator],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<String>, true,
          reason: 'control is not instance of FormControl<String>');
      expect(form.control('control').value, '',
          reason: 'control value is not set');
      expect(form.control('control').validators.length, 2,
          reason: 'not set validators');
      expect(form.control('control').validators[0], requiredValidator,
          reason: 'not set required validator');
      expect(form.control('control').validators[1], emailValidator,
          reason: 'not set email validator');
    });

    test('Build a group with default value and validator', () {
      // Given: a form group builder creation
      final requiredValidator = Validators.required;
      final form = fb.group({
        'control': ['', requiredValidator],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<String>, true,
          reason: 'control is not instance of FormControl<String>');
      expect(form.control('control').value, '',
          reason: 'control default value not set');
      expect(form.control('control').validators[0], requiredValidator,
          reason: 'not set required validator');
    });

    test('Build a group with default value in null and validator', () {
      // Given: a form group builder creation
      final requiredValidator = Validators.required;

      final g = {
        'control': [null, requiredValidator],
      };

      print("==================================");
      print(g['control'].runtimeType.toString());
      print("==================================");

      final form = fb.group(g);

      // Expect a form group created
      expect(form.control('control') is FormControl<dynamic>, true,
          reason: 'control is not instance of FormControl<dynamic>');
      expect(form.control('control').value, null,
          reason: 'control default value not set to null');
      expect(form.control('control').validators[0], requiredValidator,
          reason: 'not set required validator');
    });

    test('Build a group with empty array', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': <Object>[],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<dynamic>, true,
          reason: 'control is not instance of FormControl<dynamic>');
    });

    test('Build a group with default value as array', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': [''],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<String>, true,
          reason: 'control is not instance of FormControl<String>');
      expect(form.control('control').value, '',
          reason: 'control default value not set');
    });

    test('Build a group with invalid configuration throws exception', () {
      // Given: a form group builder creation
      final createGroup = () => fb.group({
            'control': [Validators.required, ''],
          });

      // Expect an exception
      expect(() => createGroup(),
          throwsA(isInstanceOf<FormBuilderInvalidInitializationException>()));
    });

    test('Build a group with invalid validators configuration throws exception',
        () {
      // Given: a form group builder creation
      final createGroup = () => fb.group({
            'control': ['', Validators.required, ''],
          });

      // Expect an exception
      expect(() => createGroup(),
          throwsA(isInstanceOf<FormBuilderInvalidInitializationException>()));
    });

    test('Build a group with default bool value as array', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': [true],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<bool>, true,
          reason: 'control is not instance of FormControl<bool>');
      expect(form.control('control').value, true,
          reason: 'control default value not set');
    });

    test('Build a group with default int value as array', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': [50],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<int>, true,
          reason: 'control is not instance of FormControl<int>');
      expect(form.control('control').value, 50,
          reason: 'control default value not set');
    });

    test('Build a group with default double value as array', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': [50.0],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<double>, true,
          reason:
              '${form.control('control').runtimeType} is not instance of FormControl<double>');
      expect(form.control('control').value, 50.0,
          reason: 'control default value not set');
    });

    test('Build a group with default datetime value as array', () {
      // Given: a form group builder creation
      final value = DateTime.now();
      final form = fb.group({
        'control': [value],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<DateTime>, true,
          reason:
              '${form.control('control').runtimeType} is not instance of FormControl<DateTime>');
      expect(form.control('control').value, value,
          reason: 'control default value not set');
    });

    test('Build a group with default TimeOfDay value as array', () {
      // Given: a form group builder creation
      final value = TimeOfDay.now();
      final form = fb.group({
        'control': [value],
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<TimeOfDay>, true,
          reason:
              '${form.control('control').runtimeType} is not instance of FormControl<TimeOfDay>');
      expect(form.control('control').value, value,
          reason: 'control default value not set');
    });

    test('Build a state with ', () {
      // Given: a state creation
      final state = fb.state(value: 'name', disabled: true);

      // Expect the state is created
      expect(state is ControlState<String>, true,
          reason: 'state is not instance of ControlState<String>');
      expect(state.value, 'name', reason: 'state value not set');
      expect(state.disabled, true, reason: 'state disabled not set');
    });

    test('Build an array', () {
      // Given: an array creation
      final array = fb.array(['john', 'little john']);

      // Expect: the array is created
      expect(array is FormArray, true,
          reason: '${array.runtimeType} is not instance of FormArray<String>');
      expect(array.control('0').value, 'john');
      expect(array.value, ['john', 'little john']);
    });

    test('Build a control', () {
      // Given: an array creation
      final control = fb.control('john');

      // Expect: the array is created
      expect(control is FormControl<String>, true,
          reason:
              '${control.runtimeType} is not instance of FormControl<String>');
      expect(control.value, 'john');
    });

    test('Build a group with control', () {
      // Given: a group creation
      final form = fb.group({
        'name': fb.control('john', [Validators.required]),
      });

      // Expect: the group is created
      expect(form.control('name') is FormControl<String>, true);
      expect(form.value, {'name': 'john'});
    });

    test('Build a group with array', () {
      // Given: a group creation
      final form = fb.group({
        'aliases': fb.array(['john', 'little john']),
      });

      // Expect: the group is created
      expect(form.control('aliases') is FormArray, true);
      expect(form.value, {
        'aliases': ['john', 'little john'],
      });
    });

    test('Build group of groups', () {
      // Given: a group creation
      final form = fb.group({
        'address': fb.group({
          'city': 'Sofia',
        }),
      });

      // Expect: the group is created
      expect(form.control('address') is FormGroup, true);
      expect(form.value, {
        'address': {'city': 'Sofia'}
      });
    });

    test('Array of groups defined as Map', () {
      // Given: an array of groups
      final addressArray = fb.array([
        {'city': 'Sofia'},
        {'city': 'Havana'},
      ]);

      // Expect: array is created
      expect(addressArray.controls.length, 2);
      expect(addressArray.control('0').value, {'city': 'Sofia'});
      expect(addressArray.control('0') is FormGroup, true);
    });

    test('Array of groups defined as Map', () {
      // Given: an array of groups
      final addressArray = fb.array([
        {
          'city': ['Sofia', Validators.required]
        },
        {
          'city': ['Sofia', Validators.required]
        },
      ]);

      // Expect: array is created
      expect(addressArray.controls.length, 2);
      expect(addressArray.control('0').value, {'city': 'Sofia'});
      expect(addressArray.control('0') is FormGroup, true);
    });

    test('Array of groups', () {
      // Given: an array of groups
      final addressArray = fb.array([
        fb.group({'city': 'Sofia'}),
        fb.group({'city': 'Havana'}),
      ]);

      // Expect: array is created
      expect(addressArray.controls.length, 2);
      expect(addressArray.control('0') is FormGroup, true,
          reason: 'first item is not a group');
      expect(addressArray.control('0').value, {'city': 'Sofia'});
    });
  });
}

class DummyTestClass {}
