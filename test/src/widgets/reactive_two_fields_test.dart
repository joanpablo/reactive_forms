import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_two_fields_testing_widget.dart';

void main() {
  group('ReactiveTwoFields Tests', () {
    testWidgets(
      'Reload the control when the widget has been updated',
          (WidgetTester tester) async {
            // Given: A group with two fields
        final form = FormGroup({
          'name1': FormControl<String>(value: '1'),
          'name2': FormControl<String>(value: '2'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTwoFieldTestingWidget(form: form));

        final testWidgetState = tester
            .firstState<ReactiveTwoFieldTestingWidgetState>(find.byType(ReactiveTwoFieldTestingWidget));
        // Hide field1 and show field2
        testWidgetState.switchField();
        await tester.pump();

        final fieldState = tester
            .firstState<ReactiveFormFieldState<String, String>>(find.byType(ReactiveTextField<String>));
        expect('2', fieldState.control.value);
      },
    );
  });
}
