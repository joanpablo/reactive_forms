import 'package:reactive_forms/models/form_control_collection.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormArray<T> extends AbstractControl<Iterable<T>>
    implements FormControlCollection {
  final List<AbstractControl<T>> _controls = [];

  FormArray(Iterable<AbstractControl<T>> controls) : assert(controls != null) {
    _controls.addAll(controls);
  }

  Iterable<AbstractControl<T>> get controls => List.unmodifiable(_controls);

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

  void add(AbstractControl<T> control) {
    this._controls.add(control);
  }

  void addAll(Iterable<AbstractControl<T>> controls) {
    this._controls.addAll(controls);
  }

  @override
  AbstractControl formControl(String name) {
    return _controls[int.parse(name)];
  }
}
