import 'package:reactive_forms/reactive_forms.dart';

/// Represents the [AnyValidator] test function definition.
typedef AnyValidatorFunctionTest<T> = bool Function(T? value);

/// Represents a validator that requires any element of the control's iterable
/// value satisfies [test].
class AnyValidator<T> extends Validator<Iterable<T>> {
  final AnyValidatorFunctionTest<T> test;

  /// Constructs an instance of the validator.
  ///
  /// The argument [test] must not be null.
  AnyValidator(this.test);

  @override
  Map<String, dynamic>? validate(AbstractControl<Iterable<T>> control) {
    return control.value?.any((T value) => this.test(value)) == true
        ? null
        : {ValidationMessage.any: true};
  }
}
