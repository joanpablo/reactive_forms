import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_radio_list_tile_testing_widget.dart';

void main() {
  group('ReactiveRadioListTile Tests', () {
    testWidgets('Radio init with true if control init in true', (
      WidgetTester tester,
    ) async {
      // Given: a form with and a control with default true
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(value: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // Expect radio group value is true
      final radioType =
          const Radio<bool>(
            value: false,
            groupValue: null,
            onChanged: null,
          ).runtimeType;

      final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
      expect(radio.groupValue, true);
    });

    testWidgets('Radio init with false if control init in false', (
      WidgetTester tester,
    ) async {
      // Given: a form with and a control with default false
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(value: false),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // Expect radio group value is false
      final radioType =
          const Radio<bool>(
            value: true,
            groupValue: null,
            onChanged: null,
          ).runtimeType;

      final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
      expect(radio.groupValue, false);
    });

    testWidgets(
      'Radio changes value to true when control value changes to true',
      (WidgetTester tester) async {
        // Given: a form with and a control with default false
        final form = FormGroup({
          reactiveRadioListTileTestingName: FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

        // When: changes control to true
        form.control(reactiveRadioListTileTestingName).value = true;
        await tester.pump();

        // Expect radio group value is true
        final radioType =
            const Radio<bool>(
              value: false,
              groupValue: null,
              onChanged: null,
            ).runtimeType;

        final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
        expect(radio.groupValue, true);
      },
    );

    testWidgets(
      'Radio changes value to false when control value changes to false',
      (WidgetTester tester) async {
        // Given: a form with and a control with default true
        final form = FormGroup({
          reactiveRadioListTileTestingName: FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

        // When: changes control to false
        form.control(reactiveRadioListTileTestingName).value = false;
        await tester.pump();

        // Expect radio group value is true
        final radioType =
            const Radio<bool>(
              value: true,
              groupValue: null,
              onChanged: null,
            ).runtimeType;

        final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
        expect(radio.groupValue, false);
      },
    );

    testWidgets('Control disabled by default disable Radio', (
      WidgetTester tester,
    ) async {
      // Given: a form with and a control with default true
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // Then: the radio is disabled
      final radioType =
          const Radio<bool>(
            value: true,
            groupValue: null,
            onChanged: null,
          ).runtimeType;

      final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
      expect(radio.onChanged, null);
    });

    testWidgets('Disable a control disable Radio', (WidgetTester tester) async {
      // Given: a form
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // When: disable form
      form.markAsDisabled();
      await tester.pump();

      // Then: the radio is disabled
      final radioType =
          const Radio<bool>(
            value: true,
            groupValue: null,
            onChanged: null,
          ).runtimeType;

      final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
      expect(radio.onChanged, null);
    });

    testWidgets('Enable a control enable Radio', (WidgetTester tester) async {
      // Given: a form with disabled
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // When: enable form
      form.markAsEnabled();
      await tester.pump();

      // Then: the radio is enabled
      final radioType =
          const Radio<bool>(
            value: true,
            groupValue: null,
            onChanged: null,
          ).runtimeType;

      final radio = tester.firstWidget<Radio<bool>>(find.byType(radioType));
      expect(radio.onChanged != null, true);
    });

    testWidgets('Call FormControl.focus() request focus on field', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // Expect: that the field has no focus
      var radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
      expect(radioField.focusNode?.hasFocus, false);

      // When: call FormControl.focus()
      (form.control(reactiveRadioListTileTestingName) as FormControl).focus();
      await tester.pump();

      // Then: the reactive field is focused
      radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
      expect(radioField.focusNode?.hasFocus, true);
    });

    testWidgets('Call FormControl.unfocus() remove focus on field', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // And: the field has focused
      var radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
      radioField.focusNode?.requestFocus();
      await tester.pump();
      expect(radioField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      (form.control(reactiveRadioListTileTestingName) as FormControl).unfocus();
      await tester.pump();

      // Then: the reactive field is unfocused
      radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
      expect(radioField.focusNode?.hasFocus, false);
    });

    testWidgets('Remove focus on an invalid control show error messages', (
      WidgetTester tester,
    ) async {
      // Given: A group with an invalid control
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

      // And: the field has focused
      var radioField = tester.firstWidget<ListTile>(find.byType(ListTile));
      radioField.focusNode?.requestFocus();
      await tester.pump();
      expect(radioField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      (form.control(reactiveRadioListTileTestingName) as FormControl).unfocus();
      await tester.pump();
    });

    testWidgets(
      'Remove focus, and mark a control as untouched does not show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveRadioListTileTestingName: FormControl<bool>(
            validators: [Validators.required],
          ),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioListTileTestingWidget(form: form));

        // And: the field has focused
        var textField = tester.firstWidget<ListTile>(find.byType(ListTile));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus(touched: false)
        form.control(reactiveRadioListTileTestingName).unfocus(touched: false);
        await tester.pump();
      },
    );

    testWidgets('Provide a FocusNode to ReactiveListTile', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(),
      });

      // And: a focus node
      final focusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(
        ReactiveRadioListTileTestingWidget(form: form, focusNode: focusNode),
      );

      // Expect: field has the provided focus node
      final textField = tester.firstWidget<ListTile>(find.byType(ListTile));
      expect(textField.focusNode, focusNode);
    });

    testWidgets(
      '''Provide a FocusNode to ReactiveRadioListTile and access it through
      focus controller''',
      (WidgetTester tester) async {
        // Given: A group with a field
        final nameControl = FormControl<bool>();
        final form = FormGroup({reactiveRadioListTileTestingName: nameControl});

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveRadioListTileTestingWidget(form: form, focusNode: focusNode),
        );

        // Expect: field has the provided focus node and is the same of the focus controller
        final textField = tester.firstWidget<ListTile>(find.byType(ListTile));
        expect(textField.focusNode, nameControl.focusController?.focusNode);
      },
    );

    testWidgets('ReactiveRadioListTile onChanged callback is called', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveRadioListTileTestingName: FormControl<bool>(value: false),
      });

      var callbackCalled = false;
      FormControl<bool>? callbackArg;

      // And: a widget that is bind to the form
      await tester.pumpWidget(
        ReactiveRadioListTileTestingWidget(
          form: form,
          onChanged: (control) {
            callbackCalled = true;
            callbackArg = control;
          },
        ),
      );

      // When: user change switch value
      final widget =
          tester
              .widgetList<Radio<bool>>(find.byType(Radio<bool>))
              .map((widget) => widget)
              .toList()
              .first;
      widget.onChanged!(true);

      // Then: onChanged callback is called
      expect(callbackCalled, true);

      // And: callback argument is the control
      expect(callbackArg, form.control(reactiveRadioListTileTestingName));

      // And: control has the right value
      expect(form.control(reactiveRadioListTileTestingName).value, true);
    });
  });
}
