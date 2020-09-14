import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class IntValueAccessor extends ControlValueAccessor<int, String> {
  IntValueAccessor({
    @required FormControl control,
    @required ReactiveFormFieldState formField,
  }) : super(control: control, formField: formField);

  @override
  String modelToViewValue(int modelValue) {
    return modelValue.toString();
  }

  @override
  int viewToModelValue(String viewValue) {
    return viewValue == '' ? null : int.tryParse(viewValue);
  }
}
