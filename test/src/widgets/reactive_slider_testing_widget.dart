import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveSliderTestingName = 'sliderValue';

class ReactiveSliderTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;
  final ReactiveSliderLabelBuilder? labelBuilder;
  final ReactiveFormFieldCallback<num>? onChangeEnd;
  final ReactiveFormFieldCallback<num>? onChangeStart;
  final ReactiveFormFieldCallback<num>? onChanged;

  const ReactiveSliderTestingWidget({
    super.key,
    required this.form,
    this.focusNode,
    this.labelBuilder,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveSlider(
                formControlName: reactiveSliderTestingName,
                max: 100,
                focusNode: focusNode,
                labelBuilder: labelBuilder,
                onChanged: onChanged,
                onChangeStart: onChangeStart,
                onChangeEnd: onChangeEnd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
