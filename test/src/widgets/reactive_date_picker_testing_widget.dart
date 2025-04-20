import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDatePickerTestingWidget<T> extends StatelessWidget {
  final FormGroup form;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final DateTime? initialDate;

  const ReactiveDatePickerTestingWidget({
    super.key,
    required this.form,
    this.lastDate,
    this.firstDate,
    this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDate = this.firstDate ?? now.subtract(const Duration(days: 365));
    final lastDate = this.lastDate ?? now.add(const Duration(days: 365));

    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveDatePicker<T>(
            formControlName: 'birthday',
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            builder: (
              BuildContext context,
              ReactiveDatePickerDelegate<T> picker,
              Widget? child,
            ) {
              return TextButton(
                onPressed: picker.showPicker,
                child: const Text('Select Birthday'),
              );
            },
          ),
        ),
      ),
    );
  }
}
