import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

final reactiveSwitchTestingName = 'switch';

class ReactiveSwitchTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;

  const ReactiveSwitchTestingWidget({
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
          child: Column(
            children: <Widget>[
              ReactiveSwitch(
                formControlName: reactiveSwitchTestingName,
                focusNode: focusNode,
              ),
              ReactiveSwitch.adaptive(
                formControlName: reactiveSwitchTestingName,
                focusNode: focusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
