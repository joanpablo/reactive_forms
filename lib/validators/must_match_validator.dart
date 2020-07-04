import 'package:reactive_forms/models/abstract_control.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MustMatchValidator extends Validator {
  final String controlName;
  final String matchingControlName;

  MustMatchValidator(this.controlName, this.matchingControlName);

  Map<String, dynamic> validate(AbstractControl control) {
    final form = control as FormGroup;
    if (form == null) {
      return {'mustMatch': true};
    }

    final formControl = form.formControl(controlName);
    final matchingFormControl = form.formControl(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.addError({'mustMatch': true});
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  }
}
