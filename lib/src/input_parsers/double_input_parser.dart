import 'package:reactive_forms/reactive_forms.dart';

class DoubleInputParser implements InputParser<double> {
  @override
  double parse(String value) {
    return value == '' ? null : double.tryParse(value);
  }
}
