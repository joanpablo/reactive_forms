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
      expect(form != null, true, reason: 'form is null');
      expect(form is FormGroup, true,
          reason: 'form is not instance of FormGroup');
      expect(form.control('name') != null, true, reason: 'control is null');
      expect(form.control('name') is FormControl<String>, true,
          reason: 'control is not instance of FormControl<String>');
    });

    test('Build a group with int control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'age': 33,
      });

      // Expect a form group created
      expect(form.control('age') is FormControl<int>, true,
          reason: 'control is not instance of FormControl<int>');
    });

    test('Build a group with bool control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'checked': true,
      });

      // Expect a form group created
      expect(form.control('checked') is FormControl<bool>, true,
          reason: 'control is not instance of FormControl<bool>');
    });

    test('Build a group with double control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'value': 50.0,
      });

      // Expect a form group created
      expect(form.control('value') is FormControl<double>, true,
          reason: 'control is not instance of FormControl<double>');
    });

    test('Build a group with dynamic control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'instance': DummyTestClass(),
      });

      // Expect a form group created
      expect(form.control('instance') is FormControl<dynamic>, true,
          reason: 'control is not instance of FormControl<dynamic>');
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

    test('Build a group with null control', () {
      // Given: a form group builder creation
      final form = fb.group({
        'control': null,
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<dynamic>, true,
          reason: 'control is not instance of FormControl<dynamic>');
    });

    test('Build a group with single validator', () {
      // Given: a form group builder creation
      final validator = Validators.required;
      final form = fb.group({
        'control': validator,
      });

      // Expect a form group created
      expect(form.control('control') is FormControl<dynamic>, true,
          reason: 'control is not instance of FormControl<dynamic>');
      expect(form.control('control').validators.first, validator,
          reason: 'validator not set');
    });

    test('Build a group with multiple validators', () {
      // Given: a form group builder creation
      final requiredValidator = Validators.required;
      final emailValidator = Validators.required;
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
  });
}

class DummyTestClass {}
