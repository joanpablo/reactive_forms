import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class LoginSample extends StatelessWidget {
  FormGroup buildForm() => fb.group(<String, dynamic>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        'rememberMe': false,
      });

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('Login sample'),
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
                decoration: InputDecoration(
                  labelText: 'Email',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              SizedBox(height: 16.0),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                validationMessages: (control) => {
                  ValidationMessage.required: 'The password must not be empty',
                  ValidationMessage.minLength:
                      'The password must be at least 8 characters',
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Password',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              Row(
                children: [
                  ReactiveCheckbox(formControlName: 'rememberMe'),
                  Text('Remember me')
                ],
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                child: Text('Sign Up'),
                onPressed: () {
                  if (form.valid) {
                    print(form.value);
                  } else {
                    form.markAllAsTouched();
                  }
                },
              ),
              RaisedButton(
                child: Text('Reset all'),
                onPressed: () => form.resetState({
                  'email': ControlState<String>(value: null),
                  'password': ControlState<String>(value: null),
                  'rememberMe': ControlState<bool>(value: false),
                }, removeFocus: true),
              ),
            ],
          );
        },
      ),
    );
  }
}
