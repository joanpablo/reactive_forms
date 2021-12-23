import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveSliderTestingName = 'sliderValue';

class ReactiveSliderTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;

  const ReactiveSliderTestingWidget({
    Key? key,
    required this.form,
    this.focusNode,
  }) : super(key: key);

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
