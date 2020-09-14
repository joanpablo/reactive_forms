// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/double_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/int_value_accessor.dart';

/// A [ReactiveTextField] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveTextField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTextField extends ReactiveFormField {
  /// Creates a [ReactiveTextField] that contains a [TextField].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// You can optionally set the [validationMessages].
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  ReactiveTextField({
    Key key,
    String formControlName,
    FormControl formControl,
    Map<String, String> validationMessages,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    GestureTapCallback onTap,
    List<TextInputFormatter> inputFormatters,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
    ScrollPhysics scrollPhysics,
    VoidCallback onSubmitted,
    ControlValueAccessor valueAccessor,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages ?? const {},
          builder: (ReactiveFormFieldState field) {
            final state = field as _ReactiveTextFieldState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            return TextField(
              controller: state._textController,
              focusNode: state._focusNode,
              decoration:
                  effectiveDecoration.copyWith(errorText: state.errorText),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              toolbarOptions: toolbarOptions,
              readOnly: readOnly,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              maxLengthEnforced: maxLengthEnforced,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onChanged: field.didChange,
              onTap: onTap,
              onSubmitted: onSubmitted != null ? (_) => onSubmitted() : null,
              inputFormatters: inputFormatters,
              enabled: field.control.enabled,
              cursorWidth: cursorWidth,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
            );
          },
        );

  @override
  ReactiveFormFieldState createState() => _ReactiveTextFieldState();
}

class _ReactiveTextFieldState extends ReactiveFormFieldState {
  TextEditingController _textController;
  FocusNode _focusNode = FocusNode();
  StreamSubscription _focusChangesSubscription;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: this.value?.toString());
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    this.unsubscribeControl();
    super.dispose();
  }

  @override
  void subscribeControl() {
    super.subscribeControl();
    _focusChangesSubscription =
        this.control.focusChanges.listen(_onFormControlFocusChanged);
  }

  @override
  Future<void> unsubscribeControl() async {
    await Future.wait([
      _focusChangesSubscription?.cancel(),
      super.unsubscribeControl(),
    ]);
  }

  @override
  void onControlValueChanged(value) {
    _textController.text = value == null ? '' : value.toString();
    super.updateValueFromControl(value);
  }

  @override
  ControlValueAccessor selectValueAccessor() {
    if (this.control is FormControl<int>) {
      return IntValueAccessor(control: this.control, formField: this);
    } else if (this.control is FormControl<double>) {
      return DoubleValueAccessor(control: this.control, formField: this);
    }

    return super.selectValueAccessor();
  }

  void _onFormControlFocusChanged(bool focused) {
    if (focused && !_focusNode.hasFocus) {
      _focusNode.requestFocus();
    } else if (!focused && _focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && !this.touched) {
      this.touch();
    }

    if (this.control.focused && !_focusNode.hasFocus) {
      this.control.unfocus();
    } else if (!this.control.focused && _focusNode.hasFocus) {
      this.control.focus();
    }
  }
}
