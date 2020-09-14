import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class DoubleValueAccessor extends ControlValueAccessor<double, String> {
  DoubleValueAccessor({
    @required FormControl control,
    @required ReactiveFormFieldState formField,
  }) : super(control: control, formField: formField);

  @override
  String modelToViewValue(double modelValue) {
    return modelValue.toString();
  }

  @override
  double viewToModelValue(String viewValue) {
    return viewValue == '' ? null : double.tryParse(viewValue);
  }
}
