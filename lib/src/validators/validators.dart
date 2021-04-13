// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/any_validator.dart';
import 'package:reactive_forms/src/validators/compare_validator.dart';
import 'package:reactive_forms/src/validators/compose_or_validator.dart';
import 'package:reactive_forms/src/validators/compose_validator.dart';
import 'package:reactive_forms/src/validators/contains_validator.dart';
import 'package:reactive_forms/src/validators/credit_card_validator.dart';
import 'package:reactive_forms/src/validators/email_validator.dart';
import 'package:reactive_forms/src/validators/equals_validator.dart';
import 'package:reactive_forms/src/validators/max_length_validator.dart';
import 'package:reactive_forms/src/validators/max_validator.dart';
import 'package:reactive_forms/src/validators/min_length_validator.dart';
import 'package:reactive_forms/src/validators/min_validator.dart';
import 'package:reactive_forms/src/validators/must_match_validator.dart';
import 'package:reactive_forms/src/validators/number_validator.dart';
import 'package:reactive_forms/src/validators/pattern/default_pattern_evaluator.dart';
import 'package:reactive_forms/src/validators/pattern/pattern_evaluator.dart';
import 'package:reactive_forms/src/validators/pattern/regex_pattern_evaluator.dart';
import 'package:reactive_forms/src/validators/pattern_validator.dart';
import 'package:reactive_forms/src/validators/required_validator.dart';

/// Signature of a function that receives a control and synchronously
/// returns a map of validation errors if present, otherwise null.
typedef ValidatorFunction = Map<String, dynamic>? Function(
    AbstractControl<dynamic> control);

/// Signature of a function that receives a control and returns a Future
/// that emits validation errors if present, otherwise null.
typedef AsyncValidatorFunction = Future<Map<String, dynamic>?> Function(
    AbstractControl<dynamic> control);

/// Provides a set of built-in validators that can be used by form controls.
class Validators {
  /// Gets a validator that requires the control have a non-empty value.
  static ValidatorFunction get required => RequiredValidator().validate;

  /// Gets a validator that requires the control's value be true.
  /// This validator is commonly used for required checkboxes.
  static ValidatorFunction get requiredTrue => EqualsValidator<bool>(true,
          validationMessage: ValidationMessage.requiredTrue)
      .validate;

  /// Gets a validator that requires the control's value pass an email
  /// validation test.
  static ValidatorFunction get email => EmailValidator().validate;

  /// Gets a validator that validates if control's value is a numeric value.
  static ValidatorFunction get number => NumberValidator().validate;

  /// Gets a validator that validates if the control's value is a valid
  /// credit card number.
  static ValidatorFunction get creditCard => CreditCardValidator().validate;

  /// Gets a validator that requires the control's value to be equals to
  /// argument [value].
  ///
  /// The argument [value] must not be null.
  static ValidatorFunction equals<T>(T value) =>
      EqualsValidator<T>(value).validate;

  /// Gets a validator that requires the control's value to be greater than
  /// or equal to [min] value.
  ///
  /// The argument [min] must not be null.
  static ValidatorFunction min<T>(T min) => MinValidator<T>(min).validate;

  /// Gets a validator that requires the control's value to be less than
  /// or equal to [max] value.
  ///
  /// The argument [max] must not be null.
  static ValidatorFunction max<T>(T max) => MaxValidator<T>(max).validate;

  /// Gets a validator that requires the length of the control's value to be
  /// greater than or equal to the provided [minLength].
  ///
  /// The argument [minLength] argument must not be null.
  static ValidatorFunction minLength(int minLength) =>
      MinLengthValidator(minLength).validate;

  /// Gets a validator that requires the length of the control's value to be
  /// less than or equal to the provided [maxLength].
  ///
  /// The argument [maxLength] must not be null.
  static ValidatorFunction maxLength(int maxLength) =>
      MaxLengthValidator(maxLength).validate;

