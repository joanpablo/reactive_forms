import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class DefaultValueAccessor extends ControlValueAccessor {
  @override
  dynamic viewToModelValue(viewValue) => viewValue;

  @override
  dynamic modelToViewValue(modelValue) => modelValue;
}
