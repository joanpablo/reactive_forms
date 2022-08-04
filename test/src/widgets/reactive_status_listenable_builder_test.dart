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
        final text = tester.widget<Text>(find.byType(Text));

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
        final text = tester.widget<Text>(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'valid');
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
        form.control('control').value = 'som valid value';
        await tester.pump();

        // When: get text widget
        final text = tester.widget<Text>(find.byType(Text));

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
            value: 'some valid value',
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
        form.control('control').value = null;
        await tester.pump();

        // When: get text widget
        final text = tester.widget<Text>(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'invalid');
      },
    );

    testWidgets(
      'Assert error thrown if formControlName is null',
      (WidgetTester tester) async {
        // Given: a ReactiveValueListenableBuilder with null formControlName
        void reactiveWidget() => ReactiveStatusListenableBuilder(
              formControlName: null,
              builder: (context, control, child) => Container(),
            );

        // Expect assertion error
        expect(reactiveWidget, throwsAssertionError);
      },
    );

    Future<Map<String, dynamic>?> failedAsyncValidator(
        AbstractControl<dynamic> control) async {
      return <String, dynamic>{'failed': true};
    }

    testWidgets(
      'Async Validator change status to invalid',
      (WidgetTester tester) async {
        // Given: a form with a field and async validator
        final form = FormGroup({
          'control': FormControl<String>(
            validators: [Validators.required],
            asyncValidators: [failedAsyncValidator],
            asyncValidatorsDebounceTime: 0,
          ),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(form: form),
        );

        // When: change status of control
        form.control('control').value = 'some value';
        await tester.pumpAndSettle();

        // When: get text widget
        final text = tester.widget<Text>(find.byType(Text));

        // Then: the text is displaying status invalid
        expect(text.data, 'invalid');
      },
    );

    Future<Map<String, dynamic>?> asyncValidator(
        AbstractControl<dynamic> control) async {
      return Future.value(null);
    }

    testWidgets(
      'Async Validator change status to valid',
      (WidgetTester tester) async {
        // Given: a form with a field and async validator
        final form = FormGroup({
          'control': FormControl<String>(
            validators: [Validators.required],
            asyncValidators: [asyncValidator],
            asyncValidatorsDebounceTime: 0,
          ),
        });

        // And: a widget is bind to the form
        await tester.pumpWidget(
          ReactiveStatusListenableTestingWidget(form: form),
        );

        // When: change status of control
        form.control('control').value = 'some value';
        await tester.pumpAndSettle();

        // When: get text widget
        final text = tester.widget<Text>(find.byType(Text));

        // Then: the text is displaying status valid
        expect(text.data, 'valid');
      },
    );

    testWidgets(
      'Assert error if formControlName and formControl null',
      (WidgetTester tester) async {
        // Given: the widget null values
        void statusListenable() => ReactiveStatusListenableBuilder(
              formControl: null,
              formControlName: null,
              builder: (context, form, child) => Container(),
            );

        // Expect: assert error
        expect(statusListenable, throwsAssertionError);
      },
    );
  });
}
