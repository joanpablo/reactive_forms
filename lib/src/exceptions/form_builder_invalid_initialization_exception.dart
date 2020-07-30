/// This exception is thrown by [FormBuilder] when trying to create
/// controls with bad initialization params.
class FormBuilderInvalidInitializationException implements Exception {
  final message;

  /// Create an instance of the exception with the specified [message]
  FormBuilderInvalidInitializationException(this.message);

  /// Returns the string representation of the exception.
  String toString() {
    return "FormBuilderInvalidInitializationException: $message";
  }
}
