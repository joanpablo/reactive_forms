// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents the base class for all reactive widgets that requires to
/// manage focus througth the [control].
///
/// All reactive widgets that can get/remove focus from the UI like
/// [ReactiveTextField], [ReactiveRadio], [ReactiveCheckbox], and many others
/// inherit from this widget.
class ReactiveFocusableFormField<T, V> extends ReactiveFormField<T, V> {
  ReactiveFocusableFormField({
    super.key,
    super.formControlName,
    super.formControl,
    super.focusNode,
    super.showErrors,
    super.valueAccessor,
    super.validationMessages,
    required super.builder,
  });

  @override
  ReactiveFormFieldState<T, V> createState() =>
      ReactiveFocusableFormFieldState<T, V>();
}

/// Represents the state for a [ReactiveFocusableFormField].
///
/// This state is responsible to register focus subscriptions in order to
/// establish a relationship between a [control] and a widget for focus
/// management.
///
/// All states of reactive widgets that require managing focus through the
/// [control] should inherit from this class.
class ReactiveFocusableFormFieldState<T, V>
    extends ReactiveFormFieldState<T, V> {
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }

  @override
  Widget build(BuildContext context) {
    _setFocusNode(widget.focusNode);
    return super.build(context);
  }
}
