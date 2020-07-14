import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('ReactiveForm Tests', () {
    testWidgets(
      'ReactiveForm with null form group throws exception',
      (WidgetTester tester) async {
        // Given: a ReactiveForm with null group
        final reactiveForm = () => ReactiveForm(
              formGroup: null,
              child: Container(),
            );

        // Expect assertion error
        expect(reactiveForm, throwsAssertionError);
      },
    );
  });
}
