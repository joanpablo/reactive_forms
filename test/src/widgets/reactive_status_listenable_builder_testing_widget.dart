import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveStatusListenableTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveStatusListenableTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveStatusListenableBuilder(
            formControlName: 'control',
            builder: (context, control, child) {
              switch (control.status) {
                case ControlStatus.pending:
                  return Text('pending');
                case ControlStatus.valid:
                  return Text('valid');
                default:
                  return Text('invalid');
              }
            },
          ),
        ),
      ),
    );
  }
}
