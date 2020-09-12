import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's value to be greater than or equal
/// to a provided value.
class MinValidator<Comparable> extends Validator {
  final Comparable min;

  /// Constructs the instance of the validator.
  ///
  /// The argument [min] must not be null.
  MinValidator(this.min) : assert(min != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    return control.value >= min
        ? null
        : {
            'min': {
              'min': min.toString(),
              'actual': control.value.toString(),
            },
          };
  }
}
