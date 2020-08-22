import 'package:reactive_forms/reactive_forms.dart';

/// Represents the default parser for input text fields.
class DefaultInputParser implements InputParser {
  @override
  dynamic parse(String value) {
    return value;
  }
}
