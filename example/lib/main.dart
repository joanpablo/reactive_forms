import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(ReactiveFormsApp());
}

class ReactiveFormsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // We don't recommend to declare a FormGroup within a Stateful Widget.
  // We highly recommend using the Provider plugin
  // or any other state management library.
  //
  // We have declared the FormGroup within a Stateful Widget only for
  // demonstration purposes and to simplify the explanation in this example.
  final form = FormGroup({
    'email': FormControl(
      validators: [
        Validators.required,
        Validators.email,
      ],
      asyncValidators: [_uniqueEmail],
    ),
    'password': FormControl(validators: [
      Validators.required,
      Validators.minLength(8),
    ]),
    'passwordConfirmation': FormControl(validators: [
      Validators.required,
    ]),
    'rememberMe': FormControl(defaultValue: false),
    'progress': FormControl<double>(defaultValue: 50.0),
  }, validators: [
    Validators.mustMatch('password', 'passwordConfirmation')
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactive Forms'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ReactiveForm(
            formGroup: this.form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validationMessages: {
                    ValidationMessage.required: 'The email must not be empty',
                    ValidationMessage.email:
                        'The email value must be a valid email',
                  },
                ),
                ReactiveTextField(
                  formControlName: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validationMessages: {
                    ValidationMessage.required:
                        'The password must not be empty',
                    ValidationMessage.minLength:
                        'The password must be at least 8 characters',
                  },
                ),
                ReactiveTextField(
                  formControlName: 'passwordConfirmation',
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validationMessages: {
                    ValidationMessage.required:
                        'The password confirmation must not be empty',
                    ValidationMessage.mustMatch: 'The passwords must match',
                  },
                ),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return RaisedButton(
                      child: Text('SignIn'),
                      onPressed: form.invalid ? null : () => print(form.value),
                    );
                  },
                ),
                ReactiveSwitch(formControlName: 'rememberMe'),
                ReactiveCheckbox(formControlName: 'rememberMe'),
                ReactiveDropdownField<bool>(
                  formControlName: 'rememberMe',
                  hint: Text('Want to stay logged in?'),
                  decoration: InputDecoration(labelText: 'Remember me'),
                  items: [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('No'),
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Remember me'),
                  trailing: ReactiveRadio(
                    formControlName: 'rememberMe',
                    value: true,
                  ),
                ),
                ListTile(
                  title: Text('Don\'t Remember me'),
                  trailing: ReactiveRadio(
                    formControlName: 'rememberMe',
                    value: false,
                  ),
                ),
                ReactiveValueListenableBuilder<double>(
                  formControlName: 'progress',
                  builder: (context, value, child) {
                    return Text('Progress set to ${value.toStringAsFixed(2)}%');
                  },
                ),
                ReactiveSlider(
                  formControlName: 'progress',
                  max: 100,
                  divisions: 100,
                  labelBuilder: (double value) =>
                      '${value.toStringAsFixed(2)}%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> _uniqueEmail(AbstractControl control) async {
  return Future.delayed(
    Duration(seconds: 5),
    () => {'unique': true},
  );
}
