import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

class ReactiveRadio<T> extends ReactiveFormField<T> {
  ReactiveRadio({
    Key key,
    @required String formControlName,
    @required T value,
    Color activeColor,
    Color focusColor,
    Color hoverColor,
    MaterialTapTargetSize materialTapTargetSize,
    VisualDensity visualDensity,
  }) : super(
          formControlName: formControlName,
          validationMessages: const {},
          builder: (ReactiveFormFieldState<T> field) {
            return Radio<T>(
              value: value,
              groupValue: field.value,
              onChanged: field.didChange,
              activeColor: activeColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              materialTapTargetSize: materialTapTargetSize,
              visualDensity: visualDensity,
            );
          },
        );

  @override
  ReactiveFormFieldState<T> createState() => ReactiveFormFieldState<T>();
}
