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
  });
}
