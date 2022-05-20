import 'package:reactive_forms/reactive_forms.dart';

class ControlCastException<E> extends ReactiveFormsException {
  final AbstractControl<dynamic> control;

  ControlCastException(this.control);

  @override
  String toString() {
    return 'ChildControlCastException: Tried to cast control of type "${control.runtimeType}" as "$E"';
  }
}
