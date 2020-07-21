import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_date_picker_testing_widget.dart';

void main() {
  group('ReactiveDatePicker Tests', () {
    testWidgets(
      'Initial date of picker is default value of control',
      (WidgetTester tester) async {
        // Given: a form and a date time field with default value
        final form = FormGroup({
          'birthday': FormControl<DateTime>(
            defaultValue: DateTime(2020),
          ),
        });

        // And: a widget bound to the form
        await tester.pumpWidget(ReactiveDatePickerTestingWidget(form: form));

        // When: open picker
        await tester.tap(find.byType(FlatButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker = tester.widget(find.byType(CalendarDatePicker))
            as CalendarDatePicker;
        final initialDate = datePicker.initialDate;

        // Then: initial date id the default value of the control
        expect(initialDate, form.control('birthday').value);
      },
    );

    testWidgets(
      'Set date in date picker sets value to form control',
      (WidgetTester tester) async {
        // Given: a form and a date time field with default value
        final defaultValue = DateTime(2020);
        final form = FormGroup({
          'birthday': FormControl<DateTime>(
            defaultValue: defaultValue,
          ),
        });

        // And: a widget bound to the form
        await tester.pumpWidget(ReactiveDatePickerTestingWidget(form: form));

        // When: open picker
        await tester.tap(find.byType(FlatButton));
        await tester.pump();

        // And: select current selected date
        await tester.tap(find.text('OK'));
        await tester.pump();

        // Then: initial date id the default value of the control
        expect(form.control('birthday').value, defaultValue);
      },
    );

    testWidgets(
      'Assert Error if builder is null',
      (WidgetTester tester) async {
        // Given: a date picker widget with builder in null
        final datePicker = () => ReactiveDatePicker(
              formControlName: '',
              builder: null,
              firstDate: DateTime.now(),
              lastDate: DateTime.now(),
            );

        // Expect: an assert error
        expect(datePicker, throwsAssertionError);
      },
    );
  });
}
