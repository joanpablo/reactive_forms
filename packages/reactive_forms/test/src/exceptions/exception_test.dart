import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

import '../widgets/reactive_text_field_testing_widget.dart';

void main() {
  group('Exceptions tests', () {
    test('FormControlNotFoundException message references the control index',
        () {
      final e = FormControlNotFoundException(controlName: '0');
      expect(e.toString().contains('control with name: \'0\' not found'), true);
    });

    test('FormArrayInvalidIndexException message references the invalid index ',
        () {
      final e = FormArrayInvalidIndexException('control');
      expect(e.toString().contains('Index \'control\' is not a valid index'),
          true);
    });

    test('FormControlNotFoundException when not control in array', () {
      // Given: an array
      final array = FormArray([]);

      // Whe trying to remove a control that doesn't belong to array
      final removeControl = () => array.remove(FormControl());

      // Then: exception is thrown
      expect(
          removeControl, throwsA(isInstanceOf<FormControlNotFoundException>()));
    });

    test('FormControlNotFoundException message when no name specified', () {
      // Given: an exception
      final e = FormControlNotFoundException();

      // Expect: the right message
      expect(e.toString(), 'FormControlNotFoundException: control not found.');
    });

    test('FormBuilderInvalidInitializationException message', () {
      expect(FormBuilderInvalidInitializationException('message').toString(),
          'FormBuilderInvalidInitializationException: message');
    });

    test('ValueAccessorException message', () {
      expect(ValueAccessorException('message').toString(),
          'ValueAccessorException: message');
    });

    testWidgets(
      'Bind a widget that is expecting a control of type String to a control '
      'with different data type rises an exception',
      (WidgetTester tester) async {
        // Given: a form and a date time field
        final form = FormGroup({
          'name': FormControl<int>(),
        });

        // And: a widget bound to the form
        await tester.pumpWidget(ReactiveTextFieldTestingWidget<String>(
          form: form,
        ));

        // Then: initial date is equals to last Date
        expect(tester.takeException(),
            isInstanceOf<BindingCastException<String, String>>());
      },
    );
  });
}
