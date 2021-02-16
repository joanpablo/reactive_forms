import 'package:reactive_forms/reactive_forms.dart';

/// Utility class for [AbstractControl]
abstract class Control {
  /// Returns true if [control] is null, otherwise return false.
  static bool isNull(AbstractControl? control) => control?.value;

  /// Returns true if [control] is not null, otherwise return false.
  static bool isNotNull(AbstractControl? control) => control?.value != null;

  /// Returns true if [control] is null or empty white spaces,
  /// otherwise return false.
  static bool isNullOrEmpty(AbstractControl<String>? control) =>
      isNull(control) || control?.value?.trim().isEmpty == true;

  /// Returns true if [control] is not null and not empty white spaces,
  /// otherwise return false.
  static bool isNotNullOrEmpty(AbstractControl<String>? control) =>
      isNotNull(control) && control?.value?.trim().isNotEmpty == true;
}
