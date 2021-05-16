import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that converts from Unix/Epoch timestamp value
/// to a [DateTime] data type.
///
/// This control value accessor is used by [ReactiveDatePicker] when the model
/// control is of type [int] or [double].
class UnixDateTimeValueAccessor<T> extends ControlValueAccessor<T, DateTime> {
  @override
  DateTime? modelToViewValue(T? modelValue) {
    if (modelValue == null) {
      return null;
    }
    if (modelValue is int) {
      return DateTime.fromMillisecondsSinceEpoch(modelValue, isUtc: true);
    } else if (modelValue is double) {
      return DateTime.fromMillisecondsSinceEpoch(modelValue.toInt(),
          isUtc: true);
    }
    throw ValueAccessorException(
        'UnixDateTimeValueAccessor supports only int or double values');
  }

  @override
  T? viewToModelValue(DateTime? viewValue) {
    return viewValue is DateTime
        ? viewValue.toUtc().millisecondsSinceEpoch as T
        : null;
  }
}
