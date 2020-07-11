import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_testing_widget.dart';

void main() {
  testWidgets(
    'When FormControl value changes text field updates value',
    (WidgetTester tester) async {
      // Given: A group with an empty field 'name' is created
      final form = FormGroup({
        'name': FormControl(),
      });

      // And: a widget is bind to the form
      await tester.pumpWidget(ReactiveTestingWidget(form: form));

      // Expect: that the text field has no value when painted
      expect(find.text('John'), findsNothing);

      // When: set a value to field 'name'
      form.formControl('name').value = 'John';
      await tester.pump();

      // Then: the reactive text field updates its value with the new name
      expect(find.text('John'), findsOneWidget);
    },
  );
}
