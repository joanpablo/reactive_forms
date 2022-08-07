import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_checkbox_list_tile_testing_widget.dart';

void main() {
  group('ReactiveCheckboxListTile Tests', () {
    testWidgets(
      'FormControl with null default value then Checkbox not checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in null
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to boolean control
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Expect: the checkbox is not checked
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, false);
      },
    );

    testWidgets(
      'Tristate FormControl with null default value then Checkbox not checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in null
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to boolean control
        await tester.pumpWidget(ReactiveCheckboxListTileTestingWidget(
          form: form,
          tristate: true,
        ));

        // Expect: the checkbox is not checked
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, null);
      },
    );

    testWidgets(
      'if FormControl with defaults to True then Checkbox checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in True
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(value: true),
        });

        // And: a checkbox is bind to boolean control
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Expect: the checkbox is checked
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, true);
      },
    );

    testWidgets(
      'if FormControl with defaults to False then Checkbox not checked',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in False
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(value: false),
        });

        // And: a checkbox is bind to boolean control
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Expect: the checkbox is not checked
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, false);
      },
    );

    testWidgets(
      'Change FormControl value to True changes Checkbox value to True',
      (WidgetTester tester) async {
        // Given: a form with a boolean field
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to boolean control
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Expect: the checkbox is not checked
        var checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, false);

        // When: set to True the form control
        form.control(reactiveCheckboxListTileTestingName).value = true;
        await tester.pump();

        // Then: the checkbox is checked
        checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, true);
      },
    );

    testWidgets(
      'Change FormControl value to False changes Checkbox value to False',
      (WidgetTester tester) async {
        // Given: a form with a boolean field in true
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(value: true),
        });

        // And: a checkbox is bind to boolean control
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Expect: the checkbox is checked
        var checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, true);

        // When: set to False the form control
        form.control(reactiveCheckboxListTileTestingName).value = false;
        await tester.pump();

        // Then: the checkbox is checked
        checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.value, false);
      },
    );

    testWidgets(
      'Control disabled by default disable Checkbox',
      (WidgetTester tester) async {
        // Given: a form with disable control
        final form = FormGroup({
          reactiveCheckboxListTileTestingName:
              FormControl<bool>(disabled: true),
        });

        // When: a checkbox is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Then: the checkbox is disabled
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.onChanged, null);
      },
    );

    testWidgets(
      'Disable a control disable Checkbox',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a checkbox is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the checkbox is disabled
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.onChanged, null);
      },
    );

    testWidgets(
      'Enable a control enable Checkbox',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          reactiveCheckboxListTileTestingName:
              FormControl<bool>(disabled: true),
        });

        // And: a checkbox is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the checkbox is enable
        final checkbox = tester.firstWidget(find.byType(Checkbox)) as Checkbox;
        expect(checkbox.onChanged != null, true);
      },
    );

    testWidgets(
      'Call FormControl.focus() request focus on field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // Expect: that the field has no focus
        var radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
        expect(radioField.focusNode?.hasFocus, false);

        // When: call FormControl.focus()
        (form.control(reactiveCheckboxListTileTestingName) as FormControl)
            .focus();
        await tester.pump();

        // Then: the reactive field is focused
        radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
        expect(radioField.focusNode?.hasFocus, true);
      },
    );

    testWidgets(
      'Call FormControl.unfocus() remove focus on field',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // And: the field has focused
        var radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
        radioField.focusNode?.requestFocus();
        await tester.pump();
        expect(radioField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus()
        (form.control(reactiveCheckboxListTileTestingName) as FormControl)
            .unfocus();
        await tester.pump();

        // Then: the reactive field is unfocused
        radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
        expect(radioField.focusNode?.hasFocus, false);
      },
    );

    testWidgets(
      'Remove focus on an invalid control show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // And: the field has focused
        var radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
        radioField.focusNode?.requestFocus();
        await tester.pump();
        expect(radioField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus()
        (form.control(reactiveCheckboxListTileTestingName) as FormControl)
            .unfocus();
        await tester.pump();
      },
    );

    testWidgets(
      'Remove focus, and mark a control as untouched does not show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveCheckboxListTileTestingName:
              FormControl<bool>(validators: [Validators.required]),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveCheckboxListTileTestingWidget(form: form));

        // And: the field has focused
        var textField = tester.firstWidget<ListTile>(find.byType(ListTile));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus(touched: false)
        form
            .control(reactiveCheckboxListTileTestingName)
            .unfocus(touched: false);
        await tester.pump();
      },
    );

    testWidgets(
      'Provide a FocusNode to ReactiveListTile',
      (WidgetTester tester) async {
        // Given: A group with a field
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(),
        });

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxListTileTestingWidget(
          form: form,
          focusNode: focusNode,
        ));

        // Expect: field has the provided focus node
        final textField = tester.firstWidget<ListTile>(find.byType(ListTile));
        expect(textField.focusNode, focusNode);
      },
    );

    testWidgets(
      'Provide a FocusNode to ReactiveListTile and access it through focus controller',
      (WidgetTester tester) async {
        // Given: A group with a field
        final nameControl = FormControl<bool>();
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: nameControl,
        });

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveCheckboxListTileTestingWidget(
          form: form,
          focusNode: focusNode,
        ));

        // Expect: field has the provided focus node and is the same of the focus controller
        final textField = tester.firstWidget<ListTile>(find.byType(ListTile));
        expect(textField.focusNode, nameControl.focusController?.focusNode);
      },
    );

    testWidgets(
      'ReactiveCheckboxListTile onChanged callback is called',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          reactiveCheckboxListTileTestingName: FormControl<bool>(value: false),
        });

        var callbackCalled = false;
        FormControl<bool>? callbackArg;

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveCheckboxListTileTestingWidget(
            form: form,
            onChanged: (control) {
              callbackCalled = true;
              callbackArg = control;
            },
          ),
        );

        // When: user change switch value
        final widget = tester
            .widgetList<Checkbox>(find.byType(Checkbox))
            .map((widget) => widget)
            .toList()
            .first;
        widget.onChanged!(true);

        // Then: onChanged callback is called
        expect(
          callbackCalled,
          true,
          reason: 'ReactiveCheckboxListTile onChanged callback not called',
        );

        // And: callback argument is the control
        expect(
          callbackArg,
          form.control(reactiveCheckboxListTileTestingName),
          reason: '''ReactiveCheckboxListTile onChanged callback does not
          provide control as argument''',
        );

        // And: control has the right value
        expect(
          form.control(reactiveCheckboxListTileTestingName).value,
          true,
          reason: '''ReactiveCheckboxListTile onChanged callback does not change
          control value''',
        );
      },
    );
  });
}
