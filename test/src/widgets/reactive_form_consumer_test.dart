import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_form_consumer_testing_widget.dart';

void main() {
  group('ReactiveFormConsumer Tests', () {
    testWidgets(
      'Submit Button is enabled if form is valid',
      (WidgetTester tester) async {
        // Given: a valid form
        final form = FormGroup({
          'name': FormControl<String>(
            value: 'Reactive Forms',
            validators: [Validators.required],
          ),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormConsumerTestingWidget(form: form));

        // Expect: submit button is enabled
        final submitButton =
            tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(submitButton.enabled, true);
      },
    );

    testWidgets(
      'Submit Button is disabled if form is invalid',
      (WidgetTester tester) async {
        // Given: an invalid form
        final form = FormGroup({
          'name': FormControl<String>(
            validators: [Validators.required],
          ),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormConsumerTestingWidget(form: form));

        // Expect: submit button is disabled
        final submitButton =
            tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(submitButton.enabled, false);
      },
    );

    testWidgets(
      'Submit Button is disabled if a valid form changes status to invalid',
      (WidgetTester tester) async {
        // Given: a valid form
        final form = FormGroup({
          'name': FormControl<String>(
            value: 'Reactive Forms',
            validators: [Validators.required],
          ),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormConsumerTestingWidget(form: form));

        // When: form changes status to invalid
        form.control('name').value = null;
        await tester.pump();

        // Expect: submit button is disabled
        final submitButton =
            tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(submitButton.enabled, false);
      },
    );

    testWidgets(
      'Submit Button is enabled if an invalid form changes status to valid',
      (WidgetTester tester) async {
        // Given: an invalid form
        final form = FormGroup({
          'name': FormControl<String>(
            validators: [Validators.required],
          ),
        });

        // And: a widget bind to the form
        await tester.pumpWidget(ReactiveFormConsumerTestingWidget(form: form));

        // When: form changes status to valid
        form.control('name').value = 'Reactive Forms';
        await tester.pump();

        // Expect: submit button is disabled
        final submitButton =
            tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(submitButton.enabled, true);
      },
    );
  });
}
