import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveValueListenableTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveValueListenableTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveValueListenableBuilder<String>(
            formControlName: 'name',
            builder: (context, control, child) {
              return Text(control.value ?? '');
            },
          ),
        ),
      ),
    );
  }
}
