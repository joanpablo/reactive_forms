import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_switch_list_tile_testing_widget.dart';

void main() {
  group('ReactiveSwitchListTile Tests', () {
    testWidgets(
      'SwitchListTile initialize false if control default value is null',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switchListTile': FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: gets switchListTile value
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        // Then: value equals to false
        for (final switchWidget in switches) {
          expect(switchWidget.value, false);
        }
      },
    );

    testWidgets(
      'SwitchListTile initialize true if control default value is true',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switchListTile': FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: gets switchListTile value
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        // Then: value equals to control value
        for (final switchWidget in switches) {
          expect(switchWidget.value, true);
        }
      },
    );

    testWidgets(
      'SwitchListTile initialize false if control default value is false',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switchListTile': FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: gets switchListTile value
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        // Then: value equals to false
        for (final switchWidget in switches) {
          expect(switchWidget.value, false);
        }
      },
    );

    testWidgets(
      'SwitchListTile value changes to true if control value changes to true',
      (WidgetTester tester) async {
        // Given: a form with and control in false
        final form = FormGroup({
          'switchListTile': FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: change control value to true
        form.control('switchListTile').value = true;
        await tester.pump();

        // Then: value equals to true
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.value, true);
        }
      },
    );

    testWidgets(
      'SwitchListTile value changes to false if control value changes to false',
      (WidgetTester tester) async {
        // Given: a form with and control in false
        final form = FormGroup({
          'switchListTile': FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: change control value to false
        form.control('switchListTile').value = false;
        await tester.pump();

        // Then: value equals to false
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.value, false);
        }
      },
    );

    testWidgets(
      'Control disabled by default disable SwitchListTile',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'switchListTile': FormControl<bool>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // Then: the switchListTile is disabled
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.onChanged, null);
        }
      },
    );

    testWidgets(
      'Disable a control disable the SwitchListTile',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'switchListTile': FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the switchListTile is disabled
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.onChanged, null);
        }
      },
    );

    testWidgets(
      'Enable a control enable switchListTile',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'switchListTile': FormControl<bool>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester
            .pumpWidget(ReactiveSwitchListTileTestingWidget(form: form));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the switchListTile is disabled
        final switches = tester
            .widgetList(find.byType(SwitchListTile))
            .map((widget) => widget as SwitchListTile)
            .toList();

        for (final switchWidget in switches) {
          expect(switchWidget.onChanged != null, true);
        }
      },
    );

    testWidgets(
      'SwitchListTile onChanged callback is called',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switchListTile': FormControl<bool>(value: false),
        });

        var callbackCalled = false;
        FormControl<bool>? callbackArg;

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveSwitchListTileTestingWidget(
            form: form,
            onChanged: (control) {
              callbackCalled = true;
              callbackArg = control;
            },
          ),
        );

        // When: user change switch value
        final switchWidget = tester
            .widgetList<SwitchListTile>(find.byType(SwitchListTile))
            .map((widget) => widget)
            .toList()
            .first;
        switchWidget.onChanged!(true);

        // Then: onChanged callback is called
        expect(callbackCalled, true);

        // And: callback argument is the control
        expect(callbackArg, form.control('switchListTile'));

        // And: control has the right value
        expect(form.control('switchListTile').value, true);
      },
    );

    testWidgets(
      'Adaptative SwitchListTile onChanged callback is called',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switchListTile': FormControl<bool>(value: false),
        });

        var callbackCalled = false;
        FormControl<bool>? callbackArg;

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveSwitchListTileTestingWidget(
            form: form,
            adaptativeOnChanged: (control) {
              callbackCalled = true;
              callbackArg = control;
            },
          ),
        );

        // When: user change switch value
        final adaptativeSwitchWidget = tester
            .widgetList<SwitchListTile>(find.byType(SwitchListTile))
            .map((widget) => widget)
            .last;
        adaptativeSwitchWidget.onChanged!(true);

        // Then: onChanged callback is called
        expect(callbackCalled, true);

        // And: callback argument is the control
        expect(callbackArg, form.control('switchListTile'));

        // And: control has the right value
        expect(form.control('switchListTile').value, true);
      },
    );
  });

  testWidgets(
    '''Provide a FocusNode to ReactiveSwitchListTile and access it through
    focus controller''',
    (WidgetTester tester) async {
      // Given: A group with a field
      final control = FormControl<bool>();
      final form = FormGroup({
        switchListTileControl: control,
      });

      // And: a focus node
      final focusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
        focusNode: focusNode,
        renderAdaptative: false,
      ));

      // Expect: field has the provided focus node and is the same of the
      // focus controller
      final widget =
          tester.firstWidget<SwitchListTile>(find.byType(SwitchListTile));
      expect(widget.focusNode, control.focusController?.focusNode);
    },
  );

  testWidgets(
    '''Provide a FocusNode to adaptative ReactiveSwitchListTile and access it
    through focus controller''',
    (WidgetTester tester) async {
      // Given: A group with a field
      final control = FormControl<bool>();
      final form = FormGroup({
        switchListTileControl: control,
      });

      // And: a focus node
      final focusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
        adaptativeFocusNode: focusNode,
      ));

      // Expect: field has the provided focus node and is the same of the
      // focus controller
      final widget =
          tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).last;
      expect(widget.focusNode, control.focusController?.focusNode);
    },
  );

  testWidgets(
    'Provide a FocusNode to ReactiveSwitchListTile',
    (WidgetTester tester) async {
      // Given: A group with a field
      final form = FormGroup({
        switchListTileControl: FormControl<bool>(),
      });

      // And: a focus node
      final focusNode = FocusNode();
      final adaptativeFocusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
        focusNode: focusNode,
        adaptativeFocusNode: adaptativeFocusNode,
      ));

      // Expect: field has the provided focus node
      final widgets = tester
          .widgetList<SwitchListTile>(find.byType(SwitchListTile))
          .toList();

      expect(widgets.first.focusNode, focusNode);
      expect(widgets.last.focusNode, adaptativeFocusNode);
    },
  );

  testWidgets(
    'Call FormControl.unfocus() remove focus on widget',
    (WidgetTester tester) async {
      // Given: A group with a field
      final control = FormControl<bool>();
      final form = FormGroup({
        switchListTileControl: control,
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
        renderAdaptative: false,
      ));

      // And: the field has focused
      var widget =
          tester.firstWidget<SwitchListTile>(find.byType(SwitchListTile));
      widget.focusNode?.requestFocus();
      await tester.pump();
      expect(widget.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      control.unfocus();
      await tester.pump();

      // Then: the reactive widget is unfocused
      widget = tester.firstWidget<SwitchListTile>(find.byType(SwitchListTile));
      expect(widget.focusNode?.hasFocus, false);
    },
  );

  testWidgets(
    'Call FormControl.unfocus() remove focus on adaptative widget',
    (WidgetTester tester) async {
      // Given: A group with a field
      final control = FormControl<bool>();
      final form = FormGroup({
        switchListTileControl: control,
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
      ));

      // And: the field has focused
      var widget =
          tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).last;

      widget.focusNode?.requestFocus();
      await tester.pump();
      expect(widget.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      control.unfocus();
      await tester.pump();

      // Then: the reactive widget is unfocused
      widget =
          tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).last;

      expect(widget.focusNode?.hasFocus, false);
    },
  );

  testWidgets(
    'Call FormControl.focus() request focus on field',
    (WidgetTester tester) async {
      // Given: A group with a field
      final form = FormGroup({
        switchListTileControl: FormControl<bool>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
        renderAdaptative: false,
      ));

      // Expect: that the field has no focus
      var widget =
          tester.firstWidget<SwitchListTile>(find.byType(SwitchListTile));

      expect(widget.focusNode?.hasFocus, false);

      // When: call FormControl.focus()
      form.control(switchListTileControl).focus();
      await tester.pump();

      // Then: the reactive field is focused
      widget = tester.firstWidget<SwitchListTile>(find.byType(SwitchListTile));

      expect(widget.focusNode?.hasFocus, true);
    },
  );

  testWidgets(
    'Call FormControl.focus() request focus on adaptative field',
    (WidgetTester tester) async {
      // Given: A group with a field
      final form = FormGroup({
        switchListTileControl: FormControl<bool>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSwitchListTileTestingWidget(
        form: form,
      ));

      // Expect: that the field has no focus
      var widget =
          tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).last;

      expect(widget.focusNode?.hasFocus, false);

      // When: call FormControl.focus()
      form.control(switchListTileControl).focus();
      await tester.pump();

      // Then: the reactive field is focused
      widget =
          tester.widgetList<SwitchListTile>(find.byType(SwitchListTile)).last;

      expect(widget.focusNode?.hasFocus, true);
    },
  );
}
