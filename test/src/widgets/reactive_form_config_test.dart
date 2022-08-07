import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('ReactiveFormConfig Tests', () {
    testWidgets('Show local validation message', (WidgetTester tester) async {
      // Given: an invalid form with a required field
      final form = FormGroup({
        'requiredField': FormControl<String>(
          validators: [Validators.required],
        ),
      });

      // And: a global and widget level definition for required validation
      // message
      final expectedErrorText = 'Field is mandatory';
      final widget = ReactiveFormConfig(
        validationMessages: {ValidationMessage.required: (_) => 'required'},
        child: MaterialApp(
          home: Material(
            child: ReactiveForm(
              formGroup: form,
              child: ReactiveTextField<String>(
                formControlName: 'requiredField',
                showErrors: (_) => true,
                validationMessages: {
                  ValidationMessage.required: (_) => expectedErrorText,
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // When: get error message of text field
      final textField = tester.firstWidget<TextField>(find.byType(TextField));
      final actualErrorText = textField.decoration?.errorText;

      // Then: the error text is equals to the local defined error text
      expect(
        actualErrorText,
        expectedErrorText,
        reason: 'The error text is not equals to the local validation message',
      );
    });

    testWidgets('Show global validation message', (WidgetTester tester) async {
      // Given: an invalid form with a required field
      final form = FormGroup({
        'requiredField': FormControl<String>(
          validators: [Validators.required],
        ),
      });

      // And: a global definition for required validation message
      final expectedErrorText = 'Field is mandatory';
      final widget = ReactiveFormConfig(
        validationMessages: {
          ValidationMessage.required: (_) => expectedErrorText,
        },
        child: MaterialApp(
          home: Material(
            child: ReactiveForm(
              formGroup: form,
              child: ReactiveTextField<String>(
                formControlName: 'requiredField',
                showErrors: (_) => true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // When: get error message of text field
      final textField = tester.firstWidget<TextField>(find.byType(TextField));
      final actualErrorText = textField.decoration?.errorText;

      // Then: the error text is equals to the global defined error text
      expect(
        actualErrorText,
        expectedErrorText,
        reason: 'The error text is not equals to the global validation message',
      );
    });

    testWidgets('No local either global validation messages',
        (WidgetTester tester) async {
      // Given: an invalid form with a required field
      final form = FormGroup({
        'requiredField': FormControl<String>(
          validators: [Validators.required],
        ),
      });

      // And: a global and widget level definition for another error different
      // from required validation message
      final widget = ReactiveFormConfig(
        validationMessages: {
          ValidationMessage.minLength: (_) => ValidationMessage.minLength,
        },
        child: MaterialApp(
          home: Material(
            child: ReactiveForm(
              formGroup: form,
              child: ReactiveTextField<String>(
                formControlName: 'requiredField',
                showErrors: (_) => true,
                validationMessages: {
                  ValidationMessage.maxLength: (_) =>
                      ValidationMessage.maxLength,
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // When: get error message of text field
      final textField = tester.firstWidget<TextField>(find.byType(TextField));
      final actualErrorText = textField.decoration?.errorText;

      // Then: the error text is equals to the default required
      // validation message
      expect(
        actualErrorText,
        ValidationMessage.required,
        reason: 'The error text is not equals to ValidationMessage.required',
      );
    });

    testWidgets('Config should notify update', (WidgetTester tester) async {
      // Given: an old ReactiveFormConfig.
      final oldConfig = ReactiveFormConfig(
        validationMessages: {},
        child: Container(),
      );

      // And: a new ReactiveFormConfig.
      final newConfig = ReactiveFormConfig(
        validationMessages: {},
        child: Container(),
      );

      // Expect: new config shoud notify update
      final shouldNotify = newConfig.updateShouldNotify(oldConfig);
      expect(shouldNotify, true);
    });
  });
}
