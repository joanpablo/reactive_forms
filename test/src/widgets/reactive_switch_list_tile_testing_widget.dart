import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

const switchListTileControl = 'switchListTile';

class ReactiveSwitchListTileTestingWidget extends StatelessWidget {
  final FormGroup form;
  final ReactiveFormFieldCallback<bool>? onChanged;
  final ReactiveFormFieldCallback<bool>? adaptativeOnChanged;
  final FocusNode? focusNode;
  final FocusNode? adaptativeFocusNode;
  final bool renderAdaptative;

  const ReactiveSwitchListTileTestingWidget({
    Key? key,
    required this.form,
    this.renderAdaptative = true,
    this.focusNode,
    this.adaptativeFocusNode,
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
                focusNode: focusNode,
              ),
              if (renderAdaptative)
                ReactiveSwitchListTile.adaptative(
                  formControlName: switchListTileControl,
                  onChanged: adaptativeOnChanged,
                  focusNode: adaptativeFocusNode,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
