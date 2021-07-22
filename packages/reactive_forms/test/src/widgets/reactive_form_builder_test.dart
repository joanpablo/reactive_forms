import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_form_builder_testing_widget.dart';

void main() {
  group('ReactiveFormBuilder Tests', () {
    testWidgets(
      'Binding to a form',
      (WidgetTester tester) async {
        // Given: a form definition
        final form = fb.group({
          'name': '',
        });

        // And: a form builder bind to form
        await tester
            .pumpWidget(ReactiveFormBuilderTestingWidget<String>(form: form));

        // When: change input text
        final inputText = 'Hello Reactive Form Builder';
        await tester.enterText(find.byType(TextField), inputText);

        // Then: the form value is updated
        expect(form.value, {'name': inputText});
      },
    );
  });
}
