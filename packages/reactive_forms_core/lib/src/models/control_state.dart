// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// Represent the state of a [FormControl].
class ControlState<T> {
  final T? value;
  final bool? disabled;

  /// Constructs a state with a default [value] and a [disabled] status.
  ControlState({
    this.value,
    this.disabled,
  });
}
