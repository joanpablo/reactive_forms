import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('ReactiveFormField Tests', () {
    testWidgets(
      'Assert Error if formControlName is null',
      (WidgetTester tester) async {
        // Given: a ReactiveFormField with formControlName in null
        final reactiveFormField = () => ReactiveFormField(
              formControlName: null,
              builder: (_) => null,
            );

        // Expect: an assertion error
        expect(reactiveFormField, throwsAssertionError);
      },
    );

    testWidgets(
      'Assert Error if builder is null',
      (WidgetTester tester) async {
        // Given: a ReactiveFormField with builder in null
        final reactiveFormField = () => ReactiveFormField(
              formControlName: 'someName',
              builder: null,
            );

        // Expect: an assertion error
        expect(reactiveFormField, throwsAssertionError);
      },
    );
  });
}
