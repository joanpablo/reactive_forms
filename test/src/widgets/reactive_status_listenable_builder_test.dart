import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_status_listenable_builder_testing_widget.dart';

void main() {
  group('ReactiveStatusListenableBuilder Tests', () {
    testWidgets(
      'Text widget display invalid if control init invalid',
      (WidgetTester tester) async {
        // Given: a form with an invalid field
        final form = FormGroup({
          'control': FormControl<String>(validators: [Validators.required]),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(
            form: form,
          ),
        );

        // When: get text widget
        Text text = tester.widget(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'invalid');
      },
    );

    testWidgets(
      'Text widget display valid if control init valid',
      (WidgetTester tester) async {
        // Given: a form with a valid field
        final form = FormGroup({
          'control': FormControl<String>(),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(
            form: form,
          ),
        );

        // When: get text widget
        Text text = tester.widget(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'valid');
      },
    );

    testWidgets(
      'Text widget display pending if control change status to pending',
      (WidgetTester tester) async {
        // Given: a form with a valid field
        final form = FormGroup({
          'control': FormControl<String>(
            defaultValue: 'some valid value',
            validators: [Validators.required],
          ),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(
            form: form,
          ),
        );

        // When: change status of control to pending
        form.formControl('control').notifyStatusChanged(ControlStatus.pending);
        await tester.pump();

        // When: get text widget
        Text text = tester.widget(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'pending');
      },
    );

    testWidgets(
      'Text widget display valid if control change status to valid',
      (WidgetTester tester) async {
        // Given: a form with an invalid field
        final form = FormGroup({
          'control': FormControl<String>(validators: [Validators.required]),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(
            form: form,
          ),
        );

        // When: change status of control to valid
        form.formControl('control').value = 'som valid value';
        await tester.pump();

        // When: get text widget
        Text text = tester.widget(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'valid');
      },
    );

    testWidgets(
      'Text widget display invalid if control change status to invalid',
      (WidgetTester tester) async {
        // Given: a form with a valid field
        final form = FormGroup({
          'control': FormControl<String>(
            defaultValue: 'some valid value',
            validators: [Validators.required],
          ),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(
            form: form,
          ),
        );

        // When: change status of control to invalid
        form.formControl('control').value = null;
        await tester.pump();

        // When: get text widget
        Text text = tester.widget(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'invalid');
      },
    );
  });
}
