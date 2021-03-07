import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_form_array_testing_widget.dart';

void main() {
  group('ReactiveFormArray Tests', () {
    testWidgets(
      'ReactiveFormArray display same amount of items of the array',
      (WidgetTester tester) async {
        // Given: a form with array
        final form = FormGroup({
          'array': FormArray([
            FormControl(),
            FormControl(),
            FormControl(),
          ]),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormArrayTestingWidget(form: form));

        // Expect: display the same amount of items of the array
        Iterable<Text> texts = tester.widgetList(find.byType(Text));
        expect(texts.length, 3);
      },
    );

    testWidgets(
      'ReactiveFormArray rebuild when added control',
      (WidgetTester tester) async {
        // Given: a form with array
        final form = FormGroup({
          'array': FormArray([
            FormControl(),
            FormControl(),
            FormControl(),
          ]),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormArrayTestingWidget(form: form));

        // When: add new control to array
        (form.control('array') as FormArray).add(FormControl());
        await tester.pump();

        // Expect: display the same amount of items of the array
        Iterable<Text> texts = tester.widgetList(find.byType(Text));
        expect(texts.length, 4);
      },
    );

    testWidgets(
      'ReactiveFormArray rebuild when added collection of control',
      (WidgetTester tester) async {
        // Given: a form with array
        final form = FormGroup({
          'array': FormArray([
            FormControl(),
            FormControl(),
            FormControl(),
          ]),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormArrayTestingWidget(form: form));

        // When: add new controls to array
        (form.control('array') as FormArray).addAll([
          FormControl(),
          FormControl(),
        ]);
        await tester.pump();

        // Expect: display the same amount of items of the array
        Iterable<Text> texts = tester.widgetList(find.byType(Text));
        expect(texts.length, 5);
      },
    );

    testWidgets(
      'ReactiveFormArray rebuild when remove control',
      (WidgetTester tester) async {
        // Given: a form with array
        final form = FormGroup({
          'array': FormArray([
            FormControl(),
            FormControl(),
            FormControl(),
          ]),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormArrayTestingWidget(form: form));

        // When: remove a control
        (form.control('array') as FormArray).removeAt(0);
        await tester.pump();

        // Expect: display the same amount of items of the array
        Iterable<Text> texts = tester.widgetList(find.byType(Text));
        expect(texts.length, 2);
      },
    );

    testWidgets(
      'Assert error if formArrayName and formArray is null',
      (WidgetTester tester) async {
        expect(
          () => ReactiveFormArray(
            builder: (context, array, child) => Container(),
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'Assert error if formArrayName and formArray not null',
      (WidgetTester tester) async {
        expect(
          () => ReactiveFormArray(
            formArrayName: 'some',
            formArray: fb.array([1]),
            builder: (context, array, child) => Container(),
          ),
          throwsAssertionError,
        );
      },
    );
  });
}
