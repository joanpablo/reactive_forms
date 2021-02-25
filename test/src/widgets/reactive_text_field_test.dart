import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_text_field_testing_widget.dart';

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
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // Expect: that the text field has no value when painted
        expect(find.text('John'), findsNothing);

        // When: set a value to field 'name'
        form.control('name')?.value = 'John';
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
          'name': FormControl(value: 'John'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // Expect: that the text field has no focus
        TextField textField = tester.firstWidget(find.byType(TextField));
        expect(textField.focusNode?.hasFocus, isFalse);

        // When: call FormControl.focus()
        (form.control('name') as FormControl).focus();
        await tester.pump();

        // Then: the reactive text field is focused
        textField = tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.focusNode?.hasFocus, isTrue);
      },
    );

    testWidgets(
      'Call FormControl.unfocus() remove focus on text field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          'name': FormControl(value: 'John'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // And: the text field has focused
        TextField textField = tester.firstWidget(find.byType(TextField));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, isTrue);

        // When: call FormControl.unfocus()
        (form.control('name') as FormControl).unfocus();
        await tester.pump();

        // Then: the reactive text field is unfocused
        textField = tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.focusNode?.hasFocus, isFalse);
      },
    );

    testWidgets(
      'Remove focus on an invalid control show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          'name': FormControl(validators: [Validators.required]),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // And: the text field has focused
        TextField textField = tester.firstWidget(find.byType(TextField));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, isTrue);

        // Expect: errors are not visible yet
        expect(textField.decoration?.errorText, isNull,
            reason: 'errors are visible');

        // When: call FormControl.unfocus()
        (form.control('name') as FormControl).unfocus();
        await tester.pump();

        // Then: the errors are visible
        textField = tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.decoration?.errorText,
            equals(ValidationMessage.required));
      },
    );

    testWidgets(
      'Remove focus, and mark a control as untouched does not show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          'name': FormControl(validators: [Validators.required]),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // And: the text field has focused
        TextField textField = tester.firstWidget(find.byType(TextField));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, isTrue);

        // Expect: errors are not visible yet
        expect(textField.decoration?.errorText, isNull,
            reason: 'errors are visible');

        // When: call FormControl.unfocus(touched: false)
        form.control('name')?.unfocus(touched: false);
        await tester.pump();

        // Then: the errors are not visible
        textField = tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.decoration?.errorText, isNull);
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
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // And: the field is invalid and untouched
        expect(form.control('name')?.hasErrors, true);
        expect(form.control('name')?.touched, false);

        // Expect: text field is not showing errors
        final textField =
            tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.decoration?.errorText, isNull);
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
      await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

      // Then: text field is showing errors
      final textField = tester.firstWidget(find.byType(TextField)) as TextField;
      expect(
          textField.decoration?.errorText, equals(ValidationMessage.required));
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
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          validationMessages: (control) => {
            ValidationMessage.required: customMessage,
          },
        ));

        // Expect: text field is showing the custom message as error
        final textField =
            tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.decoration?.errorText, equals(customMessage));
      },
    );

    testWidgets('Errors visible when control change to touched and dirty',
        (WidgetTester tester) async {
      // Given: An invalid form
      final form = FormGroup({
        'name': FormControl(
          validators: [Validators.required],
        ),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

      // Expect: text field is not showing errors because is not touched
      TextField textField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(textField.decoration?.errorText, isNull);

      // When: touch the control
      form.control('name')?.markAsTouched();
      await tester.pump();

      // Then: text field is showing errors
      textField = tester.firstWidget(find.byType(TextField)) as TextField;
      expect(
          textField.decoration?.errorText, equals(ValidationMessage.required));
    });

    testWidgets('Custom handler to show errors', (WidgetTester tester) async {
      // Given: An invalid form
      final form = FormGroup({
        'name': FormControl(
          validators: [Validators.required],
        ),
      });

      // And: a widget bind to the form with custom showErrors function
      await tester.pumpWidget(
        ReactiveTextFieldTestingWidget(
          form: form,
          showErrors: (control) =>
              control.invalid && control.touched && control.dirty,
        ),
      );

      // Expect: text field is not showing errors because is not touched
      TextField textField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(textField.decoration?.errorText, isNull);

      // When: touch the control and mark as dirty
      form.control('name')?.markAsDirty(emitEvent: false);
      form.control('name')?.markAsTouched();
      await tester.pump();

      // Then: text field is showing errors
      textField = tester.firstWidget(find.byType(TextField)) as TextField;
      expect(
          textField.decoration?.errorText, equals(ValidationMessage.required));
    });

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

    testWidgets('Control disabled by default disable Text field',
        (WidgetTester tester) async {
      // Given: An form with disabled control
      final form = FormGroup({
        'name': FormControl(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

      // Then: the text field is disabled
      TextField textField =
          tester.firstWidget(find.byType(TextField)) as TextField;
      expect(textField.enabled, false);
    });

    testWidgets(
      'Disable a control disable text field',
      (WidgetTester tester) async {
        // Given: An form
        final form = FormGroup({
          'name': FormControl(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the text field is disabled
        TextField textField =
            tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.enabled, false);
      },
    );

    testWidgets(
      'Enable a control enable text field',
      (WidgetTester tester) async {
        // Given: An form with disabled control
        final form = FormGroup({
          'name': FormControl(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the text field is enable
        TextField textField =
            tester.firstWidget(find.byType(TextField)) as TextField;
        expect(textField.enabled, true);
      },
    );

    testWidgets(
      'Change value of a text field marks control as dirty',
      (WidgetTester tester) async {
        // Given: a form with
        final form = FormGroup({
          'name': FormControl(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // Expect: control isn't dirty
        expect(form.control('name')?.dirty, false);

        // When: change text field value
        await tester.enterText(find.byType(TextField), 'some value');

        // Then: the control is dirty
        expect(form.control('name')?.dirty, true,
            reason: 'control is not marked as dirty');
      },
    );

    testWidgets(
      'Checks dirty state inside a custom validator',
      (WidgetTester tester) async {
        // Given: a form with custom validator
        bool isControlDirty = false;

        final customValidator = (AbstractControl? control) {
          isControlDirty = control != null ? control.dirty : false;
          return null;
        };

        final form = FormGroup({
          'name': FormControl(validators: [customValidator]),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(form: form));

        // Expect: control isn't dirty
        expect(isControlDirty, false);

        // When: change text field value
        await tester.enterText(find.byType(TextField), 'some value');

        // Then: the control is dirty
        expect(isControlDirty, true, reason: 'control is not marked as dirty');
      },
    );

    testWidgets(
      'IntValueAccessor selected when control is FormControl<int>',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'age': FormControl<int>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          bindings: {'textField': 'age'},
        ));

        // When: get the state of the text field
        ReactiveFormFieldState state = tester.allStates
                .firstWhere((state) => state.widget is ReactiveTextField)
            as ReactiveFormFieldState;

        // Then: the value accessor is IntValueAccessor
        expect(state.valueAccessor, isInstanceOf<IntValueAccessor>());
      },
    );

    testWidgets(
      'DoubleValueAccessor selected when control is FormControl<double>',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'amount': FormControl<double>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          bindings: {'textField': 'amount'},
        ));

        // When: get the state of the text field
        ReactiveFormFieldState state = tester.allStates
                .firstWhere((state) => state.widget is ReactiveTextField)
            as ReactiveFormFieldState;

        // Then: the value accessor is DoubleValueAccessor
        expect(state.valueAccessor, isInstanceOf<DoubleValueAccessor>());
      },
    );

    testWidgets(
      'DateTimeValueAccessor selected when control is FormControl<DateTime>',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'birthDate': FormControl<DateTime>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          bindings: {'textField': 'birthDate'},
        ));

        // When: get the state of the text field
        ReactiveFormFieldState state = tester.allStates
                .firstWhere((state) => state.widget is ReactiveTextField)
            as ReactiveFormFieldState;

        // Then: the value accessor is DateTimeValueAccessor
        expect(state.valueAccessor, isInstanceOf<DateTimeValueAccessor>());
      },
    );

    testWidgets(
      'TimeOfDayValueAccessor selected when control is FormControl<TimeOfDay>',
      (WidgetTester tester) async {
        // Given: a form with
        final form = FormGroup({
          'time': FormControl<TimeOfDay>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          bindings: {'textField': 'time'},
        ));

        // When: get the state of the text field
        ReactiveFormFieldState state = tester.allStates
                .firstWhere((state) => state.widget is ReactiveTextField)
            as ReactiveFormFieldState;

        // Then: the value accessor is TimeOfDayValueAccessor
        expect(state.valueAccessor, isInstanceOf<TimeOfDayValueAccessor>());
      },
    );

    testWidgets(
      'Provide a FocusNode to ReactiveTextField',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          'name': FormControl(value: 'John'),
        });

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          focusNode: focusNode,
        ));

        // Expect: text field has the provided focus node
        TextField textField = tester.firstWidget(find.byType(TextField));
        expect(textField.focusNode, focusNode);
      },
    );

    testWidgets(
      'Provide a FocusNode to ReactiveTextField and access it through focus controller',
      (WidgetTester tester) async {
        // Given: A group with a field
        final nameControl = FormControl(value: 'John');
        final form = FormGroup({
          'name': nameControl,
        });

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget(
          form: form,
          focusNode: focusNode,
        ));

        // Expect: text field has the provided focus node and is the same of the focus controller
        TextField textField = tester.firstWidget(find.byType(TextField));
        expect(textField.focusNode, nameControl.focusController!.focusNode);
      },
    );
  });
}
