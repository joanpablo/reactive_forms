import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/utils/control_utils.dart';

/// This is an extension on [AbstractControl].
///
/// Brings to [AbstractControl] methods like [isNull].
extension ControlExtension on AbstractControl {
  bool get isNull => Control.isNull(this);
}

/// This is an extension on [AbstractControl<String>].
///
/// Brings to [AbstractControl<String>] methods like [isNullOrEmpty]
extension StringControlExtension on AbstractControl<String> {
  bool get isNullOrEmpty => Control.isNullOrEmpty(this);
}
