import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/utils/control_utils.dart';

/// This is an extension on [AbstractControl].
///
/// Brings to [AbstractControl] methods like [isNull].
extension ControlExtension on AbstractControl {
  /// Returns true is the value of the control is null, otherwise returns false.
  bool get isNull => Control.isNull(this);
}

/// This is an extension on [AbstractControl<String>].
///
/// Brings to [AbstractControl<String>] methods like [isNullOrEmpty]
extension StringControlExtension on AbstractControl<String> {
  /// Returns true if the value of the control is null or
  /// an empty white spaces string, otherwise returns false.
  bool get isNullOrEmpty => Control.isNullOrEmpty(this);
}
