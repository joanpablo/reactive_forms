import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

class ReactiveCheckbox extends ReactiveFormField<bool> {
  ReactiveCheckbox({
    Key key,
    @required String formControlName,
    bool tristate = false,
    Color activeColor,
    Color checkColor,
    Color focusColor,
    Color hoverColor,
    MaterialTapTargetSize materialTapTargetSize,
    VisualDensity visualDensity,
  }) : super(
          key: key,
          formControlName: formControlName,
          validationMessages: const {},
          builder: (ReactiveFormFieldState<bool> field) {
            return Checkbox(
              value: field.value,
              onChanged: field.didChange,
              tristate: tristate,
              activeColor: activeColor,
              checkColor: checkColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              materialTapTargetSize: materialTapTargetSize,
              visualDensity: visualDensity,
            );
          },
        );

  @override
  ReactiveFormFieldState<bool> createState() => ReactiveFormFieldState<bool>();
}
