class FormBuilderInvalidInitializationException implements Exception {
  final message;

  FormBuilderInvalidInitializationException(this.message);

  String toString() {
    return "FormBuilderInvalidInitializationException: $message";
  }
}
