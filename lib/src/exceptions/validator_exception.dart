import 'package:reactive_forms/reactive_forms.dart';

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
