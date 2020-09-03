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
          'dropdown': FormControl<bool>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveDropdownTestingWidget(
            form: form,
            items: ['true', 'false'],
          ),
        );

        // When: gets dropdown
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));

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
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));

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
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));

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
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));

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
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));

        expect(dropdown.value, form.control('dropdown').value);
      },
    );

    testWidgets(
      'Assert error if items in null',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final dropdown = () => ReactiveDropdownField(
              formControlName: 'someName',
              items: null,
            );

        expect(dropdown, throwsAssertionError);
      },
    );

    testWidgets(
      'Assert Error if attributes in null',
      (WidgetTester tester) async {
        // decoration
        expect(
          () => ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [DropdownMenuItem(value: true, child: Text(''))],
            decoration: null,
          ),
          throwsAssertionError,
          reason: 'decoration != null',
        );

        // elevation
        expect(
          () => ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [DropdownMenuItem(value: true, child: Text(''))],
            elevation: null,
          ),
          throwsAssertionError,
          reason: 'elevation != null',
        );

        // iconSize
        expect(
          () => ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [DropdownMenuItem(value: true, child: Text(''))],
            iconSize: null,
          ),
          throwsAssertionError,
          reason: 'iconSize != null',
        );

        // isDense
        expect(
          () => ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [DropdownMenuItem(value: true, child: Text(''))],
            isDense: null,
          ),
          throwsAssertionError,
          reason: 'isDense != null',
        );

        // isExpanded
        expect(
          () => ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [DropdownMenuItem(value: true, child: Text(''))],
            isExpanded: null,
          ),
          throwsAssertionError,
          reason: 'isExpanded != null',
        );

        // itemHeight
        expect(
          () => ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [DropdownMenuItem(value: true, child: Text(''))],
            itemHeight: 0,
          ),
          throwsAssertionError,
          reason: 'itemHeight == null || itemHeight > 0',
        );
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
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));
        expect(dropdown.onChanged, null);
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
        form.disable();
        await tester.pump();

        // Then: the dropdown is disabled
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton dropdown = tester.firstWidget(find.byType(dropdownType));
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
        form.enable();
        await tester.pump();

        // Then: the dropdown is enable
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton<String> dropdown =
            tester.firstWidget(find.byType(dropdownType));
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
        bool callbackCalled = false;
        final onChanged = (String value) {
          callbackCalled = true;
        };

        // And: a widget that is bind to the form
        final items = ['true', 'false'];
        await tester.pumpWidget(ReactiveDropdownTestingWidget(
          form: form,
          items: items,
          onChanged: onChanged,
        ));

        // When: callback on changed in widget
        Type dropdownType =
            DropdownButton<String>(items: null, onChanged: null).runtimeType;
        DropdownButton<String> dropdown =
            tester.firstWidget(find.byType(dropdownType));
        dropdown.onChanged('true');
        await tester.pump();

        // Then: callback is called
        expect(callbackCalled, true);
      },
    );
  });
}
