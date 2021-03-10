import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDatePickerTestingWidget<T> extends StatelessWidget {
  final FormGroup form;
  final DateTime? lastDate;

  const ReactiveDatePickerTestingWidget({
    Key? key,
    required this.form,
    this.lastDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveDatePicker<T>(
            formControlName: 'birthday',
            firstDate: DateTime(1985),
            lastDate: lastDate ?? DateTime(2050),
            builder: (BuildContext context,
                ReactiveDatePickerDelegate<T> picker, Widget? child) {
              return TextButton(
                onPressed: picker.showPicker,
                child: Text('Select Birthday'),
              );
            },
          ),
        ),
      ),
    );
  }
}
