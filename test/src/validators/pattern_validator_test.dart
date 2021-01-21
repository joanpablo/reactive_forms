import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/pattern/default_pattern_evaluator.dart';
import 'package:reactive_forms/src/validators/pattern/regex_pattern_evaluator.dart';

import 'pattern/mock_pattern.dart';

void main() {
  group('Pattern Validator Tests', () {
    test('FormControl invalid if value not matched pattern', () {
      const AmericanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl(
        validators: [Validators.pattern(AmericanExpressPattern)],
      );

      cardNumber.value = '395465465421'; // not a valid number

      expect(cardNumber.valid, false);
      expect(cardNumber.hasError(ValidationMessage.pattern), true);
    });

    test('FormControl valid if value matched pattern', () {
      const AmericanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl(
        validators: [Validators.pattern(AmericanExpressPattern)],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true);
      expect(cardNumber.errors.keys.isEmpty, true);
    });

    test("Passing a Regex to Pattern validator", (){
      const AmericanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl(
        validators: [Validators.pattern(RegExp(AmericanExpressPattern))],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true);
      expect(cardNumber.errors.keys.isEmpty, true);
    });

    test("Passing null throws exception", (){
      expect(() => Validators.pattern(null), throwsAssertionError);
    });

    test("Passing null to RegExpPatternEvaluator throws exception", (){
      expect(() => RegExpPatternEvaluator(null), throwsAssertionError);
    });

    test("Passing null to DefaultPatternEvaluator throws exception", (){
      expect(() => DefaultPatternEvaluator(null), throwsAssertionError);
    });

    test("Passing a MockPattern to Pattern validator", (){
      const String AmericanExpressPattern = r'^3[47][0-9]{13}$';

      final cardNumber = FormControl(
        validators: [Validators.pattern(MockPattern(RegExp(AmericanExpressPattern)))],
      );

      cardNumber.value = '342654321654213';

      expect(cardNumber.valid, true, reason: "card number is not valid");
      expect(cardNumber.errors.keys.isEmpty, true, reason: "has errors");
    });
  });
}
