import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/compare_validator.dart';

void main() {
  group('Compare Validator Tests', () {
    test('Lower compare', () {
      // Given: a valid form
      final form = fb.group({
        'amount': 10,
        'balance': 20,
      }, [
        Validators.compare('amount', 'balance', CompareOption.lower),
      ]);

      // Expect: form is valid
      expect(form.valid, true);
    });
    test('Lower compare invalid', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 10,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.lower),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Lower or equal compare', () {
      // Given: a valid form
      final form = fb.group({
        'amount': 10,
        'balance': 20,
      }, [
        Validators.compare('amount', 'balance', CompareOption.lower_or_equal),
      ]);

      // Expect: form is valid
      expect(form.valid, true);
    });
    test('Lower or equal compare valid', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 10,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.lower_or_equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, true);
    });
    test('Lower or equal compare invalid', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 11,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.lower_or_equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Equal compare valid', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 10,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, true);
    });
    test('Equal compare lower (invalid)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 5,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Equal compare greater (invalid)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 10,
        'balance': 15,
      }, [
        Validators.compare('amount', 'balance', CompareOption.equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });
    test('Greater compare', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 20,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.greater),
      ]);

      // Expect: form is invalid
      expect(form.valid, true);
    });

    test('Greater compare invalid (equal values)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 20,
        'balance': 20,
      }, [
        Validators.compare('amount', 'balance', CompareOption.greater),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Greater compare invalid (lower values)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 10,
        'balance': 20,
      }, [
        Validators.compare('amount', 'balance', CompareOption.greater),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Greater or equal compare', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 20,
        'balance': 10,
      }, [
        Validators.compare('amount', 'balance', CompareOption.greater_or_equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, true);
    });

    test('Greater or equal compare (equal values)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 20,
        'balance': 20,
      }, [
        Validators.compare('amount', 'balance', CompareOption.greater_or_equal)
      ]);

      // Expect: form is invalid
      expect(form.valid, true);
    });

    test('Greater or equal compare (invalid)', () {
      // Given: an invalid form
      final form = fb.group({
        'amount': 20,
        'balance': 30,
      }, [
        Validators.compare('amount', 'balance', CompareOption.greater_or_equal),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Assert error on Null arguments', () {
      expect(() => CompareValidator(null, '', CompareOption.equal),
          throwsAssertionError);
      expect(() => CompareValidator('', null, CompareOption.equal),
          throwsAssertionError);
      expect(() => CompareValidator('', '', null), throwsAssertionError);
    });

    test('Compare DateTime controls', () {
      // Given: an invalid form
      final form = fb.group({
        'expedition': DateTime(2020),
        'expiration': DateTime(1985),
      }, [
        Validators.compare('expedition', 'expiration', CompareOption.lower),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });

    test('Compare null DateTime values', () {
      // Given: an invalid form
      final form = fb.group({
        'expedition': fb.control<DateTime>(null),
        'expiration': fb.control<DateTime>(null),
      }, [
        Validators.compare('expedition', 'expiration', CompareOption.lower),
      ]);

      // Expect: form is invalid
      expect(form.valid, false);
    });
  });
}
