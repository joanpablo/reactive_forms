import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

/// A [ReactiveTextField] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveTextField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTextField extends ReactiveFormField<String> {
  /// Creates a [ReactiveTextField] that contains a [TextField].
  ///
  /// The [formControlName] is required to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// You can optionally set the [validationMessages].
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  ReactiveTextField({
    Key key,
    @required String formControlName,
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
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
    ScrollPhysics scrollPhysics,
  })  : assert(formControlName != null),
        assert(validationMessages != null),
        super(
            formControlName: formControlName,
            validationMessages: validationMessages,
            builder: (ReactiveFormFieldState<String> field) {
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
                onChanged: state.didChange,
                onTap: onTap,
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth,
                cursorRadius: cursorRadius,
                cursorColor: cursorColor,
                scrollPadding: scrollPadding,
                scrollPhysics: scrollPhysics,
                keyboardAppearance: keyboardAppearance,
                enableInteractiveSelection: enableInteractiveSelection,
                buildCounter: buildCounter,
              );
            });

  @override
  ReactiveFormFieldState<String> createState() => _ReactiveTextFieldState();
}

class _ReactiveTextFieldState extends ReactiveFormFieldState<String> {
  TextEditingController _textController;
  FocusNode _focusNode = FocusNode();
  StreamSubscription _focusChangeSubscription;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: control.value);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    this.unsubscribeFormControl();

    super.dispose();
  }

  @override
  void subscribeFormControl() {
    super.subscribeFormControl();
    _focusChangeSubscription =
        this.control.onFocusChanged.listen(_onFormControlFocusChanged);
  }

  @override
  void unsubscribeFormControl() {
    super.unsubscribeFormControl();
    _focusChangeSubscription.cancel();
  }

  @override
  void updateValueFromControl() {
    if (_textController.text == this.control.value) {
      return;
    }

    _textController.text = this.control.value;
    super.updateValueFromControl();
  }

  void _onFormControlFocusChanged(_) {
    if (this.control.focused && !_focusNode.hasFocus) {
      _focusNode.requestFocus();
    } else if (!this.control.focused && _focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && !this.control.touched) {
      this.touch();
    }

    if (this.control.focused && !_focusNode.hasFocus) {
      this.control.unfocus();
    } else if (!this.control.focused && _focusNode.hasFocus) {
      this.control.focus();
    }
  }
}
