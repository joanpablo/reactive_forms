import 'package:reactive_forms/reactive_forms.dart';

typedef AnyValidatorFunctionTest<T> = bool Function(T value);

class AnyValidator<T> extends Validator<Iterable<T>> {
  final AnyValidatorFunctionTest<T> test;

  AnyValidator(this.test) : assert(test != null);

  @override
  Map<String, dynamic> validate(AbstractControl<Iterable<T>> control) {
    return control.value.any((T value) => this.test(value) ?? false)
        ? null
        : {ValidationMessage.any: true};
  }
}
