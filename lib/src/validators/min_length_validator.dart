// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that validates whether the value meets a minimum length
/// requirement.
class MinLengthValidator extends Validator<dynamic> {
  final int minLength;

  /// Constructs a [MinLengthValidator].
  ///
  /// The argument [minLength] argument must not be null.
  MinLengthValidator(this.minLength);

  @override
  Map<String, Object>? validate(AbstractControl<dynamic> control) {
    // don't validate empty values to allow optional controls
    if (control.value == null) {
      return null;
    }

    List<dynamic>? collection;

    if (control is FormArray<dynamic>) {
      collection = control.value!;
    } else if (control is FormGroup) {
      collection = control.value.keys.toList();
    } else if (control is FormControl<Iterable<dynamic>>) {
      collection = control.value?.toList();
    } else if (control is FormControl<String> || control.value is String) {
      collection = control.value.toString().runes.toList();
    }

    return (collection != null && collection.length >= this.minLength)
        ? null
        : {
            ValidationMessage.minLength: {
              'requiredLength': this.minLength,
              'actualLength': collection != null ? collection.length : 0,
            }
          };
  }
}
