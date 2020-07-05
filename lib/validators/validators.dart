// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/models/abstract_control.dart';
import 'package:reactive_forms/validators/email_validator.dart';
import 'package:reactive_forms/validators/max_length_validator.dart';
import 'package:reactive_forms/validators/min_length_validator.dart';
import 'package:reactive_forms/validators/must_match_validator.dart';
import 'package:reactive_forms/validators/number_validator.dart';
import 'package:reactive_forms/validators/pattern_validator.dart';
import 'package:reactive_forms/validators/required_validator.dart';

/// Signature for functions that defines a validator
typedef ValidatorFunction = Map<String, dynamic> Function(
    AbstractControl value);

/// Provides a set of built-in validators that can be used by form controls.
class Validators {
  /// Validator that requires the control have a non-empty value.
  static ValidatorFunction get required => RequiredValidator().validate;

  /// Validator that requires the control's value pass an email validation test.
  static ValidatorFunction get email => EmailValidator().validate;

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
}
