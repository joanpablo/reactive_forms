import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormBuilderWidgetSample extends StatelessWidget {
  FormGroup get form => fb.group({
        'name': ['', Validators.required],
        'sendNotifications': [null, Validators.required],
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReactiveFormBuilder(
          form: () => this.form,
          builder: (context, form, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'name',
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validationMessages: (errors) => {
                      ValidationMessage.required: 'Name must not be empty',
                    },
                  ),
                  ReactiveRadioListTile(
                    title: Text('Send notifications'),
                    value: true,
                    formControlName: 'sendNotifications',
                  ),
                  ReactiveRadioListTile(
                    title: Text('Don\'t send'),
                    value: false,
                    formControlName: 'sendNotifications',
                  ),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return RaisedButton(
                        child: Text('CONTINUE'),
                        onPressed: form.valid ? () => print(form.value) : null,
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('RESET'),
                    onPressed: () => form.reset(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
