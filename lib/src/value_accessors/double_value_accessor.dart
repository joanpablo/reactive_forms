import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class DoubleValueAccessor extends ControlValueAccessor<double, String> {
  @override
  String modelToViewValue(double modelValue) {
    return modelValue.toString();
  }

  @override
  double viewToModelValue(String viewValue) {
    return viewValue == '' ? null : double.tryParse(viewValue);
  }
}
