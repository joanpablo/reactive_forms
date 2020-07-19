import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/utils/control_utils.dart';

/// This is an extension on [AbstractControl].
///
/// Brings to [AbstractControl] methods like [isNull] and [isNotNull].
extension ControlExtension on AbstractControl {
  /// Returns true is the value of the control is null, otherwise returns false.
  bool get isNull => Control.isNull(this);

  /// Returns true is the value of the control is not null,
  /// otherwise returns false.
  bool get isNotNull => Control.isNotNull(this);
}

/// This is an extension on [AbstractControl<String>].
///
/// Brings to [AbstractControl<String>] methods like
/// [isNullOrEmpty] and [isNotNullOrEmpty].
extension StringControlExtension on AbstractControl<String> {
  /// Returns true if the value of the control is null or
  /// an empty white spaces string, otherwise returns false.
  bool get isNullOrEmpty => Control.isNullOrEmpty(this);

  /// Returns true if the value of the control is not null and
  /// is not an empty white spaces string, otherwise returns false.
  bool get isNotNullOrEmpty => Control.isNotNullOrEmpty(this);
}
