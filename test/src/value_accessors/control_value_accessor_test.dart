import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DummyValueAccessor extends ControlValueAccessor<Object, Object> {
  @override
  Object? modelToViewValue(Object? modelValue) => modelValue;

  @override
  Object? viewToModelValue(Object? viewValue) => viewValue;
}

void main() {
  group('ControlValueAccessor Tests', () {
    test('Register a control inside value accessor', () {
      // Given: a value accessor
      final valueAccessor = DummyValueAccessor();

      // And: a control
      final control = fb.control('');

      // When: register a control with value accessor
      valueAccessor.registerControl(control);

      // Then: value accessor hold the instance of the control
      expect(valueAccessor.control, control);
    });

    test('Update model before register a control raises an exception', () {
      // Given: a value accessor
      final valueAccessor = DummyValueAccessor();

      // When: call updateModel before register a control
      final updateModel = () => valueAccessor.updateModel('');

      // Then: value accessor hold the instance of the control
      expect(
          () => updateModel(), throwsA(isInstanceOf<ValueAccessorException>()));
    });
  });
}
