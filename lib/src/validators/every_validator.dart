import 'package:reactive_forms/reactive_forms.dart';

typedef EveryValidatorFunctionTest<T> = bool Function(T value);

class EveryValidator<T> extends Validator<Iterable<T>> {
  final EveryValidatorFunctionTest<T> test;

  EveryValidator(this.test) : assert(test != null);

  @override
  Map<String, dynamic> validate(AbstractControl<Iterable<T>> control) {
    return control.value.every(this.test)
        ? null
        : {ValidationMessage.every: true};
  }
}
