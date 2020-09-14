import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class ControlValueAccessor<T, K> {
  final FormControl<T> control;
  final ReactiveFormFieldState<K> formField;

  ControlValueAccessor({
    @required this.control,
    @required this.formField,
  })  : assert(control != null),
        assert(formField != null);

  void updateView(T modelValue) {
    final viewValue = this.modelToViewValue(modelValue);
    this.formField.updateValueFromControl(viewValue);
  }

  void updateModel(K viewValue) {
    final modelValue = this.viewToModelValue(viewValue);
    if (this.control.value != modelValue) {
      this.control.markAsDirty(emitEvent: false);
      this.control.updateValue(modelValue, emitModelToViewChange: false);
    }
  }

  T viewToModelValue(K viewValue);

  K modelToViewValue(T modelValue);
}
