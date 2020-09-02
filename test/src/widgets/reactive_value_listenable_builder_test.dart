import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_value_listenable_builder_testing_widget.dart';

void main() {
  group('ReactiveValueListenableBuilder Tests', () {
    testWidgets(
      'Text widget init with control default value',
      (WidgetTester tester) async {
        // Given: a form and a String field with a default value
        final defaultValue = 'Reactive Forms';
        final form = FormGroup({
          'name': FormControl<String>(value: defaultValue),
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
        final control = form.control('name');
        control.value = 'Reactive Forms';
        await tester.pump();

        // Then: the text value is equal to control value
        Text text = tester.widget(find.byType(Text));
        expect(text.data, control.value);
      },
    );

    testWidgets(
      'Assert error thrown if formControlName is null',
      (WidgetTester tester) async {
        // Given: a ReactiveValueListenableBuilder with null formControlName
        final reactiveWidget = () => ReactiveValueListenableBuilder(
              formControlName: null,
              builder: (context, control, child) {
                return null;
              },
            );

        // Expect assertion error
        expect(reactiveWidget, throwsAssertionError);
      },
    );

    testWidgets(
      'Assert error thrown if builder is null',
      (WidgetTester tester) async {
        // Given: a ReactiveValueListenableBuilder with null builder
        final reactiveWidget = () => ReactiveValueListenableBuilder(
              formControlName: 'someName',
              builder: null,
            );

        // Expect assertion error
        expect(reactiveWidget, throwsAssertionError);
      },
    );
  });
}
