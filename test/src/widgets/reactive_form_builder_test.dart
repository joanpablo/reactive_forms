import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_form_builder_testing_widget.dart';

void main() {
  group('ReactiveFormBuilder Tests', () {
    testWidgets(
      'Assert Error if form is null',
      (WidgetTester tester) async {
        expect(
          () => ReactiveFormBuilder(
            form: null,
            builder: (context, form, child) => Container(),
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'Assert Error if builder is null',
      (WidgetTester tester) async {
        expect(
          () => ReactiveFormBuilder(
            form: (context) => fb.group({}),
            builder: null,
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'Binding to a form',
      (WidgetTester tester) async {
        // Given: a form definition
        final form = fb.group({
          'name': '',
        });

        // And: a form builder bind to form
        await tester.pumpWidget(ReactiveFormBuilderTestingWidget(form: form));

        // When: change input text
        final inputText = 'Hello Reactive Form Builder';
        await tester.enterText(find.byType(TextField), inputText);

        // Then: the form value is updated
        expect(form.value, {'name': inputText});
      },
    );
  });
}
