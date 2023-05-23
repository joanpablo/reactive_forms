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
import 'package:reactive_forms/src/validators/delegate_async_validator.dart';
import 'package:reactive_forms/src/validators/delegate_validator.dart';
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

/// Provides a set of built-in validators that can be used by form controls,
/// form groups, and form arrays.
class Validators {
  /// Gets a validator that delegates the validation to the external [validator]
  /// function.
  static Validator<dynamic> delegate(ValidatorFunction validator) =>
      DelegateValidator(validator);

  /// Gets a validator that delegates the validation to the external
  /// asynchronous [validator] function.
  static AsyncValidator<dynamic> delegateAsync(
          AsyncValidatorFunction validator) =>
      DelegateAsyncValidator(validator);

  /// Gets a validator that requires the control have a non-empty value.
  static Validator<dynamic> get required => const RequiredValidator();

  /// Gets a validator that requires the control's value be true.
  /// This validator is commonly used for required checkboxes.
  static Validator<dynamic> get requiredTrue => const EqualsValidator<bool>(
        true,
        validationMessage: ValidationMessage.requiredTrue,
      );

  /// Gets a validator that requires the control's value pass an email
  /// validation test.
  static Validator<dynamic> get email => const EmailValidator();

  /// Gets a validator that validates if control's value is a numeric value.
  static Validator<dynamic> get number => const NumberValidator();

  /// Gets a validator that validates if the control's value is a valid
  /// credit card number.
  static Validator<dynamic> get creditCard => const CreditCardValidator();

  /// Gets a validator that requires the control's value to be equals to
  /// argument [value].
  ///
  /// The argument [value] must not be null.
  static Validator<dynamic> equals<T>(T value) => EqualsValidator<T>(value);

  /// Gets a validator that requires the control's value to be greater than
  /// or equal to [min] value.
  ///
  /// The argument [min] must not be null.
  static Validator<dynamic> min<T>(T min) => MinValidator<T>(min);

  /// Gets a validator that requires the control's value to be less than
  /// or equal to [max] value.
  ///
  /// The argument [max] must not be null.
  static Validator<dynamic> max<T>(T max) => MaxValidator<T>(max);

  /// Gets a validator that requires the length of the control's value to be
  /// greater than or equal to the provided [minLength].
  ///
  /// The argument [minLength] argument must not be null.
  static Validator<dynamic> minLength(int minLength) =>
      MinLengthValidator(minLength);

  /// Gets a validator that requires the length of the control's value to be
  /// less than or equal to the provided [maxLength].
  ///
  /// The argument [maxLength] must not be null.
  static Validator<dynamic> maxLength(int maxLength) =>
      MaxLengthValidator(maxLength);

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
  static Validator<dynamic> pattern(
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

    return PatternValidator(evaluator, validationMessage: validationMessage);
  }

  /// Gets a [FormGroup] validator that checks the controls [controlName] and
  /// [matchingControlName] have the same values.
  ///
  /// The arguments [controlName] and [matchingControlName] must not be null.
  ///
  /// If [markAsDirty] is true or not set (default) then the
  /// [matchingControlName] will be marked as `dirty` if validator marks
  /// it as invalid.
  ///
  /// By default, when the user changes the value of the [controlName] and
  /// it is different from the value of the [matchingControlName] then this
  /// last one is marked as INVALID, TOUCHED, and DIRTY, and the error will
  /// be visible in the UI. You can change this behavior if you set
  /// [markAsDirty] as `false`; then the [matchingControlName] will be marked
  /// just as INVALID and TOUCHED.
  ///
  /// ## Example:
  /// Shows validation error as soon as the user interacts with `password` or
  /// `passwordConfirmation` widgets:
  /// ```dart
  /// final form = fb.group({
  ///    'password': FormControl<String>(),
  ///    'passwordConfirmation': FormControl<String>(),
  /// }, [
  ///    Validators.mustMatch('password', 'passwordConfirmation')
  /// ]);
  /// ```
  /// ```dart
  /// ...
  /// ReactiveTextField(formControlName: 'password'),
  /// ReactiveTextField(formControlName: 'passwordConfirmation'),
  /// ...
  /// ```
  ///
  /// ## Example:
  /// Shows validation error only when the user interacts with the
  /// `passwordConfirmation` widget:
  /// ```dart
  /// final form = fb.group({
  ///    'password': FormControl<String>(),
  ///    'passwordConfirmation': FormControl<String>(),
  /// }, [
  ///    Validators.mustMatch('password', 'passwordConfirmation', markAsDirty: false)
  /// ]);
  /// ```
  /// ```dart
  /// ...
  /// ReactiveTextField(
  ///    formControlName: 'password'
  /// ),
  /// ReactiveTextField(
  ///    formControlName: 'passwordConfirmation',
  ///    // show errors only if user interacts directly with the invalid control
  ///    showErrors: (control) => control.invalid && control.dirty,
  /// ),
  /// ...
  /// ```
  static Validator<dynamic> mustMatch(
      String controlName, String matchingControlName,
      {bool markAsDirty = true}) {
    return MustMatchValidator(controlName, matchingControlName, markAsDirty);
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
  /// }, [Validators.compare('amount', 'balance', CompareOption.lowerOrEquals)]);
  /// ```
  static Validator<dynamic> compare(
    String controlName,
    String compareControlName,
    CompareOption compareOption,
  ) {
    return CompareValidator(controlName, compareControlName, compareOption);
  }

  /// Compose multiple validators into a single validator that returns the union
  /// of the individual error maps for the provided control of multiple
  /// validators.
  ///
  /// The argument [validators] must not be null.
  static Validator<dynamic> compose(List<Validator<dynamic>> validators) {
    return ComposeValidator(validators);
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
  static Validator<dynamic> composeOR(List<Validator<dynamic>> validators) {
    return ComposeOrValidator(validators);
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
  static Validator<dynamic> contains<T>(List<T> values) {
    return ContainsValidator<T>(values);
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
  static Validator<dynamic> any<T>(AnyValidatorFunctionTest<T> test) {
    return AnyValidator<T>(test);
  }
}