  /// Gets a validator that requires the control's value to match a
  /// regex [pattern].
  ///
  /// The argument [pattern] must not be null.
  ///
  /// The argument [validationMessage] is optional and specify the key text for
  /// the validation error. I none value is supplied then the default value is
  /// [ValidationMessage.pattern].
  ///
  /// ## Example:
  /// Using an instance of [RegExp] as argument.
  /// ```dart
  /// const AmericanExpressPattern = r'^3[47][0-9]{13}$';
  ///
  /// final cardNumber = FormControl(
  ///   value: '342654321654213',
  ///   validators: [Validators.pattern(RegExp(AmericanExpressPattern))],
  /// );
  ///
  /// expect(cardNumber.valid, true);
  /// ```
  /// ## Example:
  /// Using a [String] as argument.
  /// ```dart
  /// const AmericanExpressPattern = r'^3[47][0-9]{13}$';
  ///
  /// final cardNumber = FormControl(
  ///   value: '342654321654213',
  ///   validators: [Validators.pattern(AmericanExpressPattern)],
  /// );
  ///
  /// expect(cardNumber.valid, true);
  /// ```
  /// ## Example:
  /// Specifying a custom validation message.
  /// ```dart
  /// const containsLettersPattern = r'[a-z]+';
  /// const containsNumbersPattern = r'\d+';
  ///
  /// const containsLettersValidationMessage = "containsLetters";
  /// const containsNumbersValidationMessage = "containsNumbers";
  ///
  /// final password = FormControl(
  ///   value: '123abc',
  ///   validators: [
  ///     Validators.pattern(
  ///       containsLettersPattern,
  ///       validationMessage: containsLettersValidationMessage,
  ///     ),
  ///     Validators.pattern(
  ///       containsNumbersPattern,
  ///       validationMessage: containsNumbersValidationMessage,
  ///     ),
  ///   ],
  /// );
  ///
  /// expect(password.valid, true);
  /// ```
  static ValidatorFunction pattern(
    Pattern pattern, {
    String validationMessage = ValidationMessage.pattern,
  }) {
    PatternEvaluator evaluator;
    if (pattern is String) {
      evaluator = RegExpPatternEvaluator(RegExp(pattern));
    } else if (pattern is RegExp) {
      evaluator = RegExpPatternEvaluator(pattern);
    } else {
      evaluator = DefaultPatternEvaluator(pattern);
    }

    return PatternValidator(evaluator, validationMessage: validationMessage)
        .validate;
  }

  /// Gets a [FormGroup] validator that checks the controls [controlName] and
  /// [matchingControlName] have the same values.
  ///
  /// The arguments [controlName] and [matchingControlName] must not be null.
  static ValidatorFunction mustMatch(
      String controlName, String matchingControlName) {
    return MustMatchValidator(controlName, matchingControlName).validate;
  }

  /// Gets a [FormGroup] validator that compares two controls in the group.
  ///
  /// The arguments [controlName], [compareControlName] and [compareOption]
  /// must not be null.
  ///
  /// ## Example:
  /// Validates that 'amount' is lower or equals than 'balance'
  /// ```dart
  /// final form = fb.group({
  ///   'amount': 20.00,
  ///   'balance': 50.00,
  /// }, [Validators.compare('amount', 'balance', CompareOption.lower_or_equals)]);
  /// ```
  static ValidatorFunction compare(
    String controlName,
    String compareControlName,
    CompareOption compareOption,
  ) {
    return CompareValidator<dynamic>(
            controlName, compareControlName, compareOption)
        .validate;
  }

  /// Compose multiple validators into a single validator that returns the union
  /// of the individual error maps for the provided control of multiple
  /// validators.
  ///
  /// The argument [validators] must not be null.
  static ValidatorFunction compose(List<ValidatorFunction> validators) {
    return ComposeValidator(validators).validate;
  }

  /// Compose multiple validators into a single validator that returns the union
  /// of the individual error maps for the provided control of multiple
  /// validators.
  ///
  /// The argument [validators] must not be null.
  ///
  /// If at least one of the [validators] evaluates as 'VALID' then the compose
  /// validator evaluates as 'VALID' and returns null, otherwise returns
  /// the union of all the individual errors returned by each validator.
  static ValidatorFunction composeOR(List<ValidatorFunction> validators) {
    return ComposeOrValidator(validators).validate;
  }

  /// Gets a validator that requires the control's value contains all the
  /// values specified in [values].
  ///
  /// The argument [values] must not be null.
  ///
  /// ## Example:
  /// Validates that 'list' contains all the items provided
  /// ```dart
  /// final control = FormControl<List<int>>(
  ///   'value': [1,2,3],
  ///   'validators': [Validators.contains([1,3])],
  /// );
  /// ```
  /// or the same example but with FormArray
  /// ```dart
  /// final control = FormArray<int>([
  ///        FormControl<int>(value: 1),
  ///        FormControl<int>(value: 2),
  ///        FormControl<int>(value: 3),
  ///      ], validators: [Validators.contains([1,3])]
  /// );
  /// ```
  static ValidatorFunction contains<T>(List<T> values) {
    return ContainsValidator<T>(values).validate;
  }

  /// Gets a validator that requires any element of the control's iterable value
  /// satisfies [test].
  ///
  /// Checks every element in control's value in iteration order, and marks
  /// the control as valid if any of them make [test] return `true`,
  /// otherwise marks the control as invalid.
  ///
  /// ## Example with FormArray
  /// ```dart
  /// final array = FormArray<String>([
  ///     FormControl<String>(value: ''),
  ///     FormControl<String>(value: ''),
  ///   ], validators: [
  ///   Validators.any((String value) => value?.isNotEmpty)
  /// ]);
  ///
  /// print(array.valid); // outputs: false
  /// ```
  ///
  /// ## Example with FormControl
  /// ```dart
  /// final control = FormControl<List<String>>(
  ///   value: [null, null, 'not empty'],
  ///   validators: [
  ///     Validators.any((String? value) => value?.isNotEmpty)
  ///   ],
  /// );
  ///
  /// print(control.valid); // outputs: true
  /// ```
  static ValidatorFunction any<T>(AnyValidatorFunctionTest<T> test) {
    return AnyValidator<T>(test).validate;
  }
}
