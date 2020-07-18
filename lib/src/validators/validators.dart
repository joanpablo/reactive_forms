// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/compose_validator.dart';

import './email_validator.dart';
import './max_length_validator.dart';
import './min_length_validator.dart';
import './must_match_validator.dart';
import './number_validator.dart';
import './pattern_validator.dart';
import './required_validator.dart';

/// Signature of a function that receives a control and synchronously
/// returns a map of validation errors if present, otherwise null.
typedef ValidatorFunction = Map<String, dynamic> Function(
    AbstractControl value);

/// Signature of a function that receives a control and returns a Future
/// that emits validation errors if present, otherwise null.
typedef AsyncValidatorFunction = Future<Map<String, dynamic>> Function(
    AbstractControl value);

/// Provides a set of built-in validators that can be used by form controls.
class Validators {
  /// Validator that requires the control have a non-empty value.
  static ValidatorFunction get required => RequiredValidator().validate;

  /// Validator that requires the control's value pass an email validation test.
  static ValidatorFunction get email => EmailValidator().validate;

  /// Validates if control's value is an integer.
  static ValidatorFunction get number => NumberValidator().validate;

  /// Validator that requires the length of the control's value to be greater
  /// than or equal to the provided minimum length.
  static ValidatorFunction minLength(int minLength) =>
      MinLengthValidator(minLength).validate;

  /// Validator that requires the length of the control's value to be less
  /// than or equal to the provided maximum length.
  static ValidatorFunction maxLength(int maxLength) =>
      MaxLengthValidator(maxLength).validate;

  /// Validator that requires the control's value to match a regex pattern.
  static ValidatorFunction pattern(Pattern pattern) =>
      PatternValidator(pattern).validate;

  /// This validator is for use with a [FormGroup] and check that
  /// the controls [controlName] and [matchingControlName] have the same value.
  static ValidatorFunction mustMatch(
      String controlName, String matchingControlName) {
    return MustMatchValidator(controlName, matchingControlName).validate;
  }

  /// Compose multiple validators into a single function.
  ///
  /// If at least one validator evaluates as 'VALID' then compose validator
  /// evaluates a 'VALID' and return null, otherwise returns the union of
  /// the individual error maps returned by each validator.
  static List<ValidatorFunction> compose(List<ValidatorFunction> validators) {
    return [ComposeValidator(validators).validate];
  }
}
