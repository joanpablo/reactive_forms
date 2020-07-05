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
  static const String required = 'required';
  static const String pattern = 'pattern';
  static const String number = 'number';
  static const String mustMatch = 'mustMatch';
  static const String minLength = 'minLength';
  static const String maxLength = 'maxLength';
  static const String email = 'email';
}
