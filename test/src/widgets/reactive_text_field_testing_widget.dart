import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTextFieldTestingWidget<T> extends StatelessWidget {
  final FormGroup form;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final Map<String, String> bindings;
  final ShowErrorsFunction<T>? showErrors;
  final FocusNode? focusNode;
  final ReactiveFormFieldCallback<T>? onChanged;
  final ReactiveFormFieldCallback<T>? onTap;
  final ReactiveFormFieldCallback<T>? onSubmitted;
  final ReactiveFormFieldCallback<T>? onEditingComplete;

  const ReactiveTextFieldTestingWidget({
    super.key,
    required this.form,
    this.validationMessages,
    this.showErrors,
    this.focusNode,
    this.bindings = const {'textField': 'name'},
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveTextField<T>(
                formControlName: bindings['textField'],
                validationMessages: validationMessages,
                showErrors: showErrors,
                focusNode: focusNode,
                onChanged: onChanged,
                onTap: onTap,
                onSubmitted: onSubmitted,
                onEditingComplete: onEditingComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
