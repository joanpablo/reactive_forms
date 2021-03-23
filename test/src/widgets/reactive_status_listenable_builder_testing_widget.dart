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
          formGroup: form,
          child: ReactiveStatusListenableBuilder(
            formControlName: 'control',
            builder: (context, control, child) {
              switch (control.status) {
                case ControlStatus.pending:
                  return const Text('pending');
                case ControlStatus.valid:
                  return const Text('valid');
                default:
                  return const Text('invalid');
              }
            },
          ),
        ),
      ),
    );
  }
}
