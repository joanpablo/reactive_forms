import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveRadioListTileTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveRadioListTileTestingWidget({
    Key key,
    @required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveRadioListTile(
            formControlName: 'radio',
            value: true,
          ),
        ),
      ),
    );
  }
}
