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
          'radio': FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveRadioTestingWidget(form: form),
        );

        // Expect radio group value is true
        Type radioType = Radio<bool>(
          value: true,
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
          'radio': FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // Expect radio group value is false
        Type radioType = Radio<bool>(
          value: false,
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
          'radio': FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: changes control to true
        form.control('radio').value = true;
        await tester.pump();

        // Expect radio group value is true
        Type radioType = Radio<bool>(
          value: true,
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
          'radio': FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: changes control to false
        form.control('radio').value = false;
        await tester.pump();

        // Expect radio group value is true
        Type radioType = Radio<bool>(
          value: true,
          groupValue: null,
          onChanged: null,
        ).runtimeType;

        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;

        expect(radio.groupValue, false);
      },
    );

    testWidgets(
      'Control disabled by default disable Radio',
      (WidgetTester tester) async {
        // Given: a form with and a control with default true
        final form = FormGroup({
          'radio': FormControl<bool>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // Then: the radio is disabled
        Type radioType = Radio<bool>(
          value: true,
          groupValue: null,
          onChanged: null,
        ).runtimeType;
        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;
        expect(radio.onChanged, null);
      },
    );

    testWidgets(
      'Disable a control disable Radio',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'radio': FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the radio is disabled
        Type radioType = Radio<bool>(
          value: true,
          groupValue: null,
          onChanged: null,
        ).runtimeType;
        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;
        expect(radio.onChanged, null);
      },
    );

    testWidgets(
      'Enable a control enable Radio',
      (WidgetTester tester) async {
        // Given: a form with disabled
        final form = FormGroup({
          'radio': FormControl<bool>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the radio is enabled
        Type radioType = Radio<bool>(
          value: true,
          groupValue: null,
          onChanged: null,
        ).runtimeType;
        Radio<bool> radio =
            tester.firstWidget(find.byType(radioType)) as Radio<bool>;
        expect(radio.onChanged != null, true);
      },
    );
  });
}
