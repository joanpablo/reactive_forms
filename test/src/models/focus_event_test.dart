import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('FormEvent tests', () {
    test('Assert error in null arguments', () {
      expect(() => FocusEvent(hasFocus: null, markAsTouched: false),
          throwsAssertionError);
      expect(() => FocusEvent(hasFocus: true, markAsTouched: null),
          throwsAssertionError);
    });
  });
}
