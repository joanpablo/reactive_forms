import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveSwitchListTileTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveSwitchListTileTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveSwitchListTile(
                formControlName: 'switchListTile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
