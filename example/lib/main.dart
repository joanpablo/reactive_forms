import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(ReactiveFormsApp());
}

class ReactiveFormsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
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
  // demonstration purposes and to simplify this example.
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
    'passwordConfirmation': FormControl(),
    'rememberMe': FormControl(defaultValue: false),
    'progress': FormControl<double>(defaultValue: 50.0),
    'dateTime': FormControl<DateTime>(defaultValue: DateTime.now()),
    'time': FormControl<TimeOfDay>(defaultValue: TimeOfDay.now()),
    'durationSeconds': FormControl<double>(defaultValue: 0),
  }, validators: [
    Validators.mustMatch('password', 'passwordConfirmation')
  ]);

  FormControl get password => this.form.control('password');

  FormControl get passwordConfirmation =>
      this.form.control('passwordConfirmation');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactive Forms'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: ReactiveForm(
            formGroup: this.form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: ReactiveStatusListenableBuilder(
                      formControlName: 'email',
                      builder: (context, control, child) {
                        return control.pending
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Container(width: 0);
                      },
                    ),
                  ),
                  validationMessages: {
                    ValidationMessage.required: 'The email must not be empty',
                    ValidationMessage.email:
                        'The email value must be a valid email',
                    'unique': 'This email is already in use',
                  },
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => this.password.focus(),
                ),
                SizedBox(height: 24.0),
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
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => this.passwordConfirmation.focus(),
                ),
                SizedBox(height: 24.0),
                ReactiveTextField(
                  formControlName: 'passwordConfirmation',
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validationMessages: {
                    ValidationMessage.mustMatch:
                        'Password confirmation must match',
                  },
                ),
                SizedBox(height: 24.0),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return RaisedButton(
                      child: Text('Sign Up'),
                      onPressed: form.valid
                          ? () {
                              print(form.value);
                            }
                          : null,
                    );
                  },
                ),
                RaisedButton(
                  child: Text('Reset all'),
                  onPressed: () => form.reset({
                    'email': FormControlState(value: '', disabled: true),
                  }),
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
                SizedBox(height: 24.0),
                ReactiveValueListenableBuilder<double>(
                  formControlName: 'progress',
                  builder: (context, control, child) {
                    return Text(
                        'Progress set to ${control.value?.toStringAsFixed(2)}%');
                  },
                ),
                ReactiveSlider(
                  formControlName: 'progress',
                  max: 100,
                  divisions: 100,
                  labelBuilder: (double value) =>
                      '${value.toStringAsFixed(2)}%',
                ),
                SizedBox(height: 24.0),
                ReactiveTextField(
                  formControlName: 'durationSeconds',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 24.0),
                ReactiveTextField(
                  formControlName: 'dateTime',
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Birthday',
                    suffixIcon: ReactiveDatePicker(
                      formControlName: 'dateTime',
                      firstDate: DateTime(1985),
                      lastDate: DateTime(2030),
                      builder: (context, picker, child) {
                        return IconButton(
                          onPressed: picker.showPicker,
                          icon: Icon(Icons.date_range),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                ReactiveTextField(
                  formControlName: 'time',
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Birthday',
                    suffixIcon: ReactiveTimePicker(
                      formControlName: 'time',
                      builder: (context, picker, child) {
                        return IconButton(
                          onPressed: picker.showPicker,
                          icon: Icon(Icons.access_time),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Async validator in use emails example
const inUseEmails = ['johndoe@email.com', 'john@email.com'];

/// Async validator example that simulates a request to a server
/// to validate if the email of the user is unique.
Future<Map<String, dynamic>> _uniqueEmail(AbstractControl control) async {
  final error = {'unique': false};

  final emailAlreadyUsed = await Future.delayed(
    Duration(seconds: 5), // a delay to simulate a time consuming operation
    () => inUseEmails.contains(control.value),
  );

  if (emailAlreadyUsed) {
    control.touch();
    return error;
  }

  return null;
}

final customTheme = ThemeData.light().copyWith(
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    alignLabelWithHint: true,
  ),
);
