import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveCheckboxTestingName = 'isChecked';

class ReactiveCheckboxTestingWidget extends StatelessWidget {
  final FormGroup form;
  final bool tristate;
  final FocusNode? focusNode;
  final ReactiveFormFieldCallback<bool>? onChanged;

  const ReactiveCheckboxTestingWidget({
    super.key,
    required this.form,
    this.tristate = false,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveCheckbox(
                formControlName: reactiveCheckboxTestingName,
                tristate: tristate,
                focusNode: focusNode,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
