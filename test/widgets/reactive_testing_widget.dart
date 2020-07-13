import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTestingWidget extends StatelessWidget {
  final FormGroup form;
  final Map<String, String> validationMessages;
  final Map<String, String> bindings;

  const ReactiveTestingWidget({
    Key key,
    @required this.form,
    this.validationMessages,
    this.bindings = const {
      'textField': 'name',
    },
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: Column(
            children: <Widget>[
              ReactiveTextField(
                formControlName: this.bindings['textField'],
                validationMessages: this.validationMessages,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
