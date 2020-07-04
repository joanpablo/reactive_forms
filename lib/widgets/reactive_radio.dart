import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

/// This is a convenience widget that wraps a [Radio] widget in a
/// [ReactiveRadio].
///
/// The [formControlName] is required to bind this [ReactiveRadio]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Radio] class
/// and [new Radio], the constructor.
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
