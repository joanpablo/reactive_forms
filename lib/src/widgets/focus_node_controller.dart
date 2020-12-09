import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Focus controller that acts as a bridge between a
/// [FocusNode] and a [FormControl].
class FocusNodeController extends FocusController {
  final FocusNode focusNode;
  bool _modelToViewChanges = false;
  final bool _isLocalFocusNode;

  /// Constructs and instance of [FocusNodeController].
  ///
  /// Can optionally provide a [focusNode].
  FocusNodeController({
    FocusNode focusNode,
  })  : _isLocalFocusNode = (focusNode == null),
        focusNode = (focusNode ?? FocusNode()) {
    this.focusNode.addListener(_onFocusNodeFocusChanges);
  }

  /// Disposes a focus controller
  ///
  /// Disposes the [focusNode] if it was created locally. If [focusNode] was
  /// provided in constructor, then it must be explicitly disposed.
  void dispose() {
    this.focusNode.removeListener(_onFocusNodeFocusChanges);
    if (this._isLocalFocusNode) {
      this.focusNode.dispose();
    }
    super.dispose();
  }

  /// Call this method to update the focus state of the [FocusNode].
  ///
  /// This method is called by the [FormControl] when it updates focus
  /// programmatically.
  @override
  void onControlFocusChanged(bool hasFocus) {
    _modelToViewChanges = true;

    if (hasFocus && !focusNode.hasFocus) {
      focusNode.requestFocus();
    } else if (!hasFocus && focusNode.hasFocus) {
      focusNode.unfocus();
    }

    this.updateFocus(hasFocus);
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
