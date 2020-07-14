import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/models/form_array.dart';
import 'package:reactive_forms/models/form_control.dart';
import 'package:reactive_forms/models/form_group.dart';
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
      final formArray = form.formControl('selectedEmails') as FormArray<bool>;

      // populates the array of controls.
      // for each contact add a boolean form control to the array.
      formArray.addAll(
        contacts.map((email) => FormControl<bool>(defaultValue: true)).toList(),
      );

      formArray.formControl('0').value = false;
      formArray.formControl('1').value = false;
      formArray.formControl('2').value = false;

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
      final formArray = form.formControl('selectedEmails') as FormArray<bool>;

      // populates the array of controls.
      // for each contact add a boolean form control to the array.
      formArray.addAll(
        contacts.map((email) => FormControl<bool>(defaultValue: true)).toList(),
      );

      formArray.formControl('0').value = false;
      formArray.formControl('1').value = true; // at least one is true
      formArray.formControl('2').value = false;

      expect(form.valid, true);
    });

    test('Throws FormArrayInvalidIndexException if index not a valid int', () {
      final array = FormArray([]);

      expect(() => array.formControl('control'),
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
      expect(array.formControl('0').value, 1);
      expect(array.formControl('1').value, 2);
      expect(array.formControl('2').value, 3);
    });

    test('Throws FormControlNotFoundException if invalid control index', () {
      final array = FormArray([]);

      expect(() => array.formControl('0'),
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
      array.formControl('0').value = 10;
      array.formControl('1').value = 20;
      array.formControl('2').value = 30;

      // And: reset array
      array.reset();

      //Then: items has initial default values
      expect(array.formControl('0').value, 1);
      expect(array.formControl('1').value, 2);
      expect(array.formControl('2').value, 3);
    });
  });
}

Map<String, dynamic> _emptyAddressee(AbstractControl control) {
  final emails = (control as FormArray<bool>).value;
  return emails.any((isSelected) => isSelected)
      ? null
      : {'emptyAddressee': true};
}
