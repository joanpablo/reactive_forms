import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_checkbox_testing_widget.dart';

void main() {
  group('ReactiveCheckbox Tests', () {
    testWidgets(
      'FormControl with null default value then Checkbox not checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in null
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Expect: the checkbox is not checked
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, false);
      },
    );

    testWidgets(
      'Tristate FormControl with null default value then Checkbox not checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in null
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(
          form: form,
          tristate: true,
        ));

        // Expect: the checkbox is not checked
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, null);
      },
    );

    testWidgets(
      'if FormControl with defaults to True then Checkbox checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in True
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(value: true),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Expect: the checkbox is checked
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, true);
      },
    );

    testWidgets(
      'if FormControl with defaults to False then Checkbox not checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in False
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(value: false),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Expect: the checkbox is not checked
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, false);
      },
    );

    testWidgets(
      'Change FormControl value to True changes Checkbox value to True',
      (WidgetTester tester) async {
        // Given: a form with a boolean field
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Expect: the checkbox is not checked
        var checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, false);

        // When: set to True the form control
        form.control(reactiveCheckboxTestingName).value = true;
        await tester.pump();

        // Then: the checkbox is checked
        checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, true);
      },
    );

    testWidgets(
      'Change FormControl value to False changes Checkbox value to False',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in true
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(value: true),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Expect: the checkbox is checked
        var checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, true);

        // When: set to False the form control
        form.control(reactiveCheckboxTestingName).value = false;
        await tester.pump();

        // Then: the checkbox is checked
        checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, false);
      },
    );

    testWidgets(
      'Control disabled by default disable Checkbox',
      (WidgetTester tester) async {
        // Given: a form with disable control
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(disabled: true),
        });

        // When: a checkbox is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Then: the checkbox is disabled
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.onChanged, null);
      },
    );

    testWidgets(
      'Disable a control disable Checkbox',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the checkbox is disabled
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.onChanged, null);
      },
    );

    testWidgets(
      'Enable a control enable Checkbox',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(disabled: true),
        });

        // And: a checkbox is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the checkbox is enable
        final checkbox = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.onChanged != null, true);
      },
    );

    testWidgets(
      'Call FormControl.focus() request focus on field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // Expect: that the field has no focus
        var checkboxField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkboxField.focusNode?.hasFocus, false);

        // When: call FormControl.focus()
        (form.control(reactiveCheckboxTestingName) as FormControl).focus();
        await tester.pump();

        // Then: the reactive field is focused
        checkboxField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkboxField.focusNode?.hasFocus, true);
      },
    );

    testWidgets(
      'Call FormControl.unfocus() remove focus on field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // And: the field has focused
        var checkboxField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        checkboxField.focusNode?.requestFocus();
        await tester.pump();
        expect(checkboxField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus()
        (form.control(reactiveCheckboxTestingName) as FormControl).unfocus();
        await tester.pump();

        // Then: the reactive field is unfocused
        checkboxField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(checkboxField.focusNode?.hasFocus, false);
      },
    );

    testWidgets(
      'Remove focus on an invalid control show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // And: the field has focused
        var checkboxField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        checkboxField.focusNode?.requestFocus();
        await tester.pump();
        expect(checkboxField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus()
        (form.control(reactiveCheckboxTestingName) as FormControl).unfocus();
        await tester.pump();
      },
    );

    testWidgets(
      'Remove focus, and mark a control as untouched does not show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveCheckboxTestingName:
              FormControl<bool>(validators: [Validators.required]),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(form: form));

        // And: the field has focused
        var textField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus(touched: false)
        form.control(reactiveCheckboxTestingName).unfocus(touched: false);
        await tester.pump();
      },
    );

    testWidgets(
      'Provide a FocusNode to ReactiveCheckbox',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          reactiveCheckboxTestingName: FormControl<bool>(),
        });

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(
          form: form,
          focusNode: focusNode,
        ));

        // Expect: field has the provided focus node
        final textField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(textField.focusNode, focusNode);
      },
    );

    testWidgets(
      'Provide a FocusNode to ReactiveCheckbox and access it through focus controller',
      (WidgetTester tester) async {
        // Given: A group with a field
        final nameControl = FormControl<bool>();
        final form = FormGroup({
          reactiveCheckboxTestingName: nameControl,
        });

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxTestingWidget(
          form: form,
          focusNode: focusNode,
        ));

        // Expect: field has the provided focus node and is the same of the focus controller
        final textField = tester.firstWidget<Checkbox>(find.byType(Checkbox));
        expect(textField.focusNode, nameControl.focusController?.focusNode);
      },
    );
  });
}
