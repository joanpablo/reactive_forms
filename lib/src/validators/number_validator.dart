// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/number_validator_error.dart';

/// Validator that validates if control's value is a numeric value.
class NumberValidator extends Validator<dynamic> {
  /// The regex expression of a numeric string value.
  static final RegExp notNumbersRegex = RegExp(r'[^0-9.]');

  /// The allowed number of decimal places in the validated string.
  ///
  /// This value specifies the maximum number of digits allowed after the
  /// decimal point in the validated string. Defaults to 0 (no decimals).
  final int allowedDecimals;

  /// Whether the validator allows null values.
  final bool allowNull;

  /// Whether the validator allows negative numbers.
  ///
  /// If set to `true`, the validator will accept strings representing
  /// negative numbers (prefixed with a '-'). Defaults to `true`.
  final bool allowNegatives;

  /// Creates a new NumberValidator instance to validate strings representing numbers.
  ///
  /// [allowedDecimals] (optional): The allowed number of decimal places. Defaults to 0.
  /// [allowNegatives] (optional): Whether to allow negative numbers. Defaults to true.
  const NumberValidator({
    this.allowNull = false,
    this.allowedDecimals = 0,
    this.allowNegatives = true,
  }) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    // Skip validation if null value is allowed
    if (allowNull && control.value == null) {
      return null;
    }

    if (control.value == null) {
      return <String, dynamic>{
        ValidationMessage.number: NumberValidatorError.nullValue,
      };
    }

    // Check for leading/trailing spaces
    final numberString = control.value.toString().trim();

    // Check for empty string
    if (numberString.isEmpty) {
      return <String, dynamic>{
        ValidationMessage.number: NumberValidatorError.invalidNumber,
      };
    }

    // Check for negative sign, if allowed
    final hasNegativeSign = numberString.startsWith('-');
    if (hasNegativeSign && !allowNegatives) {
      return <String, dynamic>{
        ValidationMessage.number: NumberValidatorError.unsignedNumber,
      };
    }

    // Remove the negative sign, if present, for further validation
    final unsignedNumberString =
        hasNegativeSign ? numberString.substring(1) : numberString;

    // Check for valid decimal positions
    if (!_validateNumberDecimals(allowedDecimals, unsignedNumberString)) {
      return <String, dynamic>{
        ValidationMessage.number: NumberValidatorError.invalidDecimals,
      };
    }

    // Check for valid numeric characters using a regular expression
    if (unsignedNumberString.contains(notNumbersRegex)) {
      return <String, dynamic>{
        ValidationMessage.number: NumberValidatorError.invalidNumber,
      };
    }

    // No errors, the control value is a valid number
    return null;
  }

  bool _validateNumberDecimals(int allowedDecimals, String numberString) {
    // Split the number string at the decimal point
    final parts = numberString.split('.');

    if (parts.length > 2) {
      // More than one decimal point, invalid format
      return false;
    }

    if (parts.length == 1) {
      // No decimal part, validate it has 0 decimals
      return allowedDecimals == 0;
    }

    // Check if the decimal part length is equal to the allowed decimals
    return parts[1].length == allowedDecimals;
  }
}
