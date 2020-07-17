import 'package:reactive_forms/reactive_forms.dart';

/// Utility class for [AbstractControl]
abstract class Control {
  /// Returns true if [control] is null, otherwise return false.
  static bool isNull(AbstractControl control) => control.value == null;

  /// Returns true if [control] is null os empty white spaces,
  /// otherwise return false.
  static bool isNullOrEmpty(AbstractControl<String> control) =>
      isNull(control) || control.value.trim().isEmpty;
}
