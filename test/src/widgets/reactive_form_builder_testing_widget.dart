import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormBuilderTestingWidget<T> extends StatelessWidget {
  final FormGroup form;
  final ValidationMessagesFunction<T>? validationMessages;
  final Map<String, String> bindings;

  const ReactiveFormBuilderTestingWidget({
    Key? key,
    required this.form,
    this.validationMessages,
    this.bindings = const {
      'textField': 'name',
    },
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveFormBuilder(
          form: () => form,
          builder: (context, form, child) {
            return Column(
              children: <Widget>[
                ReactiveTextField<T>(
                  formControlName: bindings['textField'],
                  validationMessages: validationMessages,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
