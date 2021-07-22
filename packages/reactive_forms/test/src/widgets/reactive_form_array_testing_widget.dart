import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_core/reactive_forms_core.dart';

class ReactiveFormArrayTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveFormArrayTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveFormArray(
            formArrayName: 'array',
            builder: (context, array, child) {
              return Column(
                children: array.value!
                    .map((value) => Text(value.toString()))
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
