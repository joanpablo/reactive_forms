import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class SimpleSample extends StatelessWidget {
  FormGroup get form => fb.group(<String, dynamic>{
        'name': ['', Validators.required],
        'sendNotifications': [false, Validators.required],
      });

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('Simple sample'),
      body: ReactiveFormBuilder(
        form: () => form,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validationMessages: (errors) => {
                  ValidationMessage.required: 'Name must not be empty',
                },
              ),
              ReactiveRadioListTile(
                title: const Text('Send notifications'),
                value: true,
                formControlName: 'sendNotifications',
              ),
              ReactiveRadioListTile(
                title: const Text('Don\'t send'),
                value: false,
                formControlName: 'sendNotifications',
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    child: const Text('CONTINUE'),
                    onPressed: form.valid ? () => print(form.value) : null,
                  );
                },
              ),
              ElevatedButton(
                child: const Text('RESET'),
                onPressed: () => form.reset(),
              ),
            ],
          );
        },
      ),
    );
  }
}
