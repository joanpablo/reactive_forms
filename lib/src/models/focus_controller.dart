// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

/// Represents a focus controller for a [FormControl].
abstract class FocusController extends ChangeNotifier {
  bool _hasFocus = false;
  bool disposed = false;

  /// Gets the focus state of the focus controller.
  bool get hasFocus => _hasFocus;

  /// Update the focus state for controller.
  ///
  /// Provide the [hasFocus] argument to set the focus state.
  ///
  /// If [emitEvent] is true or not provided (the default) then an event is
  /// triggered with the new focus state. If is false no event is triggered.
  void updateFocus(bool hasFocus, {bool emitEvent = true}) {
    if (_hasFocus != hasFocus) {
      _hasFocus = hasFocus;
      if (emitEvent && !disposed) {
        notifyListeners();
      }
    }
  }

  /// This method is called from [FormControl] to notify the controller that
  /// the focus in the control has changed.
  ///
  /// The [hasFocus] argument represents the state of the [FormControl].
  void onControlFocusChanged(bool hasFocus);

  @override
  void dispose() {
    this.disposed = true;
    super.dispose();
  }
}
