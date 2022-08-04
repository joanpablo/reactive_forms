import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const switchListTileControl = 'switchListTile';

class ReactiveSwitchListTileTestingWidget extends StatelessWidget {
  final FormGroup form;
  final ReactiveFormFieldCallback<bool>? onChanged;
  final ReactiveFormFieldCallback<bool>? adaptativeOnChanged;

  const ReactiveSwitchListTileTestingWidget({
    Key? key,
    required this.form,
    this.onChanged,
    this.adaptativeOnChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveSwitchListTile(
                formControlName: switchListTileControl,
                onChanged: onChanged,
              ),
              ReactiveSwitchListTile.adaptative(
                formControlName: switchListTileControl,
                onChanged: adaptativeOnChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
