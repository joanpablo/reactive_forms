import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_date_picker_testing_widget.dart';

void main() {
  group('ReactiveDatePicker Tests', () {
    testWidgets('Initial date of picker is default value of control', (
      WidgetTester tester,
    ) async {
      // Given: a form and a date time field with default value
      final defaultValue = DateUtils.dateOnly(
        DateTime.now().subtract(const Duration(days: 1)),
      );

      final form = FormGroup({
        'birthday': FormControl<DateTime>(value: defaultValue),
      });

      // And: a widget bound to the form
      await tester.pumpWidget(
        ReactiveDatePickerTestingWidget<DateTime>(form: form),
      );

      // When: open picker
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // And: get initial date of the date picker
      final datePicker =
          tester.widget(find.byType(CalendarDatePicker)) as CalendarDatePicker;
      final initialDate = datePicker.initialDate;

      // Then: initial date id the default value of the control
      expect(initialDate, form.control('birthday').value);
    });

    testWidgets('Set date in date picker sets value to form control', (
      WidgetTester tester,
    ) async {
      // Given: a form and a date time field with default value
      final defaultValue = DateUtils.dateOnly(
        DateTime.now().subtract(const Duration(days: 1)),
      );
      final form = FormGroup({
        'birthday': FormControl<DateTime>(value: defaultValue),
      });

      // And: a widget bound to the form
      await tester.pumpWidget(
        ReactiveDatePickerTestingWidget<DateTime>(form: form),
      );

      // When: open picker
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // And: select current selected date
      await tester.tap(find.text('OK'));
      await tester.pump();

      // Then: initial date id the default value of the control
      expect(form.control('birthday').value, defaultValue);
    });

    testWidgets(
      'Date picker state returns valid value accessor when control is DateTime',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({'birthday': FormControl<DateTime>()});

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(form: form),
        );

        // And: get initial date of the date picker
        final datePickerState =
            tester.allStates.firstWhere(
                  (state) => state.widget is ReactiveDatePicker,
                )
                as ReactiveFormFieldState;

        // Then: initial date is equals to last Date
        expect(
          datePickerState.valueAccessor,
          isInstanceOf<DefaultValueAccessor<DateTime, DateTime>>(),
        );
      },
    );

    testWidgets(
      'Date picker state returns valid value accessor when control is String',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({'birthday': FormControl<String>()});

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<String>(form: form),
        );

        // And: get initial date of the date picker
        final datePickerState =
            tester.allStates.firstWhere(
                  (state) => state.widget is ReactiveDatePicker,
                )
                as ReactiveFormFieldState;

        // Then: initial date is equals to last Date
        expect(
          datePickerState.valueAccessor,
          isInstanceOf<Iso8601DateTimeValueAccessor>(),
        );
      },
    );

    testWidgets(
      'DatePickerState throws exception when control is not String or DateTime',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({'birthday': FormControl<bool>()});

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<bool>(form: form),
        );

        // Then: initial date is equals to last Date
        expect(tester.takeException(), isInstanceOf<ValueAccessorException>());
      },
    );

    testWidgets(
      'Initial date of picker is DateTime.now() if value of control and initialDate argument are null ',
      (WidgetTester tester) async {
        // Given: a form and with null default value
        final form = FormGroup({'birthday': FormControl<DateTime>()});

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(form: form),
        );

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker =
            tester.widget(find.byType(CalendarDatePicker))
                as CalendarDatePicker;
        final initialDate = datePicker.initialDate;

        // Then: initial date if DateTime.now()
        expect(initialDate, DateUtils.dateOnly(DateTime.now()));
      },
    );

    testWidgets('Initial date of picker is equals to initialDate argument', (
      WidgetTester tester,
    ) async {
      // Given: a form and with null default value
      final form = FormGroup({'birthday': FormControl<DateTime>()});

      // And: a widget bound to the form with initial Date
      final expectedInitialDate = DateUtils.dateOnly(
        DateTime.now().subtract(const Duration(days: 1)),
      );
      await tester.pumpWidget(
        ReactiveDatePickerTestingWidget<DateTime>(
          form: form,
          initialDate: expectedInitialDate,
        ),
      );

      // When: open picker
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // And: get initial date of the date picker
      final datePicker =
          tester.widget(find.byType(CalendarDatePicker)) as CalendarDatePicker;
      final actualInitialDate = datePicker.initialDate;

      // Then: initial date if DateTime.now()
      expect(actualInitialDate, expectedInitialDate);
    });

    testWidgets(
      'The initialDate argument has more priority than control value',
      (WidgetTester tester) async {
        // Given: a form and with null default value
        final controlValue = DateUtils.dateOnly(
          DateTime.now().subtract(const Duration(days: 1)),
        );
        final form = FormGroup({
          'birthday': FormControl<DateTime>(value: controlValue),
        });

        // And: a widget bound to the form with initial Date
        final expectedInitialDate = DateUtils.dateOnly(
          DateTime.now().subtract(const Duration(days: 2)),
        );
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(
            form: form,
            initialDate: expectedInitialDate,
          ),
        );

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker =
            tester.widget(find.byType(CalendarDatePicker))
                as CalendarDatePicker;
        final actualInitialDate = datePicker.initialDate;

        // Then: initial date to widget's argument
        expect(actualInitialDate, expectedInitialDate);
      },
    );

    testWidgets(
      'The initialDate is equal to firstDate if control value before firstDate',
      (WidgetTester tester) async {
        // Given: first date definition
        final firstDate = DateUtils.dateOnly(
          DateTime.now().subtract(const Duration(days: 365)),
        );

        // And: a control with a value before the firstDate value
        final controlValue = DateUtils.dateOnly(
          firstDate.subtract(const Duration(days: 365)),
        );

        final form = FormGroup({
          'birthday': FormControl<DateTime>(value: controlValue),
        });

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(
            form: form,
            firstDate: firstDate,
          ),
        );

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker =
            tester.widget(find.byType(CalendarDatePicker))
                as CalendarDatePicker;
        final actualInitialDate = datePicker.initialDate;

        // Then: initial date is equals to firstDate
        expect(actualInitialDate, firstDate);
      },
    );

    testWidgets(
      'The initialDate is equal to lastDate if control value after lastDate',
      (WidgetTester tester) async {
        // Given: first date definition
        final lastDate = DateUtils.dateOnly(
          DateTime.now().add(const Duration(days: 365)),
        );

        // And: a control with a value before the firstDate value
        final controlValue = DateUtils.dateOnly(
          lastDate.add(const Duration(days: 365)),
        );

        final form = FormGroup({
          'birthday': FormControl<DateTime>(value: controlValue),
        });

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(
            form: form,
            lastDate: lastDate,
          ),
        );

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker =
            tester.widget(find.byType(CalendarDatePicker))
                as CalendarDatePicker;
        final actualInitialDate = datePicker.initialDate;

        // Then: initial date is equals to lastDate
        expect(actualInitialDate, lastDate);
      },
    );

    testWidgets(
      'The initialDate is equal to firstDate if argument before firstDate',
      (WidgetTester tester) async {
        // Given: first date definition
        final firstDate = DateUtils.dateOnly(
          DateTime.now().subtract(const Duration(days: 365)),
        );

        // And: an initialDate before firstDate
        final initialDateArgument = DateUtils.dateOnly(
          firstDate.subtract(const Duration(days: 365)),
        );

        // And: a control with null value
        final form = FormGroup({'birthday': FormControl<DateTime>()});

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(
            form: form,
            firstDate: firstDate,
            initialDate: initialDateArgument,
          ),
        );

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker =
            tester.widget(find.byType(CalendarDatePicker))
                as CalendarDatePicker;
        final actualInitialDate = datePicker.initialDate;

        // Then: initial date is equals to firstDate
        expect(actualInitialDate, firstDate);
      },
    );

    testWidgets(
      'The initialDate is equal to lastDate if argument after lastDate',
      (WidgetTester tester) async {
        // Given: last date definition
        final lastDate = DateUtils.dateOnly(
          DateTime.now().add(const Duration(days: 365)),
        );

        // And: an initialDate after the lastDate
        final initialDateArgument = DateUtils.dateOnly(
          lastDate.add(const Duration(days: 365)),
        );

        // And: a control with null value
        final form = FormGroup({'birthday': FormControl<DateTime>()});

        // And: a widget bound to the form
        await tester.pumpWidget(
          ReactiveDatePickerTestingWidget<DateTime>(
            form: form,
            lastDate: lastDate,
            initialDate: initialDateArgument,
          ),
        );

        // When: open picker
        await tester.tap(find.byType(TextButton));
        await tester.pump();

        // And: get initial date of the date picker
        final datePicker =
            tester.widget(find.byType(CalendarDatePicker))
                as CalendarDatePicker;
        final actualInitialDate = datePicker.initialDate;

        // Then: initial date is equals to lastDate
        expect(actualInitialDate, lastDate);
      },
    );
  });
}
