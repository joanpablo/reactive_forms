// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

/// Signature for callbacks that are used to get
/// the label of the [ReactiveSlider].
typedef ReactiveSliderLabelBuilder = String Function(double);

/// This is a convenience widget that wraps a [Slider] widget in a
/// [ReactiveSlider].
///
/// The [formControlName] is required to bind this [ReactiveSlider]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Slider] class
/// and [new Slider], the constructor.
class ReactiveSlider extends ReactiveFormField<double> {
  /// Creates an instance os a [ReactiveSlider].
  ///
  /// The [formControlName] must not be null.
  ///
  /// The [labelBuilder] is called each time the [FormControl] changes its value
  /// so you can supply a label to the Slider.
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
