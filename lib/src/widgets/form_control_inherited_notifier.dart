// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/inherited_streamer.dart';

/// Represents an Inherited Widget that exposes an [AbstractControl]
/// to its descendants and listen to changes in control
/// and rebuilds all the dependents widgets.
///
/// The [Listenable] is provided by the [notifierDelegate].
///
class FormControlInheritedStreamer extends InheritedStreamer {
  final AbstractControl control;

  FormControlInheritedStreamer({
    Key? key,
    required this.control,
    required Stream stream,
    required Widget child,
  }) : super(
          key: key,
          stream: stream,
          child: child,
        );
}
