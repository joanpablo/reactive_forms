import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveSliderTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveSliderTestingWidget({
    Key key,
    @required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: Column(
            children: <Widget>[
              ReactiveSlider(
                formControlName: 'sliderValue',
                max: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
