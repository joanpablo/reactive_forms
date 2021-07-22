import 'package:reactive_forms_core/src/exceptions/reactive_forms_exception.dart';

/// Represents an exception thrown by a validator
class ValidatorException extends ReactiveFormsException {
  final String message;

  /// Constructs an instance of the exception with the provided [message].
  ValidatorException(this.message);

  @override
  String toString() {
    return 'ValidatorException: $message';
  }
}
