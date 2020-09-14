import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';

class DefaultValueAccessor extends ControlValueAccessor {
  DefaultValueAccessor({
    @required FormControl control,
    @required ReactiveFormFieldState formField,
  }) : super(control: control, formField: formField);

  @override
  viewToModelValue(viewValue) => viewValue;

  @override
  modelToViewValue(modelValue) => modelValue;
}
