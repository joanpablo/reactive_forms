import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_dropdown_testing_widget.dart';

void main() {
  group('ReactiveDropdownField Tests', () {
    testWidgets(
      'Dropdown initialize empty if control default value is null',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'dropdown': FormControl<String>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveDropdownTestingWidget(
            form: form,
            items: ['true', 'false'],
          ),
        );

        // When: gets dropdown
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));

        // Expect: dropdown value is null
        expect(dropdown.value, null);
      },
    );

    testWidgets(
      'Dropdown initialize true if control default value is true',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'dropdown': FormControl<String>(value: 'true'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // When: gets dropdown
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));

        // Expect: dropdown value is null
        expect(dropdown.value, 'true');
      },
    );

    testWidgets(
      'Dropdown initialize false if control default value is false',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'dropdown': FormControl<String>(value: 'false'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // When: gets dropdown
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));

        // Expect: dropdown value is null
        expect(dropdown.value, 'false');
      },
    );

    testWidgets(
      'Dropdown changes value to true if control changes value to true',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'dropdown': FormControl<String>(value: 'false'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // When: changes control value
        form.control('dropdown').value = 'true';
        await tester.pump();

        // Then: dropdown value is equals to control
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));

        expect(dropdown.value, form.control('dropdown').value);
      },
    );

    testWidgets(
      'Dropdown changes value to false if control changes value to false',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'dropdown': FormControl<String>(value: 'true'),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // When: changes control value
        form.control('dropdown').value = 'false';
        await tester.pump();

        // Then: dropdown value is equals to control
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));

        expect(dropdown.value, form.control('dropdown').value);
      },
    );

    testWidgets(
      'Control disabled by default disable Dropdown',
      (WidgetTester tester) async {
        // Given: a form and a control
        final form = FormGroup({
          'dropdown': FormControl<String>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // Then: the dropdown is disabled
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));
        expect(dropdown.onChanged, null);
      },
    );

    testWidgets(
      'ReadOnly Dropdown',
      (WidgetTester tester) async {
        // Given: a form and a control
        final form = FormGroup({
          'dropdown': FormControl<String>(),
        });

        // And: a readonly widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
          readOnly: true,
        ));

        // Then: the dropdown is disabled
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));
        expect(dropdown.onChanged, null);
      },
    );

    testWidgets(
      'ReadOnly Dropdown with disabledHint',
      (WidgetTester tester) async {
        // Given: a form and a control
        final form = FormGroup({
          'dropdown': FormControl<String>(),
        });

        // And: a readonly widget that is bind to the form with disabledHint
        final disabledHint = const Text('disabled');
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
          readOnly: true,
          disabledHint: disabledHint,
        ));

        // Then: the dropdown is disabled
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));
        expect(dropdown.disabledHint, disabledHint);
      },
    );

    testWidgets(
      'Disable a control disable Dropdown',
      (WidgetTester tester) async {
        // Given: a form and a control
        final form = FormGroup({
          'dropdown': FormControl<String>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the dropdown is disabled
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));
        expect(dropdown.onChanged, null);
      },
    );

    testWidgets(
      'Enable a control enable Dropdown',
      (WidgetTester tester) async {
        // Given: a form and a control
        final form = FormGroup({
          'dropdown': FormControl<String>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
        ));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the dropdown is enable
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));
        expect(dropdown.onChanged != null, true);
      },
    );

    testWidgets(
      'Set Dropdown on Changed callback',
      (WidgetTester tester) async {
        // Given: a form
        final form = FormGroup({
          'dropdown': FormControl<String>(),
        });

        // And: a onChanged callback
        var callbackCalled = false;
        void onChanged(AbstractControl<String> control) {
          callbackCalled = true;
        }

        // And: a widget that is bind to the form
        final items = ['true', 'false'];
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: items,
          onChanged: onChanged,
        ));

        // When: callback on changed in widget
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));
        dropdown.onChanged!('true');
        await tester.pump();

        // Then: callback is called
        expect(callbackCalled, true);
      },
    );

    testWidgets(
      'A disabled Dropdown uses selectedItemBuilder to show selected item',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final items = ['true', 'false'];
        final form = FormGroup({
          'dropdown': FormControl<String>(
            value: items.elementAt(0),
            disabled: true,
          ),
        });

        // And: a widget that is bound to the form
        final selectedItemBuilderList = [
          const Text('true'),
          const Text('false'),
        ];
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: ['true', 'false'],
          selectedItemBuilder: (context) => selectedItemBuilderList,
        ));

        // Then: dropdown disabledHint value is equals to selectedItemBuilder
        // equivalent item
        final dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        final dropdown = tester
            .firstWidget<DropdownButton<String>>(find.byType(dropdownType));

        // Then: callback is called
        expect(dropdown.disabledHint, selectedItemBuilderList.elementAt(0));
      },
    );
  });
}
