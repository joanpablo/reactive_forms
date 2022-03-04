import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class LoginSample extends StatelessWidget {
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        'rememberMe': false,
      })
        ..suppressErrors();

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('Login sample'),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'email',
                validationMessages: (control) => {
                  ValidationMessage.required: 'The email must not be empty',
                  ValidationMessage.email:
                      'The email value must be a valid email',
                  'unique': 'This email is already in use',
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
                validationMessages: (control) => {
                  ValidationMessage.required: 'The password must not be empty',
                  ValidationMessage.minLength:
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
              Row(
                children: [
                  ReactiveCheckbox(formControlName: 'rememberMe'),
                  const Text('Remember me')
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  form.reinstateErrors();
                  if (form.valid) {
                    print(form.value);
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: const Text('Sign Up'),
              ),
              ElevatedButton(
                onPressed: () => form.resetState(
                  {
                    'email': ControlState<String>(value: null),
                    'password': ControlState<String>(value: null),
                    'rememberMe': ControlState<bool>(value: false),
                  },
                  removeFocus: true,
                  suppressErrors: true,
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
