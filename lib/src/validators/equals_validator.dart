import 'package:reactive_forms/reactive_forms.dart';

class EqualsValidator<T> extends Validator {
  final T value;

  EqualsValidator(this.value);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return control.value is T && control.value == this.value
        ? null
        : {'equals': true};
  }
}
