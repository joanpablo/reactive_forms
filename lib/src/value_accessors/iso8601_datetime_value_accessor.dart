import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that converts from Iso8601 string value
/// to a [DateTime] data type.
///
/// This control value accessor is used by [ReactiveDatePicker] when the model
/// control is of type [String].
class Iso8601DateTimeValueAccessor
    extends ControlValueAccessor<String, DateTime> {
  @override
  DateTime? modelToViewValue(String? modelValue) {
    return modelValue == null || modelValue.trim().isEmpty
        ? null
        : DateTime.parse(modelValue);
  }

  @override
  String? viewToModelValue(DateTime? viewValue) {
    return viewValue == null ? null : viewValue.toIso8601String();
  }
}
