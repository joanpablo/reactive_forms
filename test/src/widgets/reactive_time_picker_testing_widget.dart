import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTimePickerTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveTimePickerTestingWidget({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveTimePicker(
            formControlName: 'time',
            builder: (context, picker, child) {
              return TextButton(
                onPressed: picker.showPicker,
                child: const Text('Select Time'),
              );
            },
          ),
        ),
      ),
    );
  }
}
