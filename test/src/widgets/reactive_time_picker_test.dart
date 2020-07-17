import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('ReactiveTimePicker Tests', () {
    testWidgets(
      'Assert Error if builder is null',
      (WidgetTester tester) async {
        // Given: a time picker widget with builder in null
        final timePicker = () => ReactiveTimePicker(
              formControlName: '',
              builder: null,
            );

        // Expect: an assert error
        expect(timePicker, throwsAssertionError);
      },
    );
  });
}
