import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('ReactiveFormBuilder Tests', () {
    testWidgets(
      'Assert Error if formGroup is null',
      (WidgetTester tester) async {
        expect(
          () => ReactiveFormBuilder(
            form: (context) => null,
            builder: (context, form, child) => Container(),
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'Assert Error if builder is null',
      (WidgetTester tester) async {
        expect(
          () => ReactiveFormBuilder(
            form: (context) => fb.group({}),
            builder: null,
          ),
          throwsAssertionError,
        );
      },
    );
  });
}
