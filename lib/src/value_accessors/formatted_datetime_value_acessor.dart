import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that converts from a user formatted
/// date string value to a [DateTime] data type.
///
/// This control value accessor is used by [ReactiveDatePicker] when the model
/// control is of type [String] AND [format] is provided.
class FormattedDateTimeValueAccessor
    extends ControlValueAccessor<String, DateTime> {

  FormattedDateTimeValueAccessor(this.format);

  final DateFormat format;
  
  @override
  DateTime modelToViewValue(String modelValue) {
    return modelValue == null || modelValue.trim().isEmpty
        ? null
        : format.parseLoose(modelValue);
  }

  @override
  String viewToModelValue(DateTime viewValue) {
    return viewValue == null ? null : format.format(viewValue);
  }
}
