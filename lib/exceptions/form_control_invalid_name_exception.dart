class FormControlInvalidNameException implements Exception {
  final String name;

  /// Creates an instance of the exception
  FormControlInvalidNameException(this.name);

  @override
  String toString() {
    return 'FormControlInvalidNameException: Child FormControl with name: \'$name\' not found';
  }
}
