class FormArrayInvalidIndexException implements Exception {
  final String index;

  /// Creates an instance of the exception
  FormArrayInvalidIndexException(this.index);

  @override
  String toString() {
    return 'FormArrayInvalidIndexException: Index \'$index\' is not a valid index for FormArray';
  }
}
