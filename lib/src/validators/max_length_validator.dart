// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that validates that the length of the control's value
/// doesn't exceed the maximum allowed limit.
class MaxLengthValidator extends Validator<dynamic> {
  final int maxLength;

  /// Constructs a [MaxLengthValidator].
  ///
  /// The argument [maxLength] must not be null.
  MaxLengthValidator(this.maxLength);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic>? control) {
    // don't validate empty values to allow optional controls
    if (control?.value == null) {
      return null;
    }

    List<dynamic>? collection;

    if (control is FormArray<dynamic>) {
      collection = control.value;
    } else if (control is FormGroup) {
      collection = control.value?.keys.toList();
    } else if (control is FormControl<Iterable<dynamic>>) {
      collection = control.value?.toList();
    } else if (control is FormControl<String> || control?.value is String) {
      collection = control?.value.runes.toList();
    }

    // ignore: unnecessary_null_comparison
    return (collection == null || collection.length <= this.maxLength)
        ? null
        : {
            ValidationMessage.maxLength: {
              'requiredLength': this.maxLength,
              'actualLength': collection.length,
            }
          };
  }
}
