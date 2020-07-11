import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveTestingWidget({
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
              ReactiveTextField(formControlName: 'name'),
            ],
          ),
        ),
      ),
    );
  }
}
