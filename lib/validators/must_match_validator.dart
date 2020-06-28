import 'package:reactive_forms/reactive_forms.dart';

class MustMatchValidator {
  final String controlName;
  final String matchingControlName;

  MustMatchValidator(this.controlName, this.matchingControlName);

  Map<String, dynamic> validate(FormGroup form) {
    final control = form.formControl(controlName);
    final matchingControl = form.formControl(matchingControlName);

    if (control.value != matchingControl.value) {
      matchingControl.addError({'mustMatch': true});
    } else {
      matchingControl.removeError('mustMatch');
    }

    return null;
  }
}
