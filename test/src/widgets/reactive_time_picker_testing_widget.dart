import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTimePickerTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveTimePickerTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveTimePicker(
            formControlName: 'time',
            builder: (context, picker, child) {
              return TextButton(
                onPressed: picker.showPicker,
                child: Text('Select Time'),
              );
            },
          ),
        ),
      ),
    );
  }
}
