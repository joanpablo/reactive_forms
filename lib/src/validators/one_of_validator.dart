import 'package:reactive_forms/reactive_forms.dart';

/// Represents a validator that requires the control's value to be one of
/// the values in the provided [collection].
///
/// For [String] values, the comparison can be made case-sensitive or insensitive
/// using the [caseSensitive] parameter. For other types, this parameter is ignored.
class OneOfValidator extends Validator<dynamic> {
  final List<dynamic> collection;
  final bool caseSensitive;

  /// Constructs an instance of [OneOfValidator].
  ///
  /// The [collection] parameter is the list of allowed values.
  /// The [caseSensitive] parameter determines if string comparison
  /// should be case-sensitive. Defaults to true.
  OneOfValidator(this.collection, {this.caseSensitive = true});

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final value = control.value;
    var found = false;

    for (final item in collection) {
      if (value is String && item is String && !caseSensitive) {
        if (item.toLowerCase() == value.toLowerCase()) {
          found = true;
          break;
        }
      } else {
        if (item == value) {
          found = true;
          break;
        }
      }
    }

    if (found) {
      return null; // Valid
    } else {
      return {
        ValidationMessage.oneOf: {
          'requiredOneOf': collection,
          'actual': value,
          if (value is String) 'caseSensitive': caseSensitive,
        },
      };
    }
  }
}
