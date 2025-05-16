import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('Compare Validator Tests', () {
    test('Lower compare in non FormGroup control', () {
      final control = FormControl<String>(
        value: null,
        validators: [
          Validators.compare('amount', 'balance', CompareOption.lower),
        ],
      );

      expect(control.valid, false);
      expect(control.errors, {ValidationMessage.compare: true});
    });

    test('Lower compare', () {
      // Given: a valid form
      final form = fb.group(
        {'amount': 10, 'balance': 20},
        [Validators.compare('amount', 'balance', CompareOption.lower)],
      );

      // Expect: form is valid
      expect(form.valid, true);
    });
    test('Lower compare invalid', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 10, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.lower)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Lower or equal compare', () {
      // Given: a valid form
      final form = fb.group(
        {'amount': 10, 'balance': 20},
        [Validators.compare('amount', 'balance', CompareOption.lowerOrEqual)],
      );

      // Expect: form is valid
      expect(form.valid, true);
    });
    test('Lower or equal compare valid', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 10, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.lowerOrEqual)],
      );

      // Expect: form is invalid
      expect(form.valid, true);
    });
    test('Lower or equal compare invalid', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 11, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.lowerOrEqual)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Equal compare valid', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 10, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.equal)],
      );

      // Expect: form is invalid
      expect(form.valid, true);
    });
    test('Equal compare lower (invalid)', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 5, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.equal)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Equal compare greater (invalid)', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 10, 'balance': 15},
        [Validators.compare('amount', 'balance', CompareOption.equal)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Greater compare', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 20, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.greater)],
      );

      // Expect: form is invalid
      expect(form.valid, true);
    });

    test('Greater compare invalid (equal values)', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 20, 'balance': 20},
        [Validators.compare('amount', 'balance', CompareOption.greater)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Greater compare invalid (lower values)', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 10, 'balance': 20},
        [Validators.compare('amount', 'balance', CompareOption.greater)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Greater or equal compare', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 20, 'balance': 10},
        [Validators.compare('amount', 'balance', CompareOption.greaterOrEqual)],
      );

      // Expect: form is invalid
      expect(form.valid, true);
    });

    test('Greater or equal compare (equal values)', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 20, 'balance': 20},
        [Validators.compare('amount', 'balance', CompareOption.greaterOrEqual)],
      );

      // Expect: form is invalid
      expect(form.valid, true);
    });

    test('Greater or equal compare (invalid)', () {
      // Given: an invalid form
      final form = fb.group(
        {'amount': 20, 'balance': 30},
        [Validators.compare('amount', 'balance', CompareOption.greaterOrEqual)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Compare DateTime controls', () {
      // Given: an invalid form
      final form = fb.group(
        {'expedition': DateTime(2020), 'expiration': DateTime(1985)},
        [Validators.compare('expedition', 'expiration', CompareOption.lower)],
      );

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Compare null DateTime values', () {
      // Given: an invalid form
      final form = fb.group(
        {
          'expedition': FormControl<DateTime>(),
          'expiration': FormControl<DateTime>(),
        },
        [Validators.compare('expedition', 'expiration', CompareOption.lower)],
      );

      // Expect: form is invalid
      expect(form.invalid, true);
    });

    test('Compare with different data types throws exception', () {
      // Given: an invalid form
      void form() => fb.group(
        {'value1': fb.control<int>(0), 'value2': fb.control<String>('10')},
        [Validators.compare('value1', 'value2', CompareOption.lowerOrEqual)],
      );

      // Expect: form is invalid
      expect(form, throwsA(isInstanceOf<ValidatorException>()));
    });

    test('Compare with equals null values', () {
      // Given: a form with null values
      final form = fb.group(
        {'value1': FormControl<int>(), 'value2': FormControl<int>()},
        [Validators.compare('value1', 'value2', CompareOption.equal)],
      );

      // Expect: form is valid
      expect(form.valid, true);
    });

    test('Compare with control null return invalid', () {
      // Given: a form with null values
      final form = fb.group(
        {'value1': FormControl<int>(), 'value2': FormControl<int>(value: 10)},
        [Validators.compare('value1', 'value2', CompareOption.equal)],
      );

      // Expect: form is invalid
      expect(form.invalid, true);
      expect(form.control('value1').hasError(ValidationMessage.compare), true);
    });

    test('Compare with the other control null return invalid', () {
      // Given: a form with null values
      final form = fb.group(
        {'value1': FormControl<int>(value: 10), 'value2': FormControl<int>()},
        [Validators.compare('value1', 'value2', CompareOption.equal)],
      );

      // Expect: form is invalid
      expect(form.invalid, true);
      expect(form.control('value1').hasError(ValidationMessage.compare), true);
    });

    test('Compare with not comparable data type', () {
      // Given: a form with null values
      void form() => fb.group(
        {
          'value1': FormControl<NotComparableClass>(
            value: NotComparableClass(),
          ),
          'value2': FormControl<NotComparableClass>(
            value: NotComparableClass(),
          ),
        },
        [Validators.compare('value1', 'value2', CompareOption.equal)],
      );

      // Expect: form is invalid
      expect(form, throwsA(isInstanceOf<ValidatorException>()));
    });

    test('Lower compare (allow null)', () {
      // Given: a valid form
      final form = fb.group({
        'amount': 10,
        'balance': 20,
      }, [
        Validators.compare(
          'amount',
          'balance',
          CompareOption.lower,
          allowNull: true,
        ),
      ]);

      // Expect: form is valid
      expect(form.valid, true);
    });
    test('Lower compare invalid (allow null)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 10,
        'balance': 10,
      }, [
        Validators.compare(
          'amount',
          'balance',
          CompareOption.lower,
          allowNull: true,
        ),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Compare with control null (allow null)', () {
      // Given: a form with null values (allowed)
      final form = fb.group({
        'value1': FormControl<int>(),
        'value2': FormControl<int>(value: 10),
      }, [
        Validators.compare(
          'value1',
          'value2',
          CompareOption.equal,
          allowNull: true,
        ),
      ]);

      // Expect: form is valid
      expect(form.valid, true);
    });
    test('Compare with the other control null (allow null)', () {
      // Given: a form with null values (allowed)
      final form = fb.group({
        'value1': FormControl<int>(value: 10),
        'value2': FormControl<int>(),
      }, [
        Validators.compare(
          'value1',
          'value2',
          CompareOption.equal,
          allowNull: true,
        ),
      ]);

      // Expect: form is valid
      expect(form.valid, true);
    });
  });
}

class NotComparableClass {}
