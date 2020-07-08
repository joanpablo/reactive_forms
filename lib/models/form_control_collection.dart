import 'package:reactive_forms/reactive_forms.dart';

abstract class FormControlCollection {
  AbstractControl formControl(String name);
}
