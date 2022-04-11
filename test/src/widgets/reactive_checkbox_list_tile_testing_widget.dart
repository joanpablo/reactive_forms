import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const reactiveCheckboxListTileTestingName = 'isChecked';

class ReactiveCheckboxListTileTestingWidget extends StatelessWidget {
  final FormGroup form;
  final bool tristate;
  final FocusNode? focusNode;

  const ReactiveCheckboxListTileTestingWidget({
    Key? key,
    required this.form,
    this.tristate = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveCheckboxListTile(
                formControlName: reactiveCheckboxListTileTestingName,
                tristate: tristate,
                focusNode: focusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
