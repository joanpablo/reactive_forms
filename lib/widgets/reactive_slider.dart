import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

typedef ReactiveSliderLabelBuilder = String Function(double);

class ReactiveSlider extends ReactiveFormField<double> {
  ReactiveSlider({
    Key key,
    @required String formControlName,
    double min = 0.0,
    double max = 1.0,
    int divisions,
    ReactiveSliderLabelBuilder labelBuilder,
    Color activeColor,
    Color inactiveColor,
    SemanticFormatterCallback semanticFormatterCallback,
  }) : super(
          formControlName: formControlName,
          validationMessages: const {},
          builder: (ReactiveFormFieldState<double> field) {
            return Slider(
              value: field.value,
              onChanged: field.didChange,
              min: min,
              max: max,
              divisions: divisions,
              label: labelBuilder != null ? labelBuilder(field.value) : null,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              semanticFormatterCallback: semanticFormatterCallback,
            );
          },
        );

  @override
  ReactiveFormFieldState<double> createState() =>
      ReactiveFormFieldState<double>();
}
