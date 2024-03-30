import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDropdownTestingWidget extends StatelessWidget {
  final FormGroup form;
  final List<String> items;
  final ReactiveFormFieldCallback<String>? onChanged;
  final ReactiveFormFieldCallback<String>? onTap;
  final bool readOnly;
  final Widget? disabledHint;
  final DropdownButtonBuilder? selectedItemBuilder;

  const ReactiveDropdownTestingWidget({
    super.key,
    required this.form,
    required this.items,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.disabledHint,
    this.selectedItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: ReactiveDropdownField<String>(
            formControlName: 'dropdown',
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            disabledHint: disabledHint,
            selectedItemBuilder: selectedItemBuilder,
            items: items.map<DropdownMenuItem<String>>(
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
