// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents an Inherited Widget that exposes an [AbstractControl]
/// to its descendants and listen to changes in control
/// and rebuilds all the dependents widgets.
///
/// The [Listenable] is provided by the [notifierDelegate].
///
class FormControlInheritedStreamer extends InheritedStreamer<dynamic> {
  /// The control that this widget will be listening to.
  final AbstractControl<Object> control;

  FormControlInheritedStreamer({
    Key? key,
    required this.control,
    required Stream<dynamic> stream,
    required Widget child,
  }) : super(stream, child, key: key);
}
