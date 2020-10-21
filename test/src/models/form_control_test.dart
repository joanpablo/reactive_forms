import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Form Control', () {
    test('FormControl has no errors by default', () {
      final formControl = FormControl(
        value: 'hello',
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
        value: 'hello',
        validators: [Validators.required],
      );

      formControl.value = null;

      expect(formControl.errors.containsKey(ValidationMessage.required), true);
    });

    test('FormControl.errors contains all errors', () {
      final formControl = FormControl(
        value: 'hi',
        validators: [
          Validators.email,
          Validators.minLength(5),
        ],
      );

      expect(formControl.errors.keys.length, 2);
      expect(formControl.errors.containsKey(ValidationMessage.email), true,
          reason: 'mail');
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
        value: 'hi',
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      );

      expect(formControl.errors.keys.length, 1);
      expect(formControl.errors[ValidationMessage.minLength] != null, true);
    });

    test('Reset a control set value to null', () {
      final formControl = FormControl(
        value: 'john doe',
      );

      formControl.value = 'hello john';

      formControl.reset();

      expect(formControl.value, null);
    });

    test('Assert error if debounce time < 0', () {
      final formControl = () => FormControl(asyncValidatorsDebounceTime: -1);
      expect(formControl, throwsAssertionError);
    });

    test('Call enable() set enabled status', () {
      // Given: a control
      final control = FormControl();

      // Expect: control is enabled
      expect(control.enabled, true);

      // When: disable the control
      control.markAsDisabled();

      // Then: control status changes to disabled
      expect(control.disabled, true);
      expect(control.enabled, false);
      expect(control.status, ControlStatus.disabled);
    });

    test('Create control with disabled status', () {
      // Given: a disabled control
      final control = FormControl(disabled: true);

      // Expect: is disabled
      expect(control.disabled, true);
      expect(control.enabled, false);
      expect(control.status, ControlStatus.disabled);
    });

    test('Control disabled does not validate', () {
      // Given: a required control
      final control = FormControl<String>(validators: [Validators.required]);

      // When: disable the control
      control.markAsDisabled();

      // When: set value to control
      control.value = 'disabled control';

      // Expect: control is disabled
      expect(control.disabled, true);
      expect(control.status, ControlStatus.disabled);
    });

    test('Resets a control and sets initial value', () {
      // Given: a touched control with some default value
      final control = FormControl<String>(
        value: 'someValue',
        touched: true,
      );

      // When: reset control with other initial value
      final initialValue = 'otherValue';
      control.reset(value: initialValue);

      // Expect: the control has initial value
      expect(control.value, initialValue);
      // And: control is untouched
      expect(control.touched, false);
    });

    test('Resets a control and sets initial value and disabled state', () {
      // Given: a touched control with some default value
      final control = FormControl<String>(
        value: 'someValue',
        touched: true,
      );

      // When: reset control with other initial value and sets to disabled
      final initialValue = 'otherValue';
      control.reset(value: initialValue, disabled: true);

      // Then: the control has initial value
      expect(control.value, initialValue);
      // And: control is untouched
      expect(control.touched, false);
      // And: is disabled
      expect(control.disabled, true);
    });

    test('Resets a control to enable state', () {
      // Given: a disabled control
      final control = FormControl<String>(value: 'someValue', disabled: true);

      // When: reset control
      control.reset(disabled: false);

      // Then: the control is enabled
      expect(control.enabled, true);
    });

    test('Reset a control marks it as pristine', () {
      // Given: a control
      final control = FormControl<String>();

      // When: control is dirty
      control.markAsDirty();

      // And: reset the control
      control.reset();

      // Then: the control is pristine
      expect(control.pristine, true);
    });

    test('Reset a control and remove focus at the same time', () {
      // Given: a control
      final control = FormControl<String>();

      // When: control request focus
      control.focus();

      // Expect: control has focus
      expect(control.hasFocus, true, reason: 'control does not get focus');

      // When: reset the control and remove focus
      control.reset(removeFocus: true);

      // Then: the control does not have the focus
      expect(control.hasFocus, false, reason: 'control has focus');
    });

    test('Set value to a control programmatically does not marks it dirty', () {
      // Given: a control
      final control = FormControl<String>();

      // When: set a value
      control.value = 'some value';

      // Then: the control is pristine
      expect(control.pristine, true);
    });

    test('SetErrors marks control as dirty by default', () {
      // Given: a control
      final control = FormControl<String>();

      // When: set errors
      control.setErrors({'someError': true});

      // Then: the control is dirty
      expect(control.dirty, true);
    });

    test('Set errors and keep the control as pristine', () {
      // Given: a control
      final control = FormControl<String>();

      // When: set errors and specify markAsDirty = false
      control.setErrors({'someError': true}, markAsDirty: false);

      // Then: the control is pristine
      expect(control.pristine, true);
    });

    test('Checks if control has error', () {
      // Given: a required and invalid control
      final control = FormControl<String>(validators: [Validators.required]);

      // Expect: control has Validators.required error
      expect(control.hasError(ValidationMessage.required), true);
    });

    test('Checks if control has error', () {
      // Given: a valid control
      final control = FormControl<String>();

      // Expect: control doesn't have Validators.required error
      expect(control.hasError(ValidationMessage.required), false);
    });

    test('Reports control error', () {
      // Given: a required and invalid control
      final control = FormControl<String>(validators: [Validators.required]);

      // When: get tha control error by errorCode
      final error = control.getError(ValidationMessage.required);

      // Then: the error is not null
      expect(error, true);
    });
  });
}
