import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class IntValueAccessor extends ControlValueAccessor<int, String> {
  @override
  String modelToViewValue(int modelValue) {
    return modelValue == null ? '' : modelValue.toString();
  }

  @override
  int viewToModelValue(String viewValue) {
    return viewValue == '' ? null : int.tryParse(viewValue);
  }
}
