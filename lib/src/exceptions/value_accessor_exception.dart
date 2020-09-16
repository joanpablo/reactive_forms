import 'package:reactive_forms/reactive_forms.dart';

/// Exception that raises by [ControlValueAccessor]
class ValueAccessorException implements Exception {
  final String message;

  /// Constructs an instance of the exception with the provided [message].
  ValueAccessorException(this.message);

  @override
  String toString() {
    return 'ValueAccessorException: $message';
  }
}
