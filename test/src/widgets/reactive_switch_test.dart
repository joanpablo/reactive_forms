import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_switch_testing_widget.dart';

void main() {
  group('ReactiveSlider Tests', () {
    testWidgets(
      'Switch initialize false if control default value is null',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switch': FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: gets switch value
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();

        // Then: value equals to false
        switches.forEach((switchWidget) {
          expect(switchWidget.value, false);
        });
      },
    );

    testWidgets(
      'Switch initialize true if control default value is true',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switch': FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: gets switch value
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();

        // Then: value equals to control value
        switches.forEach((switchWidget) {
          expect(switchWidget.value, true);
        });
      },
    );

    testWidgets(
      'Switch initialize false if control default value is false',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'switch': FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: gets switch value
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();

        // Then: value equals to false
        switches.forEach((switchWidget) {
          expect(switchWidget.value, false);
        });
      },
    );

    testWidgets(
      'Switch value changes to true if control value changes to true',
      (WidgetTester tester) async {
        // Given: a form with and control in false
        final form = FormGroup({
          'switch': FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: change control value to true
        form.control('switch').value = true;
        await tester.pump();

        // Then: value equals to true
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();
        switches.forEach((switchWidget) {
          expect(switchWidget.value, true);
        });
      },
    );

    testWidgets(
      'Switch value changes to false if control value changes to false',
      (WidgetTester tester) async {
        // Given: a form with and control in false
        final form = FormGroup({
          'switch': FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: change control value to false
        form.control('switch').value = false;
        await tester.pump();

        // Then: value equals to false
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();
        switches.forEach((switchWidget) {
          expect(switchWidget.value, false);
        });
      },
    );

    testWidgets(
      'Control disabled by default disable Switch',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'switch': FormControl<bool>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // Then: the switch is disabled
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();
        switches.forEach((switchWidget) {
          expect(switchWidget.onChanged, null);
        });
      },
    );

    testWidgets(
      'Disable a control disable the Switch',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'switch': FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: disable form
        form.disable();
        await tester.pump();

        // Then: the switch is disabled
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();
        switches.forEach((switchWidget) {
          expect(switchWidget.onChanged, null);
        });
      },
    );

    testWidgets(
      'Enable a control enable switch',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'switch': FormControl<bool>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSwitchTestingWidget(form: form));

        // When: enable form
        form.enable();
        await tester.pump();

        // Then: the switch is disabled
        List<Switch> switches = tester
            .widgetList(find.byType(Switch))
            .map((widget) => widget as Switch)
            .toList();
        switches.forEach((switchWidget) {
          expect(switchWidget.onChanged != null, true);
        });
      },
    );
  });
}
