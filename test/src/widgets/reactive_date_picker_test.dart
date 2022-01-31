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
        final defaultValue = DateUtils.dateOnly(
            DateTime.now().subtract(const Duration(days: 1)));

        final form = FormGroup({
          'birthday': FormControl<DateTime>(
            value: defaultValue,
          ),
        });

        // And: a widget bound to the form
        await tester
            .pumpWidget(ReactiveDatePickerTestingWidget<DateTime>(form: form));

        // When: open picker
        await tester.tap(find.byType(TextButton));
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
        final defaultValue = DateUtils.dateOnly(
            DateTime.now().subtract(const Duration(days: 1)));
        final form = FormGroup({
          'birthday': FormControl<DateTime>(
            value: defaultValue,
          ),
        });

        // And: a widget bound to the form
        await tester
            .pumpWidget(ReactiveDatePickerTestingWidget<DateTime>(form: form));

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: select current selected date
        await tester.tap(find.text('OK'));
        await tester.pump();

        // Then: initial date id the default value of the control
        expect(form.control('birthday').value, defaultValue);
      },
    );

    testWidgets(
      'Date picker state returns valid value accessor when control is DateTime',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({
          'birthday': FormControl<DateTime>(),
        });

        // And: a widget bound to the form
        await tester
            .pumpWidget(ReactiveDatePickerTestingWidget<DateTime>(form: form));

        // And: get initial date of the date picker
        final datePickerState = tester.allStates
                .firstWhere((state) => state.widget is ReactiveDatePicker)
            as ReactiveFormFieldState;

        // Then: initial date is equals to last Date
        expect(datePickerState.valueAccessor,
            isInstanceOf<DefaultValueAccessor<DateTime, DateTime>>());
      },
    );

    testWidgets(
      'Date picker state returns valid value accessor when control is String',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({
          'birthday': FormControl<String>(),
        });

        // And: a widget bound to the form
        await tester
            .pumpWidget(ReactiveDatePickerTestingWidget<String>(form: form));

        // And: get initial date of the date picker
        final datePickerState = tester.allStates
                .firstWhere((state) => state.widget is ReactiveDatePicker)
            as ReactiveFormFieldState;

        // Then: initial date is equals to last Date
        expect(datePickerState.valueAccessor,
            isInstanceOf<Iso8601DateTimeValueAccessor>());
      },
    );

    testWidgets(
      'DatePickerState throws exception when control is not String or DateTime',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({
          'birthday': FormControl<bool>(),
        });

        // And: a widget bound to the form
        await tester
            .pumpWidget(ReactiveDatePickerTestingWidget<bool>(form: form));

        // Then: initial date is equals to last Date
        expect(tester.takeException(), isInstanceOf<ValueAccessorException>());
      },
    );
  });
}
