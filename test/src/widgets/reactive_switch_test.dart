import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_switch_testing_widget.dart';

void main() {
  group('ReactiveSlider Tests', () {
    testWidgets('Switch initialize false if control default value is null', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({reactiveSwitchTestingName: FormControl<bool>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // When: gets switch value
      final switches =
          tester
              .widgetList<Switch>(find.byType(Switch))
              .map((widget) => widget)
              .toList();

      // Then: value equals to false
      for (final switchWidget in switches) {
        expect(switchWidget.value, false);
      }
    });

    testWidgets('Switch initialize true if control default value is true', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSwitchTestingName: FormControl<bool>(value: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // When: gets switch value
      final switches =
          tester
              .widgetList<Switch>(find.byType(Switch))
              .map((widget) => widget)
              .toList();

      // Then: value equals to control value
      for (final switchWidget in switches) {
        expect(switchWidget.value, true);
      }
    });

    testWidgets('Switch initialize false if control default value is false', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSwitchTestingName: FormControl<bool>(value: false),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // When: gets switch value
      final switches =
          tester
              .widgetList<Switch>(find.byType(Switch))
              .map((widget) => widget)
              .toList();

      // Then: value equals to false
      for (final switchWidget in switches) {
        expect(switchWidget.value, false);
      }
    });

    testWidgets(
      'Switch value changes to true if control value changes to true',
      (WidgetTester tester) async {
        // Given: a form with and control in false
        final form = FormGroup({
          reactiveSwitchTestingName: FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: change control value to true
        form.control(reactiveSwitchTestingName).value = true;
        await tester.pump();

        // Then: value equals to true
        final switches =
            tester
                .widgetList<Switch>(find.byType(Switch))
                .map((widget) => widget)
                .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.value, true);
        }
      },
    );

    testWidgets(
      'Switch value changes to false if control value changes to false',
      (WidgetTester tester) async {
        // Given: a form with and control in false
        final form = FormGroup({
          reactiveSwitchTestingName: FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: change control value to false
        form.control(reactiveSwitchTestingName).value = false;
        await tester.pump();

        // Then: value equals to false
        final switches =
            tester
                .widgetList<Switch>(find.byType(Switch))
                .map((widget) => widget)
                .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.value, false);
        }
      },
    );

    testWidgets('Control disabled by default disable Switch', (
      WidgetTester tester,
    ) async {
      // Given: a form with disabled control
      final form = FormGroup({
        reactiveSwitchTestingName: FormControl<bool>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // Then: the switch is disabled
      final switches =
          tester
              .widgetList<Switch>(find.byType(Switch))
              .map((widget) => widget)
              .toList();

      for (final switchWidget in switches) {
        expect(switchWidget.onChanged, null);
      }
    });

    testWidgets('Disable a control disable the Switch', (
      WidgetTester tester,
    ) async {
      // Given: a form
      final form = FormGroup({reactiveSwitchTestingName: FormControl<bool>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // When: disable form
      form.markAsDisabled();
      await tester.pump();

      // Then: the switch is disabled
      final switches =
          tester
              .widgetList<Switch>(find.byType(Switch))
              .map((widget) => widget)
              .toList();

      for (final switchWidget in switches) {
        expect(switchWidget.onChanged, null);
      }
    });

    testWidgets('Enable a control enable switch', (WidgetTester tester) async {
      // Given: a form
      final form = FormGroup({
        reactiveSwitchTestingName: FormControl<bool>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // When: enable form
      form.markAsEnabled();
      await tester.pump();

      // Then: the switch is disabled
      final switches =
          tester
              .widgetList<Switch>(find.byType(Switch))
              .map((widget) => widget)
              .toList();

      for (final switchWidget in switches) {
        expect(switchWidget.onChanged != null, true);
      }
    });
  });

  testWidgets('Call FormControl.focus() request focus on field', (
    WidgetTester tester,
  ) async {
    // Given: A group with a field
    final form = FormGroup({reactiveSwitchTestingName: FormControl<bool>()});

    // And: a widget that is bind to the form
    await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

    // Expect: that the field has no focus
    var switches =
        tester
            .widgetList<Switch>(find.byType(Switch))
            .map((widget) => widget)
            .toList();

    for (final switchWidget in switches) {
      expect(switchWidget.focusNode?.hasFocus, false);
    }

    // When: call FormControl.focus()
    (form.control(reactiveSwitchTestingName) as FormControl).focus();
    await tester.pump();

    // // Then: the reactive field is focused
    switches =
        tester
            .widgetList<Switch>(find.byType(Switch))
            .map((widget) => widget)
            .toList();

    expect(switches.last.focusNode?.hasFocus, true);
  });

  testWidgets('Call FormControl.unfocus() remove focus on field', (
    WidgetTester tester,
  ) async {
    // Given: A group with a field
    final form = FormGroup({reactiveSwitchTestingName: FormControl<bool>()});

    // And: a widget that is bind to the form
    await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

    // And: the field has focused
    var switches =
        tester
            .widgetList<Switch>(find.byType(Switch))
            .map((widget) => widget)
            .toList();

    switches.first.focusNode?.requestFocus();
    await tester.pump();
    expect(switches.first.focusNode?.hasFocus, true);

    switches.last.focusNode?.requestFocus();
    await tester.pump();
    expect(switches.last.focusNode?.hasFocus, true);

    // When: call FormControl.unfocus()
    (form.control(reactiveSwitchTestingName) as FormControl).unfocus();
    await tester.pump();

    // Then: the reactive field is unfocused
    switches =
        tester
            .widgetList<Switch>(find.byType(Switch))
            .map((widget) => widget)
            .toList();

    for (final switchWidget in switches) {
      expect(switchWidget.focusNode?.hasFocus, false);
    }
  });

  testWidgets('Remove focus on an invalid control show error messages', (
    WidgetTester tester,
  ) async {
    // Given: A group with an invalid control
    final form = FormGroup({reactiveSwitchTestingName: FormControl<bool>()});

    // And: a widget that is bind to the form
    await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

    // And: the field has focused
    var switchField = tester.firstWidget<Switch>(find.byType(Switch));
    switchField.focusNode?.requestFocus();
    await tester.pump();
    expect(switchField.focusNode?.hasFocus, true);

    // When: call FormControl.unfocus()
    (form.control(reactiveSwitchTestingName) as FormControl).unfocus();
    await tester.pump();
  });

  testWidgets(
    'Remove focus, and mark a control as untouched does not show error messages',
    (WidgetTester tester) async {
      // Given: A group with an invalid control
      final form = FormGroup({
        reactiveSwitchTestingName: FormControl<bool>(
          validators: [Validators.required],
        ),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

      // And: the field has focused
      var textField = tester.firstWidget<Switch>(find.byType(Switch));
      textField.focusNode?.requestFocus();
      await tester.pump();
      expect(textField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus(touched: false)
      form.control(reactiveSwitchTestingName).unfocus(touched: false);
      await tester.pump();
    },
  );

  testWidgets('Provide a FocusNode to ReactiveSwitch', (
    WidgetTester tester,
  ) async {
    // Given: A group with a field
    final form = FormGroup({reactiveSwitchTestingName: FormControl<bool>()});

    // And: a focus node
    final focusNode = FocusNode();

    // And: a widget that is bind to the form
    await tester.pumpWidget(
      ReactiveSwitchTestingWidget(form: form, focusNode: focusNode),
    );

    // Expect: field has the provided focus node
    final textField = tester.firstWidget<Switch>(find.byType(Switch));
    expect(textField.focusNode, focusNode);
  });

  testWidgets(
    'Provide a FocusNode to ReactiveSwitch and access it through focus controller',
    (WidgetTester tester) async {
      // Given: A group with a field
      final nameControl = FormControl<bool>();
      final form = FormGroup({reactiveSwitchTestingName: nameControl});

      // And: a focus node
      final focusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(
        ReactiveSwitchTestingWidget(form: form, focusNode: focusNode),
      );

      // Expect: field has the provided focus node and is the same of the
      // focus controller
      final textField = tester.firstWidget<Switch>(find.byType(Switch));
      expect(textField.focusNode, nameControl.focusController?.focusNode);
    },
  );

  testWidgets('Switch onChanged callback is called', (
    WidgetTester tester,
  ) async {
    // Given: a form with and control with default value
    final form = FormGroup({
      reactiveSwitchTestingName: FormControl<bool>(value: false),
    });

    var callbackCalled = false;
    FormControl<bool>? callbackArg;

    // And: a widget that is bind to the form
    await tester.pumpWidget(
      ReactiveSwitchTestingWidget(
        form: form,
        onChanged: (control) {
          callbackCalled = true;
          callbackArg = control;
        },
      ),
    );

    // When: user change switch value
    final switchWidget =
        tester
            .widgetList<Switch>(find.byType(Switch))
            .map((widget) => widget)
            .toList()
            .first;
    switchWidget.onChanged!(true);

    // Then: onChanged callback is called
    expect(callbackCalled, true);

    // And: callback argument is the control
    expect(callbackArg, form.control(reactiveSwitchTestingName));

    // And: control has the right value
    expect(form.control(reactiveSwitchTestingName).value, true);
  });

  testWidgets('Adaptative Switch onChanged callback is called', (
    WidgetTester tester,
  ) async {
    // Given: a form with and control with default value
    final form = FormGroup({
      reactiveSwitchTestingName: FormControl<bool>(value: false),
    });

    var callbackCalled = false;
    FormControl<bool>? callbackArg;

    // And: a widget that is bind to the form
    await tester.pumpWidget(
      ReactiveSwitchTestingWidget(
        form: form,
        adaptativeOnChanged: (control) {
          callbackCalled = true;
          callbackArg = control;
        },
      ),
    );

    // When: user change switch value
    final adaptativeSwitchWidget = tester
        .widgetList<Switch>(find.byType(Switch))
        .map((widget) => widget)
        .toList()
        .elementAt(1);
    adaptativeSwitchWidget.onChanged!(true);

    // Then: onChanged callback is called
    expect(callbackCalled, true);

    // And: callback argument is the control
    expect(callbackArg, form.control(reactiveSwitchTestingName));

    // And: control has the right value
    expect(form.control(reactiveSwitchTestingName).value, true);
  });
}
