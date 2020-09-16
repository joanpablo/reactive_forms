import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ChangeFunction<K> = dynamic Function(K value);

abstract class ControlValueAccessor<T, K> {
  FormControl<T> _control;
  ChangeFunction<K> _onChange;

  FormControl<T> get control => _control;

  T viewToModelValue(K viewValue);

  K modelToViewValue(T modelValue);

  void updateModel(K viewValue) {
    final modelValue = this.viewToModelValue(viewValue);

    if (_control.value != modelValue) {
      _control.markAsDirty(emitEvent: false);
      _control.updateValue(modelValue /*, emitModelToViewChange: false*/);
    }
  }

  void registerControl(FormControl<T> control) {
    assert(control != null);
    _control = control;
    _control.modelToViewChanges.addListener(_onModelChange);
  }

  void registerOnChange(ChangeFunction<K> onChange) {
    _onChange = onChange;
  }

  @mustCallSuper
  void dispose() {
    _control.modelToViewChanges.removeListener(_onModelChange);
  }

  void _onModelChange() {
    final viewValue = this.modelToViewValue(_control.value);
    if (_onChange != null) {
      _onChange(viewValue);
    }
  }
}
