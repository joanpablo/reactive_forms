// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

/// Enums that represents the different
/// validation status of an [AbstractControl]
///
/// See [AbstractControl.status]
enum ControlStatus {
  /// The control is in the midst of conducting a validation check.
  pending,

  /// The control has passed all validation checks.
  valid,

  /// The control has failed at least one validation check.
  invalid,

  /// This control is exempt from validation checks.
  disabled,
}
