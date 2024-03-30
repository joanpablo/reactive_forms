import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveRadioListTileTestingName = 'radio';

class ReactiveRadioListTileTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;
  final ReactiveFormFieldCallback<bool>? onChanged;

  const ReactiveRadioListTileTestingWidget({
    super.key,
    required this.form,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveRadioListTile<bool>(
            formControlName: reactiveRadioListTileTestingName,
            value: true,
            focusNode: focusNode,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
