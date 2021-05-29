import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that convert int to double data types
class SliderIntValueAccessor extends ControlValueAccessor<int, double> {
  @override
  double? modelToViewValue(int? modelValue) {
    return modelValue?.toDouble();
  }

  @override
  int? viewToModelValue(double? viewValue) {
    return viewValue?.toInt();
  }
}
