// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// Represents a focus controller for a [FormControl].
class FocusController extends ChangeNotifier {
  bool _hasFocus = false;
  bool disposed = false;
  final FocusNode _focusNode;
  final bool _shouldDisposeFocusNode;
  bool _modelToViewChanges = false;

  /// Constructs an instance of the focus controller.
  ///
  /// If not [focusNode] is provided, then a FocusNode is created by default.
  ///
  /// If the [focusNode] is provided then the focus controller will not dispose
  /// it and [focusNode] must be explicitly dispose after dispose focus
  /// controller instance.
  FocusController({FocusNode? focusNode})
      : _focusNode = focusNode ?? FocusNode(),
        _shouldDisposeFocusNode = focusNode == null {
    this.focusNode.addListener(_onFocusNodeFocusChanges);
  }

  /// Gets the focus state of the focus controller.
  bool get hasFocus => _hasFocus;

  /// Gets the UI focus node registered with the controller.
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

    updateFocus(hasFocus);
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusNodeFocusChanges);
    if (_shouldDisposeFocusNode) {
      focusNode.dispose();
    }
    disposed = true;
    super.dispose();
  }

  void _onFocusNodeFocusChanges() {
    if (_modelToViewChanges) {
      _modelToViewChanges = false;
      return;
    }

    if (hasFocus && !focusNode.hasFocus) {
      updateFocus(false);
    } else if (!hasFocus && focusNode.hasFocus) {
      updateFocus(true);
    }
  }
}
