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
        contacts.map((email) => FormControl<bool>(value: true)).toList(),
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
        contacts.map((email) => FormControl<bool>(value: true)).toList(),
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

    test('Reset array restores default value of all items to null', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
        FormControl<int>(value: 2),
        FormControl<int>(value: 3),
      ]);

      // And: reset array
      array.reset();

      //Then: items has initial default values
      expect(array.control('0').value, null);
      expect(array.control('1').value, null);
      expect(array.control('2').value, null);
    });

    test('Reset array with initial values', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
        FormControl<int>(value: 2),
        FormControl<int>(value: 3),
      ]);

      // And: reset array
      array.reset(value: [4, 5, 6]);

      //Then: items has initial default values
      expect(array.control('0').value, 4);
      expect(array.control('1').value, 5);
      expect(array.control('2').value, 6);
    });

    test('Reset array with less initial values', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
        FormControl<int>(value: 2),
        FormControl<int>(value: 3),
      ]);

      // And: reset array
      array.reset(value: [4, 5]);

      //Then: items has initial default values
      expect(array.control('0').value, 4);
      expect(array.control('1').value, 5);
      expect(array.control('2').value, 3);
    });

    test('Reset array with more initial values', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
        FormControl<int>(value: 2),
        FormControl<int>(value: 3),
      ]);

      // And: reset array
      array.reset(value: [4, 5, 6, 7]);

      //Then: items has initial default values
      expect(array.controls.length, 4);
      expect(array.control('0').value, 4);
      expect(array.control('1').value, 5);
      expect(array.control('2').value, 6);
      expect(array.control('3').value, 7);
    });

    test('Reset array with disabled states', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
      ]);

      // And: reset array value and disable the control
      array.resetState([
        ControlState(disabled: true),
      ]);

      //Then: items has initial reset values and are disabled
      expect(array.control('0').value, null);
      expect(array.control('0').disabled, true);
    });

    test('Reset array with state', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
      ]);

      // And: reset array value with state
      array.resetState([
        ControlState(value: 2),
      ]);

      //Then: items has initial reset values and are enabled
      expect(array.control('0').value, 2);
      expect(array.control('0').enabled, true);
    });

    test('Reset array marks it as pristine', () {
      // Given: an array
      final array = FormArray<int>([
        FormControl<int>(),
      ]);

      // When: mark it as dirty
      array.markAsDirty();

      // Expect: is dirty
      expect(array.dirty, true);

      // When: reset array
      array.reset();

      //Then: array is pristine
      expect(array.pristine, true);
    });

    test('Reset array state marks it as pristine', () {
      // Given: an array with items with default values
      final array = FormArray<int>([
        FormControl<int>(value: 1),
      ]);

      // When: mark it as dirty
      array.markAsDirty();

      // And: reset array value with state
      array.resetState([
        ControlState(value: 2),
      ]);

      //Then: array is pristine
      expect(array.pristine, true, reason: 'array is not pristine');
    });

    test('Adding a control to array adds a new value', () {
      // Given: an empty array
      final array = FormArray([]);

      // Expect value as an empty array
      expect([], array.value);

      // When: add one control
      array.add(FormControl<int>(value: 1));

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

      final value = 'Reactive Forms';

      // Expect: array notify value changes
      expectLater(array.valueChanges, emits([value]));

      // When: change value of a control
      array.control('0').value = value;
    });

    test('Remove control', () {
      // Given: an array with two controls
      final array = FormArray<String>([
        FormControl<String>(value: 'Reactive'),
        FormControl<String>(value: 'Forms'),
      ]);

      // When: removed last control
      array.remove(array.controls.last);

      // Then: last control is removed
      expect(array.value!.join(''), 'Reactive');
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

    test('When an array is disable then all children are disabled', () {
      // Given: a form with controls
      final array = FormArray([
        FormControl(),
      ]);

      // When: disable group
      array.markAsDisabled();

      // Then: children are disabled
      expect(array.control('0').disabled, true);
      expect(array.disabled, true);
    });

    test('A control disabled is not part of array value', () {
      // Given: an array with a disable control
      final array = FormArray<String>([
        FormControl(value: 'Reactive'),
        FormControl(value: 'Forms', disabled: true),
      ]);

      // When: get form value
      final arrayValue = array.value;

      // Then: disabled control not in value
      expect(arrayValue!.length, 1);
      expect(arrayValue.first, 'Reactive');
    });

    test('A control disabled is part of array Raw Value', () {
      // Given: an array with a disable control
      final array = FormArray<String>([
        FormControl(value: 'Reactive'),
        FormControl(value: 'Forms', disabled: true),
      ]);

      // Expect: raw value includes disabled controls
      expect(array.rawValue.length, 2);
      expect(array.rawValue, ['Reactive', 'Forms']);
    });

    test('Enable a array enable children', () {
      // Given: a form with a disable control
      final array = FormArray([
        FormControl(value: 'Reactive'),
        FormControl(value: 'Forms', disabled: true),
      ]);

      // When: enable form
      array.markAsEnabled();

      // Then: all controls are enabled
      expect(array.controls.every((control) => control.enabled), true);
    });

    test('Array valid when invalid control is disable', () {
      // Given: an array with an invalid disable control
      final array = FormArray([
        FormControl(value: 'Reactive'),
        FormControl(disabled: true, validators: [Validators.required]),
      ]);

      // Expect: form is valid
      expect(array.valid, true);
      expect(array.hasErrors, false);
    });

    test('Array valid when invalid control is disable', () {
      // Given: an array with an invalid control
      final array = FormArray([
        FormControl(value: 'Reactive'),
        FormControl(validators: [Validators.required]),
      ]);

      // When: disable invalid control
      array.control('1').markAsDisabled();

      // Then: form is valid
      expect(array.valid, true);
      expect(array.hasErrors, false);
    });

    test('Array invalid when enable invalid control', () {
      // Given: an array with a invalid disable control
      final array = FormArray([
        FormControl(value: 'Reactive'),
        FormControl(disabled: true, validators: [Validators.required]),
      ]);

      // When: enable invalid control
      array.control('1').markAsEnabled();

      // Then: form is invalid
      expect(array.invalid, true, reason: 'array is valid');
      expect(array.hasErrors, true, reason: 'array has errors');
    });

    test('State error if dispose an array and try to change value', () {
      // Given: an array
      final array = FormArray([
        FormControl(),
      ]);

      // When: dispose the array
      array.dispose();

      // And: try to change value of children
      final addValue = () => array.control('0').value = 'some';

      // Then: state error
      expect(() => addValue(), throwsStateError);
    });
  });
  test('Set empty array value to array does not update values', () {
    // Given: an array with items with default values
    final array = FormArray<int>([
      FormControl<int>(value: 1),
      FormControl<int>(value: 2),
      FormControl<int>(value: 3),
    ]);

    // And: reset array
    array.value = [];

    //Then: items has initial default values
    expect(array.control('0').value, 1);
    expect(array.control('1').value, 2);
    expect(array.control('2').value, 3);
  });

  test('Get control with nested name', () {
    // Given: a nested array
    final form = FormGroup({
      'numbers': FormArray<int>([
        FormControl<int>(value: 1),
        FormControl<int>(value: 2),
        FormControl<int>(value: 3),
      ]),
    });

    // When: get a nested control
    final control = form.control('numbers.2');

    // Then: control is not null
    expect(control is FormControl<int>, true);
    expect(control.value, 3);
  });

  test('Array of groups', () {
    // Given: an array of groups
    final addressArray = FormArray([
      fb.group({'city': 'Sofia'}),
      fb.group({'city': 'Havana'}),
    ]);

    // Expect: array is created
    expect(addressArray.controls.length, 2);
    expect(addressArray.control('0').value, {'city': 'Sofia'});
  });

  test('Focused a control', () {
    // Given: an array
    final array = FormArray<int>([
      FormControl<int>(value: 1),
      FormControl<int>(value: 2),
      FormControl<int>(value: 3),
    ]);

    // When: set a control focus
    array.focus('0');

    // Then: control is focused
    expect((array.control('0') as FormControl).hasFocus, true,
        reason: 'control is not focused');
  });

  test('Focused a nested control', () {
    // Given: array
    final addressArray = FormArray([
      fb.group({'city': 'Sofia'}),
      fb.group({'city': 'Havana'}),
    ]);

    // When: set a control focus
    addressArray.focus('0.city');

    final FormControl<String?> city =
        addressArray.control('0.city') as FormControl<String?>;

    // Then: control is focused
    expect(city.hasFocus, true, reason: 'control is not focused');
  });

  test('Remove Focus to all control', () {
    // Given: array
    final array = FormArray<int>([
      FormControl<int>(value: 1),
      FormControl<int>(value: 2),
    ]);

    // And: all control with focus
    array.focus('0');
    array.focus('1');

    // When: remove focus to a control
    array.unfocus();

    // Then: any control has focus
    expect((array.control('0') as FormControl).hasFocus, false,
        reason: 'control is focused');
    expect((array.control('1') as FormControl).hasFocus, false,
        reason: 'control is focused');
  });

  test('Clear Array', () {
    // Given: array
    final array = FormArray<int>([
      FormControl<int>(value: 1),
      FormControl<int>(value: 2),
    ]);

    // When: clear array
    array.clear();

    // Then: any control has focus
    expect(array.controls.length, 0, reason: 'array is not empty');
  });

  test("Initialize disabled array", () {
    // Given: a disabled form
    final array = FormArray([
      FormControl<String>(),
      FormControl<String>(),
    ], disabled: true);

    // Then: array is disabled and all controls are disabled
    expect(array.enabled, false, reason: 'array is enabled');
    expect(array.controls[0].enabled, false, reason: 'first is enabled');
    expect(array.controls[1].enabled, false, reason: 'second is enabled');
  });

  test("Disabled array changes to enable when enable children", () {
    // Given: a disabled array
    final array = FormArray([
      FormControl<String>(),
      FormControl<String>(),
    ], disabled: true);

    // When: enabled child
    array.controls.first.markAsEnabled();

    // Then: array is enabled
    expect(array.enabled, true, reason: 'array is disabled');
    expect(array.controls[0].enabled, true, reason: 'first is disabled');
    expect(array.controls[1].disabled, true, reason: 'second is enabled');
  });

  test("Patch array value", () {
    // Given: an array
    final array = FormArray<int>([
      FormControl<int>(value: 1),
      FormControl<int>(value: 2),
    ]);

    // When: patch array value
    array.patchValue([2]);

    // Then: array value is patched
    expect(array.value, [2, 2], reason: 'array value not patched');
  });
}

Map<String, dynamic>? _emptyAddressee(AbstractControl<Object> control) {
  final emails = (control as FormArray<bool>).value;
  return emails?.any((isSelected) => isSelected!) == true
      ? null
      : {'emptyAddressee': true};
}
