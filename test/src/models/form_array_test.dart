import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('FormArray tests', () {
    test('Form group is invalid if form array is invalid', () {
      // an array of contacts
      final contacts = [
        'john@email.com',
        'susan@email.com',
        'caroline@email.com',
      ];

      // a form with a list of selected emails
      final form = FormGroup({
        'selectedEmails': FormArray<bool>(
          [], // an empty array of controls
          validators: [
            _emptyAddressee
          ], // validates that at least one email is selected
        ),
      });

      // get the array of controls
      final formArray = form.control('selectedEmails') as FormArray<bool>;

      // populates the array of controls.
      // for each contact add a boolean form control to the array.
      formArray.addAll(
        contacts.map((email) => FormControl<bool>(defaultValue: true)).toList(),
      );

      formArray.control('0').value = false;
      formArray.control('1').value = false;
      formArray.control('2').value = false;

      expect(form.valid, false);
    });

    test('Form group is valid if form array is valid', () {
      // an array of contacts
      final contacts = [
        'john@email.com',
        'susan@email.com',
        'caroline@email.com',
      ];

      // a form with a list of selected emails
      final form = FormGroup({
        'selectedEmails': FormArray<bool>(
          [], // an empty array of controls
          validators: [
            _emptyAddressee
          ], // validates that at least one email is selected
        ),
      });

      // get the array of controls
      final formArray = form.control('selectedEmails') as FormArray<bool>;

      // populates the array of controls.
      // for each contact add a boolean form control to the array.
      formArray.addAll(
        contacts.map((email) => FormControl<bool>(defaultValue: true)).toList(),
      );

      formArray.control('0').value = false;
      formArray.control('1').value = true; // at least one is true
      formArray.control('2').value = false;

      expect(form.valid, true);
    });

    test('Throws FormArrayInvalidIndexException if index not a valid int', () {
      final array = FormArray([]);

      expect(() => array.control('control'),
          throwsA(isInstanceOf<FormArrayInvalidIndexException>()));
    });

    test('Assertion Error if passing null controls to constructor', () {
      expect(() => FormArray(null), throwsAssertionError);
    });

    test('Add values to array sets value to each item', () {
      // Given: an array with several items
      final array = FormArray<int>([
        FormControl<int>(),
        FormControl<int>(),
        FormControl<int>(),
      ]);

      //When: set a value to array
      array.value = [1, 2, 3];

      //Then: items has each value
      expect(array.control('0').value, 1);
      expect(array.control('1').value, 2);
      expect(array.control('2').value, 3);
    });

    test('Throws FormControlNotFoundException if invalid control index', () {
      final array = FormArray([]);

      expect(() => array.control('0'),
          throwsA(isInstanceOf<FormControlNotFoundException>()));
    });

    test('Reset array restores default value of all items', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(defaultValue: 1),
        FormControl<int>(defaultValue: 2),
        FormControl<int>(defaultValue: 3),
      ]);

      // When: change values of items
      array.control('0').value = 10;
      array.control('1').value = 20;
      array.control('2').value = 30;

      // And: reset array
      array.reset();

      //Then: items has initial default values
      expect(array.control('0').value, 1);
      expect(array.control('1').value, 2);
      expect(array.control('2').value, 3);
    });

    test('Adding a control to array adds a new value', () {
      // Given: an empty array
      final array = FormArray([]);

      // Expect value as an empty array
      expect([], array.value);

      // When: add one control
      array.add(FormControl<int>(defaultValue: 1));

      // Then: array has one value
      expect(array.value, [1]);
    });

    test('Array is invalid if control is invalid', () {
      // Given: an array with invalid control
      final array = FormArray([
        FormControl(validators: [Validators.required]),
      ]);

      // Expect: array is also invalid
      expect(array.valid, false);
    });

    test('FormArray.controls contains controls collection', () {
      // Given: an array with three controls
      final array = FormArray([
        FormControl(),
        FormControl(),
        FormControl(),
      ]);

      // When: count children of array
      int count = array.controls.length;

      // Then: count is three
      expect(count, 3);
    });

    test('Array notify value changes when control value changes', () {
      // Given: an array with a controls
      final array = FormArray([
        FormControl(),
      ]);

      // When: listen to changes notification
      bool valueChanged = false;
      array.onValueChanged.addListener(() {
        valueChanged = true;
      });

      // And: change value to control
      array.control('0').value = 'Reactive Forms';

      // Then: array value changed fires
      expect(valueChanged, true);
    });

    test('Remove control', () {
      // Given: an array with two controls
      final array = FormArray<String>([
        FormControl<String>(defaultValue: 'Reactive'),
        FormControl<String>(defaultValue: 'Forms'),
      ]);

      // When: removed last control
      array.remove(array.controls.last);

      // Then: last control is removed
      expect(array.value.join(''), 'Reactive');
    });

    test('Insert control at index position', () {
      // Given: an array with two controls
      final array = FormArray<String>([
        FormControl<String>(),
        FormControl<String>(),
      ]);

      // When: insert a control in the middle
      final control = FormControl<String>();
      array.insert(1, control);

      // Then: then the control at index 1 is the one inserted
      expect(array.control('1'), control);
    });

    test('Set value to empty array insert the new items', () {
      // Given: an instance of an empty array
      final array = FormArray<String>([]);

      // Expect: the array is empty
      expect(array.controls.length, 0);

      // When: add value with several controls
      array.value = ['control_1', 'control_2', 'control_3'];

      // Then: the controls are inserted
      expect(array.controls.length, 3);
      expect(array.controls[0].value, 'control_1');
      expect(array.controls[1].value, 'control_2');
      expect(array.controls[2].value, 'control_3');
    });

    test('Array stop listing controls when disposed', () {
      // Given: a form with a control
      final array = FormArray<String>([
        FormControl(),
      ]);

      // When: dispose form
      array.dispose();

      // And: change value to control
      final setValue = () => array.control('0').value = 'Reactive Forms';

      // Then: assert error
      expect(setValue, throwsAssertionError);
    });

    test('When an array is disable then all children are disabled', () {
      // Given: a form with controls
      final array = FormArray([
        FormControl(),
      ]);

      // When: disable group
      array.disable();

      // Then: children are disabled
      expect(array.control('0').disabled, true);
      expect(array.disabled, true);
    });

    test('A control disabled is not part of array value', () {
      // Given: an array with a disable control
      final array = FormArray<String>([
        FormControl(defaultValue: 'Reactive'),
        FormControl(defaultValue: 'Forms', disabled: true),
      ]);

      // When: get form value
      final arrayValue = array.value;

      // Then: disabled control not in value
      expect(arrayValue.length, 1);
      expect(arrayValue.first, 'Reactive');
    });

    test('Enable a array enable children', () {
      // Given: a form with a disable control
      final array = FormArray([
        FormControl(defaultValue: 'Reactive'),
        FormControl(defaultValue: 'Forms', disabled: true),
      ]);

      // When: enable form
      array.enable();

      // Then: all controls are enabled
      expect(array.controls.every((control) => control.enabled), true);
    });

    test('Array valid when invalid control is disable', () {
      // Given: an array with an invalid disable control
      final array = FormArray([
        FormControl(defaultValue: 'Reactive'),
        FormControl(disabled: true, validators: [Validators.required]),
      ]);

      // Expect: form is valid
      expect(array.valid, true);
      expect(array.hasErrors, false);
    });

    test('Array valid when invalid control is disable', () {
      // Given: an array with an invalid control
      final array = FormArray([
        FormControl(defaultValue: 'Reactive'),
        FormControl(validators: [Validators.required]),
      ]);

      // When: disable invalid control
      array.control('1').disable();

      // Then: form is valid
      expect(array.valid, true);
      expect(array.hasErrors, false);
    });

    test('Array invalid when enable invalid control', () {
      // Given: an array with a invalid disable control
      final array = FormArray([
        FormControl(defaultValue: 'Reactive'),
        FormControl(disabled: true, validators: [Validators.required]),
      ]);

      // When: enable invalid control
      array.control('1').enable();

      // Then: form is invalid
      expect(array.invalid, true);
      expect(array.hasErrors, true);
    });
  });
}

Map<String, dynamic> _emptyAddressee(AbstractControl control) {
  final emails = (control as FormArray<bool>).value;
  return emails.any((isSelected) => isSelected)
      ? null
      : {'emptyAddressee': true};
}
