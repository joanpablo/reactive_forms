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
  });
}

Map<String, dynamic> _emptyAddressee(AbstractControl control) {
  final emails = (control as FormArray<bool>).value;
  return emails.any((isSelected) => isSelected)
      ? null
      : {'emptyAddressee': true};
}
