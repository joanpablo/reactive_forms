import 'package:reactive_forms/reactive_forms.dart';

typedef AtLeastOneValidatorFunctionTest<T> = bool Function(T value);

class AtLeastOneValidator<T> extends Validator<Iterable<T>> {
  final AtLeastOneValidatorFunctionTest<T> test;

  AtLeastOneValidator(this.test) : assert(test != null);

  @override
  Map<String, dynamic> validate(AbstractControl<Iterable<T>> control) {
    return control.value.any((T value) => this.test(value) ?? false)
        ? null
        : {ValidationMessage.atLeastOne: true};
  }
}
