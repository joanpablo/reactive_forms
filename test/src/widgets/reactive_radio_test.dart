import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_radio_testing_widget.dart';

void main() {
  group('ReactiveRadio Tests', () {
    testWidgets(
      'Radio init with true if control init in true',
      (WidgetTester tester) async {
        // Given: a form with and a control with default true
        final form = FormGroup({
          'radio': FormControl<bool>(defaultValue: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveRadioTestingWidget(form: form),
        );

        // Expect radio group value is true
        Type radioType = Radio<bool>(
          value: null,
          groupValue: null,
          onChanged: null,
        ).runtimeType;

        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;

        expect(radio.groupValue, true);
      },
    );

    testWidgets(
      'Radio init with false if control init in false',
      (WidgetTester tester) async {
        // Given: a form with and a control with default false
        final form = FormGroup({
          'radio': FormControl<bool>(defaultValue: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // Expect radio group value is false
        Type radioType = Radio<bool>(
          value: null,
          groupValue: null,
          onChanged: null,
        ).runtimeType;

        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;

        expect(radio.groupValue, false);
      },
    );

    testWidgets(
      'Radio changes value to true when control value changes to true',
      (WidgetTester tester) async {
        // Given: a form with and a control with default false
        final form = FormGroup({
          'radio': FormControl<bool>(defaultValue: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: changes control to true
        form.formControl('radio').value = true;
        await tester.pump();

        // Expect radio group value is true
        Type radioType = Radio<bool>(
          value: null,
          groupValue: null,
          onChanged: null,
        ).runtimeType;

        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;

        expect(radio.groupValue, true);
      },
    );

    testWidgets(
      'Radio changes value to false when control value changes to false',
      (WidgetTester tester) async {
        // Given: a form with and a control with default true
        final form = FormGroup({
          'radio': FormControl<bool>(defaultValue: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: changes control to false
        form.formControl('radio').value = false;
        await tester.pump();

        // Expect radio group value is true
        Type radioType = Radio<bool>(
          value: null,
          groupValue: null,
          onChanged: null,
        ).runtimeType;

        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;

        expect(radio.groupValue, false);
      },
    );
  });
}
