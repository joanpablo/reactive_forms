import 'package:reactive_forms_core/reactive_forms_core.dart';

/// Represents the [AnyValidator] test function definition.
typedef AnyValidatorFunctionTest<T> = bool Function(T value);

/// Represents a validator that requires any element of the control's iterable
/// value satisfies [test].
class AnyValidator<T> extends Validator<dynamic> {
  final AnyValidatorFunctionTest<T> test;

  /// Constructs an instance of the validator.
  ///
  /// The argument [test] must not be null.
  AnyValidator(this.test);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    if (control.value == null) {
      return <String, dynamic>{ValidationMessage.any: true};
    }

    // TODO: change the assert for an exception
    assert(control.value is Iterable<T>,
        '${control.value.runtimeType.toString()} $T?');

    final iterable = control.value as Iterable<T>;
    return iterable.any(test)
        ? null
        : <String, dynamic>{ValidationMessage.any: true};
  }
}
