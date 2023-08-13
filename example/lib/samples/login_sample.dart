import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class LoginSample extends StatelessWidget {
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        'acceptTerms': FormControl<bool>(
          value: false,
          validators: [Validators.requiredTrue],
        ),
      });

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('Login sample'),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReactiveTextField<String>(
                formControlName: 'email',
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      'The email must not be empty',
                  ValidationMessage.email: (_) =>
                      'The email value must be a valid email',
                  'unique': (_) => 'This email is already in use',
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              const SizedBox(height: 16.0),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      'The password must not be empty',
                  ValidationMessage.minLength: (_) =>
                      'The password must be at least 8 characters',
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              const SizedBox(height: 16.0),
              ReactiveCheckboxListTile(
                formControlName: 'acceptTerms',
                title: const Text('Accept terms & conditions'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (form.valid) {
                    print(form.value);
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => form.resetState(
                  {
                    'email': ControlState<String>(value: null),
                    'password': ControlState<String>(value: null),
                    'acceptTerms': ControlState<bool>(value: false),
                  },
                  removeFocus: true,
                ),
                child: const Text('Reset all'),
              ),
            ],
          );
        },
      ),
    );
  }
}
