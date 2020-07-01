class FormControlNotFoundException implements Exception {
  final String formControlName;

  FormControlNotFoundException(this.formControlName);

  @override
  String toString() {
    return 'FormControlNotFoundException: ReactiveFormField widget couldn\'t bind to FormControl, the name: \'$formControlName\' not found!';
  }
}
