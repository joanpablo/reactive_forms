import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Form Control', () {
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

      expect(formControl.errors.containsKey(ValidationMessage.required), true);
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
      expect(formControl.errors[ValidationMessage.email], true, reason: 'mail');
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
        defaultValue: 'hi',
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      );

      expect(formControl.errors.keys.length, 1);
      expect(formControl.errors[ValidationMessage.minLength] != null, true);
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

    test('Assert error if debounce time < 0', () {
      final formControl = () => FormControl(asyncValidatorsDebounceTime: -1);
      expect(formControl, throwsAssertionError);
    });

    test('Call enable() set enabled status', () {
      // Given: a control
      final control = FormControl();

      // Expect: is enabled
      expect(control.enabled, true);

      // When: call disabled()
      control.disable();

      // Then: the control change status to disabled
      expect(control.disabled, true);
      expect(control.enabled, false);
      expect(control.status, ControlStatus.disabled);
    });

    test('Create control with disabled status', () {
      // Given: a control disabled
      final control = FormControl(disabled: true);

      // Expect: is disabled
      expect(control.disabled, true);
      expect(control.enabled, false);
      expect(control.status, ControlStatus.disabled);
    });

    test('Control disabled does not validate', () {
      // Given: a required control
      final control = FormControl<String>(validators: [Validators.required]);

      // When: call disabled()
      control.disable();

      // When: set value to control
      control.value = 'disabled control';

      // Expect: disable control
      expect(control.disabled, true);
      expect(control.status, ControlStatus.disabled);
    });
  });
}
