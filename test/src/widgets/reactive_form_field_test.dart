import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('ReactiveFormField Tests', () {
    testWidgets(
      'Assert Error if formControlName is null and formControl is null',
      (WidgetTester tester) async {
        // Given: a ReactiveFormField with formControlName in null
        final reactiveFormField = () => ReactiveFormField(
              formControlName: null,
              formControl: null,
              builder: (_) => Container(),
            );

        // Expect: an assertion error
        expect(reactiveFormField, throwsAssertionError);
      },
    );

    testWidgets(
      'No error if formControl',
      (WidgetTester tester) async {
        // Given: a ReactiveFormField with formControlName in null
        final reactiveFormField = ReactiveFormField<Object, Object>(
          formControlName: null,
          formControl: FormControl(),
          builder: (_) => Container(),
        );

        expect(reactiveFormField,
            isInstanceOf<ReactiveFormField<Object, Object>>());
      },
    );

    group('-> ValueAccessor for non-matching generic types', () {
      testWidgets(
        'throws AssertionError if ValueAccessor is not set',
        (tester) async {
          final field = ReactiveFormField<String, int>(
            formControlName: null,
            formControl: FormControl(),
            builder: (_) => Container(),
          );

          await tester.pumpWidget(field);

          expect(tester.takeException(), isA<AssertionError>());
        },
      );

      testWidgets(
        'throws no error if ValueAccessor is set',
        (tester) async {
          final field = ReactiveFormField<String, int>(
            formControlName: null,
            valueAccessor: _TestStringIntValueAccessor(),
            formControl: FormControl(),
            builder: (_) => Container(),
          );

          await tester.pumpWidget(field);
        },
      );
    });
  });
}

class _TestStringIntValueAccessor extends ControlValueAccessor<String, int> {
  @override
  int? modelToViewValue(String? modelValue) =>
      modelValue == null ? null : int.parse(modelValue);

  @override
  String? viewToModelValue(int? viewValue) => viewValue?.toString();
}
