import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Exceptions tests', () {
    test('FormControlNotFoundException message references the control index',
        () {
      final e = FormControlNotFoundException('0');
      expect(e.toString().contains('control with name: \'0\' not found'), true);
    });

    test('FormArrayInvalidIndexException message references the invalid index ',
        () {
      final e = FormArrayInvalidIndexException('control');
      expect(e.toString().contains('Index \'control\' is not a valid index'),
          true);
    });
  });
}
