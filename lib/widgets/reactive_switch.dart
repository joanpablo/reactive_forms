import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

class ReactiveSwitch extends ReactiveFormField<bool> {
  ReactiveSwitch({
    Key key,
    @required String formControlName,
    Color activeColor,
    Color activeTrackColor,
    Color inactiveThumbColor,
    Color inactiveTrackColor,
    ImageProvider activeThumbImage,
    ImageErrorListener onActiveThumbImageError,
    ImageProvider inactiveThumbImage,
    ImageErrorListener onInactiveThumbImageError,
    MaterialTapTargetSize materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color focusColor,
    Color hoverColor,
  }) : super(
          formControlName: formControlName,
          validationMessages: const {},
          builder: (ReactiveFormFieldState<bool> field) {
            return Switch(
              key: key,
              value: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              onActiveThumbImageError: onActiveThumbImageError,
              inactiveThumbImage: inactiveThumbImage,
              onInactiveThumbImageError: onInactiveThumbImageError,
              materialTapTargetSize: materialTapTargetSize,
              dragStartBehavior: dragStartBehavior,
            );
          },
        );

  ReactiveSwitch.adaptive({
    Key key,
    @required String formControlName,
    Color activeColor,
    Color activeTrackColor,
    Color inactiveThumbColor,
    Color inactiveTrackColor,
    ImageProvider activeThumbImage,
    ImageErrorListener onActiveThumbImageError,
    ImageProvider inactiveThumbImage,
    ImageErrorListener onInactiveThumbImageError,
    MaterialTapTargetSize materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color focusColor,
    Color hoverColor,
  }) : super(
          formControlName: formControlName,
          validationMessages: const {},
          builder: (ReactiveFormFieldState<bool> field) {
            return Switch.adaptive(
              key: key,
              value: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              onActiveThumbImageError: onActiveThumbImageError,
              inactiveThumbImage: inactiveThumbImage,
              onInactiveThumbImageError: onInactiveThumbImageError,
              materialTapTargetSize: materialTapTargetSize,
              dragStartBehavior: DragStartBehavior.start,
              focusColor: focusColor,
              hoverColor: hoverColor,
            );
          },
        );

  @override
  ReactiveFormFieldState<bool> createState() => ReactiveFormFieldState<bool>();
}
