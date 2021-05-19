// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
class ReactiveSlider extends ReactiveFormField<num, double> {
  /// Creates an instance os a [ReactiveSlider].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The [labelBuilder] is called each time the [FormControl] changes its value
  /// so you can supply a label to the Slider.
  ReactiveSlider({
    Key? key,
    String? formControlName,
    FormControl<num>? formControl,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    ReactiveSliderLabelBuilder? labelBuilder,
    Color? activeColor,
    Color? inactiveColor,
    SemanticFormatterCallback? semanticFormatterCallback,
    ValueChanged<double>? onChangeEnd,
    ValueChanged<double>? onChangeStart,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<num, double> field) {
            var value = field.value;
            if (value == null) {
              value = min;
            } else if (value < min) {
              value = min;
            } else if (value > max) {
              value = max;
            }

            return Slider(
              value: value,
              onChanged: field.control.enabled ? field.didChange : null,
              min: min,
              max: max,
              divisions: divisions,
              label: labelBuilder != null
                  ? labelBuilder(field.value ?? min)
                  : null,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              semanticFormatterCallback: semanticFormatterCallback,
              onChangeEnd: onChangeEnd,
              onChangeStart: onChangeStart,
            );
          },
        );

  @override
  ReactiveFormFieldState<num, double> createState() => _ReactiveSliderState();
}

class _ReactiveSliderState extends ReactiveFormFieldState<num, double> {
  @override
  ControlValueAccessor<num, double> selectValueAccessor() {
    if (control is FormControl<int>) {
      return SliderIntValueAccessor();
    }

    return super.selectValueAccessor();
  }
}
