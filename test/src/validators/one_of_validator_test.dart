import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('OneOfValidator Tests', () {
    Map<String, Map<String, dynamic>> errorDetails(
      List<dynamic> required,
      dynamic actual, {
      bool? caseSensitive,
    }) => {
      'oneOf': {
        'requiredOneOf': required,
        'actual': actual,
        if (caseSensitive != null) 'caseSensitive': caseSensitive,
      },
    };

    test(
      'FormControl is valid if value is in collection (String, case-sensitive)',
      () {
        final validator = Validators.oneOf(['apple', 'banana']);
        final control = FormControl<String>(
          value: 'apple',
          validators: [validator],
        );

        expect(control.valid, true);
        control.value = 'banana';
        expect(control.valid, true);
      },
    );

    test(
      'FormControl is invalid if value is not in collection (String, case-sensitive)',
      () {
        final collection = ['apple', 'banana'];
        final validator = Validators.oneOf(collection);
        final control = FormControl<String>(
          value: 'orange',
          validators: [validator],
        );

        expect(control.valid, false);
        expect(
          control.errors,
          errorDetails(collection, 'orange', caseSensitive: true),
        );
      },
    );

    test(
      'FormControl is invalid if value is in collection but different case (String, case-sensitive)',
      () {
        final collection = ['apple', 'banana'];
        final validator = Validators.oneOf(collection);
        final control = FormControl<String>(
          value: 'Apple',
          validators: [validator],
        );

        expect(control.valid, false);
        expect(
          control.errors,
          errorDetails(collection, 'Apple', caseSensitive: true),
        );
      },
    );

    test(
      'FormControl is valid if value is in collection (String, case-insensitive)',
      () {
        final validator = Validators.oneOf([
          'Apple',
          'Banana',
        ], caseSensitive: false);
        final control = FormControl<String>(
          value: 'apple',
          validators: [validator],
        );

        expect(control.valid, true);
        control.value = 'BANANA';
        expect(control.valid, true);
      },
    );

    test(
      'FormControl is invalid if value is not in collection (String, case-insensitive)',
      () {
        final collection = ['Apple', 'Banana'];
        final validator = Validators.oneOf(collection, caseSensitive: false);
        final control = FormControl<String>(
          value: 'Orange',
          validators: [validator],
        );

        expect(control.valid, false);
        expect(
          control.errors,
          errorDetails(collection, 'Orange', caseSensitive: false),
        );
      },
    );

    test('FormControl is valid if value is in collection (int)', () {
      final validator = Validators.oneOf([1, 2, 3]);
      final control = FormControl<int>(value: 2, validators: [validator]);

      expect(control.valid, true);
    });

    test('FormControl is invalid if value is not in collection (int)', () {
      final collection = [1, 2, 3];
      final validator = Validators.oneOf(collection);
      final control = FormControl<int>(value: 4, validators: [validator]);

      expect(control.valid, false);
      // caseSensitive is not included in the error for non-string types
      expect(control.errors, errorDetails(collection, 4));
    });

    test('FormControl is valid if value is null and null is in collection', () {
      final validator = Validators.oneOf([1, 2, null]);
      final control = FormControl<int>(value: null, validators: [validator]);

      expect(control.valid, true);
    });

    test(
      'FormControl is invalid if value is null and null is not in collection',
      () {
        final collection = [1, 2, 3];
        final validator = Validators.oneOf(collection);
        final control = FormControl<int>(value: null, validators: [validator]);

        expect(control.valid, false);
        expect(control.errors, errorDetails(collection, null));
      },
    );

    test('FormControl is valid with mixed types in collection', () {
      final validator = Validators.oneOf([1, 'apple', true]);
      final control = FormControl<dynamic>(
        value: 'apple',
        validators: [validator],
      );
      expect(control.valid, true);

      control.value = 1;
      expect(control.valid, true);

      control.value = true;
      expect(control.valid, true);
    });

    test(
      'FormControl is invalid with mixed types in collection and value not present',
      () {
        final collection = [1, 'apple', true];
        final validator = Validators.oneOf(collection);
        final control = FormControl<dynamic>(
          value: 'banana',
          validators: [validator],
        );

        expect(control.valid, false);
        expect(
          control.errors,
          errorDetails(collection, 'banana', caseSensitive: true),
        );
      },
    );

    test('FormControl is invalid if collection is empty', () {
      final collection = <dynamic>[];
      final validator = Validators.oneOf(collection);
      final control = FormControl<String>(
        value: 'test',
        validators: [validator],
      );

      expect(control.valid, false);
      expect(
        control.errors,
        errorDetails(collection, 'test', caseSensitive: true),
      );
    });

    test('Error map contains expected keys for string validation failure', () {
      final collection = ['a', 'b'];
      final validator = Validators.oneOf(collection, caseSensitive: false);
      final control = FormControl<String>(value: 'c', validators: [validator]);
      control.markAsTouched(); // To trigger validation

      expect(control.errors, {
        'oneOf': {
          'requiredOneOf': collection,
          'actual': 'c',
          'caseSensitive': false,
        },
      });
    });

    test(
      'Error map contains expected keys for non-string validation failure',
      () {
        final collection = [1, 2];
        final validator = Validators.oneOf(collection);
        final control = FormControl<int>(value: 3, validators: [validator]);
        control.markAsTouched(); // To trigger validation

        expect(control.errors, {
          'oneOf': {'requiredOneOf': collection, 'actual': 3},
        });
      },
    );
  });
}
