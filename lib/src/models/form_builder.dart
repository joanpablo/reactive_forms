import 'package:reactive_forms/reactive_forms.dart';

class FormBuilder {
  const FormBuilder();

  FormGroup group(Map<String, dynamic> controls) {
    final map = controls.map((key, value) {
      if (value is String) {
        return MapEntry(key, FormControl<String>(defaultValue: value));
      } else if (value is int) {
        return MapEntry(key, FormControl<int>(defaultValue: value));
      } else if (value is bool) {
        return MapEntry(key, FormControl<bool>(defaultValue: value));
      } else if (value is double) {
        return MapEntry(key, FormControl<double>(defaultValue: value));
      } else if (value is AbstractControl) {
        return MapEntry(key, value);
      } else if (value is ValidatorFunction) {
        return MapEntry(key, FormControl(validators: [value]));
      } else if (value is Iterable<ValidatorFunction>) {
        return MapEntry(key, FormControl(validators: value));
      }

      return MapEntry(key, FormControl(defaultValue: value));
    });

    return FormGroup(map);
  }
}

const fb = const FormBuilder();
