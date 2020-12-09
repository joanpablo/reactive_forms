// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Represents a focus controller for a [FormControl].
class FocusController extends ChangeNotifier {
  bool _hasFocus = false;
  bool disposed = false;
  final FocusNode _focusNode;
  final bool _shouldDisposeFocusNode;
  bool _modelToViewChanges = false;

  FocusController({FocusNode focusNode})
      : _focusNode = (focusNode ?? FocusNode()),
        _shouldDisposeFocusNode = (focusNode == null) {
    this.focusNode.addListener(_onFocusNodeFocusChanges);
  }

  /// Gets the focus state of the focus controller.
  bool get hasFocus => _hasFocus;

  FocusNode get focusNode => _focusNode;

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
  void onControlFocusChanged(bool hasFocus) {
    _modelToViewChanges = true;

    if (hasFocus && !focusNode.hasFocus) {
      focusNode.requestFocus();
    } else if (!hasFocus && focusNode.hasFocus) {
      focusNode.unfocus();
    }

    this.updateFocus(hasFocus);
  }

  @override
  void dispose() {
    this.focusNode.removeListener(_onFocusNodeFocusChanges);
    if (this._shouldDisposeFocusNode) {
      this.focusNode.dispose();
    }
    this.disposed = true;
    super.dispose();
  }

  void _onFocusNodeFocusChanges() {
    if (_modelToViewChanges) {
      _modelToViewChanges = false;
      return;
    }

    if (this.hasFocus && !focusNode.hasFocus) {
      this.updateFocus(false);
    } else if (!this.hasFocus && focusNode.hasFocus) {
      this.updateFocus(true);
    }
  }
}
