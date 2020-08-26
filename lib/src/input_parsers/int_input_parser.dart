import 'package:reactive_forms/reactive_forms.dart';

/// Represents a parser that transforms [String] values in to [int] values.
class IntInputParser implements InputParser<int> {
  @override
  int parse(String value) {
    return value == '' ? null : int.tryParse(value);
  }
}
