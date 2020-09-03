import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_time_picker_testing_widget.dart';

void main() {
  group('ReactiveTimePicker Tests', () {
    testWidgets(
      'Selected time of picker is default value of control',
      (WidgetTester tester) async {
        // Given: a form and a date time field with default value
        final defaultValue = TimeOfDay.now();
        final form = FormGroup({
          'time': FormControl<TimeOfDay>(
            value: defaultValue,
          ),
        });

        // And: a widget bound to the form
        await tester.pumpWidget(ReactiveTimePickerTestingWidget(form: form));

        // When: open picker
        await tester.tap(find.byType(FlatButton));
        await tester.pump();

        // And: get initial date of the date picker
        await tester.tap(find.text('OK'));
        await tester.pump();

        // Then: initial date id the default value of the control
        expect(form.control('time').value, defaultValue);
      },
    );

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
