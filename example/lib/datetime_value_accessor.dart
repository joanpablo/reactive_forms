import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DateTimeValueAccessor extends ControlValueAccessor<DateTime, String> {
  final DateFormat format;

  DateTimeValueAccessor({this.format});

  @override
  String modelToViewValue(DateTime modelValue) {
    print('model value is');
    print(modelValue);
    final format = this.format ?? DateFormat.yMMMd();
    return format.format(modelValue);
  }

  @override
  DateTime viewToModelValue(String viewValue) {
    print('viewValue is');
    print(viewValue);
    final format = this.format ?? DateFormat.yMMMd();
    return format.parse(viewValue);
  }
}
