import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDropdownTestingWidget extends StatelessWidget {
  final FormGroup form;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final Widget? disabledHint;
  final DropdownButtonBuilder? selectedItemBuilder;

  const ReactiveDropdownTestingWidget({
    Key? key,
    required this.form,
    required this.items,
    this.onChanged,
    this.readOnly = false,
    this.disabledHint,
    this.selectedItemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveDropdownField<String>(
            formControlName: 'dropdown',
            onChanged: this.onChanged,
            readOnly: this.readOnly,
            disabledHint: this.disabledHint,
            selectedItemBuilder: this.selectedItemBuilder,
            items: this.items.map<DropdownMenuItem<String>>(
              (item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
