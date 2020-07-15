import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDropdownTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveDropdownTestingWidget({
    Key key,
    @required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveDropdownField<bool>(
            formControlName: 'dropdown',
            items: [
              DropdownMenuItem(
                value: true,
                child: Text('true'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('false'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
