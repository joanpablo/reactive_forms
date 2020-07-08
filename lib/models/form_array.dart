import 'package:reactive_forms/reactive_forms.dart';

class FormArray<T> extends AbstractControl<Iterable<T>> {
  final List<AbstractControl<T>> _controls = [];

  FormArray(Iterable<AbstractControl<T>> controls) {
    _controls.addAll(controls);
  }

  @override
  Iterable<T> get value => _controls.map((control) => control.value).toList();

  @override
  set value(Iterable<T> newValue) {
    // TODO: implement value
  }

  @override
  void reset() {
    // TODO: implement reset
  }
}
