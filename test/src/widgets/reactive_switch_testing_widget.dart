import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/reactive_switch.dart';

class ReactiveSwitchTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveSwitchTestingWidget({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveSwitch(
                formControlName: 'switch',
              ),
              ReactiveSwitch.adaptive(
                formControlName: 'switch',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
