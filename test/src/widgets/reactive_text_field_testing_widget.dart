import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTextFieldTestingWidget extends StatelessWidget {
  final FormGroup form;
  final ValidationMessagesFunction validationMessages;
  final Map<String, String> bindings;
  final ShowErrorsFunction showErrors;

  const ReactiveTextFieldTestingWidget({
    Key key,
    @required this.form,
    this.validationMessages,
    this.showErrors,
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
                showErrors: showErrors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
