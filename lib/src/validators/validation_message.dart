// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// This class is an utility for getting access to common names of
/// validation messages.
///
/// ## Example
///
/// ```dart
/// ReactiveTextField(
///   formControlName: 'email',
///   validationMessages: {
///     ValidationMessage.required: 'The Email must not be empty',
///     ValidationMessage.email: 'The Email must be a valid email'
///   },
/// );
/// ```
class ValidationMessage {
  /// Key text for required validation message.
  static const String required = 'required';

  /// Key text for pattern validation message.
  static const String pattern = 'pattern';

  /// Key text for number validation message.
  static const String number = 'number';

  /// Key text for must match validation message.
  static const String mustMatch = 'mustMatch';

  /// Key text for min length validation message.
  static const String minLength = 'minLength';

  /// Key text for max length validation message.
  static const String maxLength = 'maxLength';

  /// Key text for email validation message.
  static const String email = 'email';

  /// Key text for credit card numbers validation message.
  static const String creditCard = 'creditCard';

  /// Key text for max validation message.
  static const String max = 'max';

  /// Key text for min validation message.
  static const String min = 'min';

  /// Key text for `equals` validation message.
  static const String equals = 'requiredEquals';

  /// Key text for `requiredTrue` validation message.
  static const String requiredTrue = 'requiredEquals';

  /// Key text for group compare validation message.
  static const String compare = 'compare';

  /// Key text for `contains` validation message.
  static const String contains = 'contains';

  /// Key text for `any` validation message.
  static const String any = 'any';
}
