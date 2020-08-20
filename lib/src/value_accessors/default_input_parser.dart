import 'package:reactive_forms/reactive_forms.dart';

class DefaultInputParser implements InputParser {
  @override
  dynamic parse(String value) {
    return value;
  }
}
