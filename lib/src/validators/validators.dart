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
  /// Gets a validator that requires the control have a non-empty value.
  static ValidatorFunction get required => RequiredValidator().validate;

  /// Gets a validator that validates that the control's value is a valid email.
  static ValidatorFunction get email => EmailValidator().validate;

  /// Gets a validator that validates if control's value is an integer.
  static ValidatorFunction get number => NumberValidator().validate;

  /// Gets a validator that validates that the length of the control's value
  /// must be greater than or equals to the [minLength] argument.
  static ValidatorFunction minLength(int minLength) =>
      MinLengthValidator(minLength).validate;

  /// Gets a validator that validates that the length of the control's value
  /// must be less than or equals to the [maxLength] argument.
  static ValidatorFunction maxLength(int maxLength) =>
      MaxLengthValidator(maxLength).validate;

  /// Gets a validator that validates that the control's value matches
  /// the regex [pattern].
  static ValidatorFunction pattern(Pattern pattern) =>
      PatternValidator(pattern).validate;

  /// Gets a validator that is for use with a [FormGroup] and checks that
  /// the controls [controlName] and [matchingControlName] have the same values.
  static ValidatorFunction mustMatch(
      String controlName, String matchingControlName) {
    return MustMatchValidator(controlName, matchingControlName).validate;
  }

  /// Gets a collection with only one validator that is the composition
  /// of multiple validators.
  ///
  /// If at least one of the [validators] evaluates as 'VALID' then the compose
  /// validator evaluates as 'VALID' and returns null, otherwise returns
  /// the union of all the individual errors returned by each validator.
  static List<ValidatorFunction> compose(List<ValidatorFunction> validators) {
    return [ComposeValidator(validators).validate];
  }
}
