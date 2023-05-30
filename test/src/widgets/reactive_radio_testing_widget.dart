import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveRadioTestingName = 'radio';

class ReactiveRadioTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;
  final ReactiveFormFieldCallback<bool>? onChanged;

  const ReactiveRadioTestingWidget({
    Key? key,
    required this.form,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveRadio(
            formControlName: reactiveRadioTestingName,
            value: true,
            focusNode: focusNode,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
