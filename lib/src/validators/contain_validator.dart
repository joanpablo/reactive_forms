// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

/// Validator that requires the control's array contains all provided values.
class ContainValidator<T> extends Validator {
  final List<T> valuesToCompare;

  /// Constructs the instance of the validator.
  ///
  /// The argument [valuesToCompare] must not be null.
  ContainValidator(this.valuesToCompare) : assert(valuesToCompare != null);

  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final error = {ValidationMessage.contain: true};

    // error if value is not a List
    if (control.value != null && !(control.value is List<T>)) {
      return error;
    }

    bool allItemAreInIt = valuesToCompare.where((element) => control.value.contains(element)).toList().length == valuesToCompare.length;
    return (control.value == null ||
            control.value == '' ||
            allItemAreInIt)
        ? null
        : error;
  }
}
