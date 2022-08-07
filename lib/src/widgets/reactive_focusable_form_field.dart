// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// TODO: add documentation
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

/// TODO: add documentation
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
