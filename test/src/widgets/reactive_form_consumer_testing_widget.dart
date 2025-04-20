import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormConsumerTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveFormConsumerTestingWidget({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveFormConsumer(
            builder: (context, form, child) {
              return ElevatedButton(
                onPressed: form.valid ? () {} : null,
                child: Container(),
              );
            },
          ),
        ),
      ),
    );
  }
}
