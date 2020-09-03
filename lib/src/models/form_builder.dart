import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/exceptions/form_builder_invalid_initialization_exception.dart';

/// Creates an [AbstractControl] from a user-specified configuration.
class FormBuilder {
  /// Construct a new [FormGroup] instance.
  ///
  /// The [controls] argument must not be null.
  ///
  /// Can optionally provide a [validators] collection for the group.
  ///
  /// ### Example:
  ///
  /// Creates a group with a control that has a default value.
  /// ```dart
  /// final form = fb.group({
  ///   'name': 'John Doe',
  /// });
  /// ```
  ///
  /// Creates a group with a control that has a default value.
  /// ```dart
  /// final form = fb.group({
  ///   'name': ['John Doe'],
  /// });
  /// ```
  ///
  /// Creates a group with a control that has a default value and a validator.
  /// ```dart
  /// final form = fb.group({
  ///   'name': ['John Doe', Validators.required],
  /// });
  /// ```
  ///
  /// Creates a group with a control that has a validator.
  /// ```dart
  /// final form = fb.group({
  ///   'name': Validators.required,
  /// });
  /// ```
  ///
  /// Creates a group with a control that has several validators.
  /// ```dart
  /// final form = fb.group({
  ///   'email': [Validators.required, Validators.email],
  /// });
  /// ```
  FormGroup group(Map<String, dynamic> controls,
      [List<ValidatorFunction> validators = const []]) {
    final map = controls.map((key, value) {
      if (value is String) {
        return MapEntry(key, FormControl<String>(value: value));
      } else if (value is int) {
        return MapEntry(key, FormControl<int>(value: value));
      } else if (value is bool) {
        return MapEntry(key, FormControl<bool>(value: value));
      } else if (value is double) {
        return MapEntry(key, FormControl<double>(value: value));
      } else if (value is AbstractControl) {
        return MapEntry(key, value);
      } else if (value is ValidatorFunction) {
        return MapEntry(key, FormControl(validators: [value]));
      } else if (value is Iterable<ValidatorFunction>) {
        return MapEntry(key, FormControl(validators: value));
      } else if (value is Iterable<dynamic>) {
        if (value.isEmpty) {
          return MapEntry(key, FormControl());
        } else {
          final defaultValue = value.first;
          final validators = List.of(value.skip(1));

          if (validators.isNotEmpty &&
              validators
                  .any((validator) => !(validator is ValidatorFunction))) {
            throw FormBuilderInvalidInitializationException(
                'Invalid validators initialization');
          }

          if (defaultValue is ValidatorFunction) {
            throw FormBuilderInvalidInitializationException(
                'Expected first value in array to be default value of the control and not a validator.');
          }

          final effectiveValidators = validators
              .map<ValidatorFunction>((v) => v as ValidatorFunction)
              .toList();
          final control = _control(defaultValue, effectiveValidators);
          return MapEntry(key, control);
        }
      }

      return MapEntry(key, FormControl(value: value));
    });

    return FormGroup(map, validators: validators);
  }

  FormControl _control(dynamic value, List<ValidatorFunction> validators) {
    if (value is AbstractControl) {
      throw FormBuilderInvalidInitializationException(
          'Default value of control must not be an AbstractControl.');
    }

    if (value is String) {
      return FormControl<String>(value: value, validators: validators);
    } else if (value is int) {
      return FormControl<int>(value: value, validators: validators);
    } else if (value is bool) {
      return FormControl<bool>(value: value, validators: validators);
    } else if (value is double) {
      return FormControl<double>(value: value, validators: validators);
    }

    return FormControl(value: value, validators: validators);
  }
}

/// Global [FormBuilder] instance.
final fb = FormBuilder();
