import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveRadioListTileTestingName = 'radio';

class ReactiveRadioListTileTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;

  const ReactiveRadioListTileTestingWidget({
    Key? key,
    required this.form,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveRadioListTile(
            formControlName: reactiveRadioListTileTestingName,
            value: true,
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }
}
