import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveRadioTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveRadioTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveRadio(
            formControlName: 'radio',
            value: true,
          ),
        ),
      ),
    );
  }
}
