import 'package:reactive_forms/reactive_forms.dart';

/// Represents a parser that transforms [String] values in to [double] values.
class DoubleInputParser implements InputParser<double> {
  @override
  double parse(String value) {
    return value == '' ? null : double.tryParse(value);
  }
}
