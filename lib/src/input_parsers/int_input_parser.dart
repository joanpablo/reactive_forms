import 'package:reactive_forms/reactive_forms.dart';

class IntInputParser implements InputParser<int> {
  @override
  int parse(String value) {
    return value == '' ? null : int.tryParse(value);
  }
}
