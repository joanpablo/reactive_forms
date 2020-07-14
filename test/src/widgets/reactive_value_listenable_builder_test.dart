import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_value_listenable_builder_testing_widget.dart';

void main() {
  group('ReactiveValueListenableBuilder Tests', () {
    testWidgets(
      'Text widget init with control default values',
      (WidgetTester tester) async {
        // Given: a form and a String field with a default value
        final defaultValue = 'Reactive Forms';
        final form = FormGroup({
          'name': FormControl<String>(defaultValue: defaultValue),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveValueListenableTestingWidget(
            form: form,
          ),
        );

        // When: get text widget
        Text text = tester.widget(find.byType(Text));

        // Then: the text value is equal to control default value
        expect(text.data, defaultValue);
      },
    );

    testWidgets(
      'When control value changes text widget rebuilds with new value',
      (WidgetTester tester) async {
        // Given: a form and a String field
        final form = FormGroup({
          'name': FormControl<String>(),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveValueListenableTestingWidget(
            form: form,
          ),
        );

        //When: set control value
        final control = form.formControl('name');
        control.value = 'Reactive Forms';
        await tester.pump();

        // Then: the text value is equal to control value
        Text text = tester.widget(find.byType(Text));
        expect(text.data, control.value);
      },
    );
  });
}
