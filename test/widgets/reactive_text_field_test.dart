import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_testing_widget.dart';

void main() {
  group('ReactiveTextField Tests', () {
    testWidgets(
      'When FormControl value changes text field updates value',
      (WidgetTester tester) async {
        // Given: A group with an empty field 'name' is created
        final form = FormGroup({
          'name': FormControl(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTestingWidget(form: form));

        // Expect: that the text field has no value when painted
        expect(find.text('John'), findsNothing);

        // When: set a value to field 'name'
        form.formControl('name').value = 'John';
        await tester.pump();

        // Then: the reactive text field updates its value with the new name
        expect(find.text('John'), findsOneWidget);
      },
    );

    testWidgets(
      'Call FormControl.focus() request focus on text field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          'name': FormControl(defaultValue: 'John'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTestingWidget(form: form));

        // Expect: that the text field has no focus
        TextField textField = tester.firstWidget(find.byType(TextField));
        expect(textField.focusNode.hasFocus, false);

        // When: call FormControl.focus()
        (form.formControl('name') as FormControl).focus();
        await tester.pump();

        // Then: the reactive text field is focused
        textField = tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.focusNode.hasFocus, true);
      },
    );

    testWidgets(
      'Call FormControl.unfocus() remove focus on text field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          'name': FormControl(defaultValue: 'John'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTestingWidget(form: form));

        // And: the text field has focused
        TextField textField = tester.firstWidget(find.byType(TextField));
        textField.focusNode.requestFocus();

        // When: call FormControl.unfocus()
        (form.formControl('name') as FormControl).unfocus();

        // Then: the reactive text field is unfocused
        textField = tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.focusNode.hasFocus, false);
      },
    );

    testWidgets(
      'Assertion Error if passing null as formControlName',
      (WidgetTester tester) async {
        expect(() => ReactiveTextField(formControlName: null),
            throwsAssertionError);
      },
    );

    testWidgets(
      'Errors not visible if FormControl untouched even when FormControl invalid',
      (WidgetTester tester) async {
        // Given: A group with a required field
        final form = FormGroup({
          'name': FormControl(validators: [Validators.required]),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTestingWidget(form: form));

        // And: the field is invalid and untouched
        expect(form.formControl('name').hasErrors, true);
        expect(form.formControl('name').touched, false);

        // Expect: text field is not showing errors
        final textField =
            tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.decoration.errorText, null);
      },
    );

    testWidgets('Errors visible when FormControl touched',
        (WidgetTester tester) async {
      // Given: A group with a required and touched field
      final form = FormGroup({
        'name': FormControl(
          validators: [Validators.required],
          touched: true,
        ),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveTestingWidget(form: form));

      // Expect: text field is showing errors
      final textField = tester.firstWidget(find.byType(TextField)) as TextField;
      expect(textField.decoration.errorText, ValidationMessage.required);
    });

    testWidgets(
      'Custom Validation Error is visible if supplied',
      (WidgetTester tester) async {
        // Given: A group with a required and touched field
        final form = FormGroup({
          'name': FormControl(
            validators: [Validators.required],
            touched: true,
          ),
        });

        // And: a custom required message
        final customMessage = 'The name is required';

        // And: a widget that is bind to the form with the custom message
        await tester.pumpWidget(ReactiveTestingWidget(
          form: form,
          validationMessages: {ValidationMessage.required: customMessage},
        ));

        // Expect: text field is showing the custom message as error
        final textField =
            tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.decoration.errorText, customMessage);
      },
    );

    testWidgets(
      'FormControlParentNotFoundException when no parent widget',
      (WidgetTester tester) async {
        FlutterError.onError = (errorDetails) {
          expect(errorDetails.exception,
              isInstanceOf<FormControlParentNotFoundException>());
        };

        // Expect: error when create text field without parent widget
        await tester.pumpWidget(ReactiveTextField(formControlName: 'name'));
      },
    );
  });
}
