import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FocusController {
  FormControl control;
  final FocusNode focusNode;
  StreamSubscription _subscription;

  FocusController({
    FocusNode focusNode,
  }) : focusNode = (focusNode ?? FocusNode()) {
    this.focusNode.addListener(_onFocusNodeFocusChanges);
  }

  void registerControl(FormControl control) {
    this.control = control;
    _subscription = this.control.focusChanges.listen(_onControlFocusChanged);
  }

  void dispose() {
    _subscription.cancel();
    this.focusNode.removeListener(_onFocusNodeFocusChanges);
  }

  FocusEvent _focusEvent;
  void _onControlFocusChanged(FocusEvent focusEvent) {
    _focusEvent = focusEvent;

    if (focusEvent.hasFocus && !focusNode.hasFocus) {
      focusNode.requestFocus();
    } else if (!focusEvent.hasFocus && focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  void _onFocusNodeFocusChanges() {
    // marks control as touched if event.touched = true or it's not touched
    final shouldMarkAsTouched =
        _focusEvent != null ? _focusEvent.markAsTouched : !this.control.touched;

    if (!focusNode.hasFocus && shouldMarkAsTouched) {
      this.control.markAsTouched();
    }

    if (this.control.hasFocus && !focusNode.hasFocus) {
      this.control.unfocus();
    } else if (!this.control.hasFocus && focusNode.hasFocus) {
      this.control.focus();
    }

    _focusEvent = null;
  }
}
