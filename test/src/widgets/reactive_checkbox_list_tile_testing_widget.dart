import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveCheckboxListTileTestingWidget extends StatelessWidget {
  final FormGroup form;
  final bool tristate;

  const ReactiveCheckboxListTileTestingWidget({
    Key? key,
    required this.form,
    this.tristate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: Column(
            children: <Widget>[
              ReactiveCheckboxListTile(
                formControlName: 'isChecked',
                tristate: tristate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
