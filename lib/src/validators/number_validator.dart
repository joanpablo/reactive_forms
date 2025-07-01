// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/validators/number_validator_error.dart';

/// A validator that checks if a control's value represents a valid number.
///
/// This validator can be used for both `String` and `num` types. It provides
/// options to allow or disallow null values, negative numbers, and to specify
/// the number of allowed decimal places.
///
/// ## Example:
///
/// ```dart
/// final control = FormControl<String>(
///   validators: [Validators.number()],
/// );
///
/// control.value = '123';
/// print(control.valid); // true
///
/// control.value = 'abc';
/// print(control.valid); // false
///
/// control.value = '12.34';
/// print(control.valid); // false, because decimals are not allowed by default
/// ```
///
/// To allow decimals, you can use the `allowedDecimals` parameter:
///
/// ```dart
/// final decimalControl = FormControl<String>(
///   validators: [Validators.number(allowedDecimals: 2)],
/// );
///
/// decimalControl.value = '12.34';
/// print(decimalControl.valid); // true
///
/// decimalControl.value = '12.345';
/// print(decimalControl.valid); // false, as it exceeds the allowed decimal places
/// ```
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
  /// [allowNull] (optional): Whether the validator allows null values.
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

    if (parts.length > 2 || numberString == '.' || numberString.endsWith('.')) {
      // More than one decimal point, invalid format
      return false;
    }

    if (parts.length == 1) {
      // No decimal part, so it's valid
      return true;
    }

    // Check if the decimal part length is within the allowed limit
    return parts[1].length <= allowedDecimals;
  }
}
