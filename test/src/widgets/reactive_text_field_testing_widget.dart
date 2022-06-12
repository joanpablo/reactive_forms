import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTextFieldTestingWidget<T> extends StatelessWidget {
  final FormGroup form;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final Map<String, String> bindings;
  final ShowErrorsFunction? showErrors;
  final FocusNode? focusNode;

  const ReactiveTextFieldTestingWidget({
    Key? key,
    required this.form,
    this.validationMessages,
    this.showErrors,
    this.focusNode,
    this.bindings = const {
      'textField': 'name',
    },
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveTextField<T>(
                formControlName: bindings['textField'],
                validationMessages: validationMessages,
                showErrors: showErrors,
                focusNode: focusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
