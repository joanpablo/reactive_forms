import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Iso8601DateTimeValueAccessor Tests', () {
    test('Iso8601DateTimeValueAccessor converts to null a view null value', () {
      // Given: a control
      final control = fb.control(DateTime(2020).toIso8601String());

      // And: an Iso8601 value accessor
      final valueAccessor = Iso8601DateTimeValueAccessor();

      // When: register control
      valueAccessor.registerControl(control);

      // And: update accessor model value:
      valueAccessor.updateModel(null);

      // Then: value is converted correctly
      expect(control.value, null);
    });

    test('Iso8601DateTimeValueAccessor converts to null a model null value',
        () {
      // And: an Iso8601 value accessor
      final valueAccessor = Iso8601DateTimeValueAccessor();

      // Then: value is converted correctly
      expect(valueAccessor.modelToViewValue(null), null);
    });

    test('Iso8601DateTimeValueAccessor converts to null a model empty value',
        () {
      // And: an Iso8601 value accessor
      final valueAccessor = Iso8601DateTimeValueAccessor();

      // Then: value is converted correctly
      expect(valueAccessor.modelToViewValue(''), null);
    });

    test('Iso8601DateTimeValueAccessor converts to String a model datetime',
        () {
      // And: an Iso8601 value accessor
      final valueAccessor = Iso8601DateTimeValueAccessor();

      // Then: value is converted correctly
      expect(valueAccessor.modelToViewValue('2020-01-01T00:00:00.000'),
          DateTime(2020));
    });

    test(
        'Iso8601DateTimeValueAccessor converts to String a view DateTime value',
        () {
      // Given: a control
      final control = fb.control(DateTime(2020).toIso8601String());

      // And: an Iso8601 value accessor
      final valueAccessor = Iso8601DateTimeValueAccessor();

      // When: register control
      valueAccessor.registerControl(control);

      // And: update accessor model value:
      valueAccessor.updateModel(DateTime(2020));

      // Then: value is converted correctly
      expect(control.value, '2020-01-01T00:00:00.000');
    });
  });
}
