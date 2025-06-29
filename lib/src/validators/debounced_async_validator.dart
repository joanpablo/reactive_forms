// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:reactive_forms/reactive_forms.dart';

/// Delays the execution of an [AsyncValidator] by a specified duration.
///
/// This validator is useful for scenarios where you want to delay validation
/// until the user has stopped typing for a certain period. It helps to
/// avoid excessive validation requests, for example, when validating a
/// username for availability against a remote server.
///
/// The [DebouncedAsyncValidator] should be used when you need to specify a
/// custom debounce time for a single validator. If you want to apply the same
/// debounce time to all asynchronous validators of a form control, it is
/// more convenient to use the [FormControl.asyncValidatorsDebounceTime]
/// property.
///
/// ## Example:
///
/// ```dart
/// final control = FormControl<String>(
///   asyncValidators: [
///     DebouncedAsyncValidator(
///       Validators.delegateAsync((control) async {
///         // Your validation logic here
///         return null;
///       }),
///       500, // Debounce time in milliseconds
///     ),
///   ],
/// );
/// ```
///
/// In this example, the validation will only be triggered after the user has
/// stopped typing for 500 milliseconds.
class DebouncedAsyncValidator extends AsyncValidator<dynamic> {
  final AsyncValidator<dynamic> _validator;
  final int _debounceTime;
  Timer? _debounceTimer;

  /// Creates a new instance of the [DebouncedAsyncValidator] class.
  ///
  /// The [validator] is the async validator to be debounced.
  /// The [debounceTime] is the duration in milliseconds to wait before
  /// validating the control.
  DebouncedAsyncValidator(
    this._validator,
    this._debounceTime,
  );

  @override
  Future<Map<String, dynamic>?> validate(AbstractControl<dynamic> control) {
    final completer = Completer<Map<String, dynamic>?>();
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: _debounceTime), () {
      completer.complete(_validator.validate(control));
    });
    return completer.future;
  }
}
