import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

class ReactiveCheckboxTestingWidget extends StatelessWidget {
  final FormGroup form;
  final bool tristate;

  const ReactiveCheckboxTestingWidget({
    Key? key,
    required this.form,
    this.tristate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveCheckbox(
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
