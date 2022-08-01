import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/progress_indicator.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class BooleanObject {
  final String name;

  BooleanObject(this.name);

  @override
  bool operator ==(Object other) =>
      other is BooleanObject && name == other.name;

  @override
  int get hashCode => hashValues(name, name);
}

final yes = BooleanObject('Yes');
final no = BooleanObject('No');

class ComplexSample extends StatelessWidget {
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
          asyncValidators: [_uniqueEmail],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        'passwordConfirmation': '',
        'rememberMe': false,
        'progress': fb.control<double>(50.0, [
          Validators.min(50.0),
          Validators.max(90.0),
        ]),
        'dateTime': DateTime.now(),
        'time': TimeOfDay.now(),
        'booleanObject':
            FormControl<BooleanObject>(value: BooleanObject('Yes')),
      }, [
        Validators.mustMatch('password', 'passwordConfirmation')
      ]);

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('Complex sample'),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
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
                onSubmitted: (_) => form.focus('password'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  suffixIcon: ReactiveStatusListenableBuilder(
                    formControlName: 'email',
                    builder: (context, control, child) => Visibility(
                      visible: control.pending,
                      child: ProgressIndicator(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      'The password must not be empty',
                  ValidationMessage.minLength: (error) =>
                      'The password must be at least ${(error as Map)['requiredLength']} characters long',
                },
                onSubmitted: (_) => form.focus('passwordConfirmation'),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24.0),
              ReactiveTextField<String>(
                formControlName: 'passwordConfirmation',
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validationMessages: {
                  ValidationMessage.mustMatch: (_) =>
                      'Password confirmation must match',
                },
                onSubmitted: (_) => form.focus('rememberMe'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24.0),
              ReactiveFormConsumer(
                builder: (context, form, child) => ElevatedButton(
                  onPressed: form.valid ? () => print(form.value) : null,
                  child: const Text('Sign Up'),
                ),
              ),
              ElevatedButton(
                onPressed: () => form.resetState({
                  'email':
                      ControlState<String>(value: 'johnDoe', disabled: true),
                  'progress': ControlState<double>(value: 50.0),
                  'rememberMe': ControlState<bool>(value: false),
                }, removeFocus: true),
                child: const Text('Reset all'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReactiveSwitch(formControlName: 'rememberMe'),
                  ReactiveCheckbox(formControlName: 'rememberMe'),
                ],
              ),
              ReactiveDropdownField<bool>(
                formControlName: 'rememberMe',
                decoration: const InputDecoration(
                  labelText: 'Want to stay logged in?',
                ),
                items: [
                  const DropdownMenuItem(value: true, child: Text('Yes')),
                  const DropdownMenuItem(value: false, child: Text('No')),
                ],
              ),
              const SizedBox(height: 24.0),
              ReactiveDropdownField<BooleanObject>(
                formControlName: 'booleanObject',
                decoration: const InputDecoration(
                  labelText: 'Is this example BooleanObject?',
                ),
                items: [
                  DropdownMenuItem(
                    value: yes,
                    child: const Text('Yes'),
                  ),
                  DropdownMenuItem(
                    value: no,
                    child: const Text('No'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          form.control('booleanObject').value = yes,
                      child: const Text('Yes'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => form.control('booleanObject').value = no,
                      child: const Text('No'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              ReactiveDropdownField<bool>(
                formControlName: 'rememberMe',
                decoration: const InputDecoration(
                  labelText: 'Want to stay logged in?',
                ),
                items: [
                  const DropdownMenuItem(value: true, child: Text('Yes')),
                  const DropdownMenuItem(value: false, child: Text('No')),
                ],
              ),
              ReactiveRadioListTile(
                formControlName: 'rememberMe',
                title: const Text('Remember me'),
                value: true,
              ),
              ReactiveRadioListTile(
                formControlName: 'rememberMe',
                title: const Text('Don\'t Remember me'),
                value: false,
                toggleable: true,
              ),
              const SizedBox(height: 24.0),
              ReactiveValueListenableBuilder<double>(
                formControlName: 'progress',
                builder: (context, control, child) => Text(control.isNull
                    ? 'Progress not set'
                    : 'Progress set to ${control.value?.toStringAsFixed(2)}%'),
              ),
              ReactiveSlider(
                formControlName: 'progress',
                max: 100,
                divisions: 100,
                labelBuilder: (double value) => '${value.toStringAsFixed(2)}%',
              ),
              const SizedBox(height: 24.0),
              ReactiveTextField<double>(
                formControlName: 'progress',
                keyboardType: TextInputType.number,
                showErrors: (control) => control.invalid,
                validationMessages: {
                  ValidationMessage.max: (error) =>
                      'A value greater than ${(error as Map)['max']} is not accepted',
                  ValidationMessage.min: (error) =>
                      'A value lower than ${(error as Map)['min']} is not accepted',
                },
              ),
              const SizedBox(height: 24.0),
              ReactiveTextField<DateTime>(
                formControlName: 'dateTime',
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  suffixIcon: ReactiveDatePicker<DateTime>(
                    formControlName: 'dateTime',
                    firstDate: DateTime(1985),
                    lastDate: DateTime(2030),
                    builder: (context, picker, child) {
                      return IconButton(
                        onPressed: picker.showPicker,
                        icon: const Icon(Icons.date_range),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ReactiveTextField<TimeOfDay>(
                formControlName: 'time',
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Birthday time',
                  suffixIcon: ReactiveTimePicker(
                    formControlName: 'time',
                    builder: (context, picker, child) {
                      return IconButton(
                        onPressed: picker.showPicker,
                        icon: const Icon(Icons.access_time),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          );
        },
      ),
    );
  }
}

/// Async validator in use emails example
const inUseEmails = ['johndoe@email.com', 'john@email.com'];

/// Async validator example that simulates a request to a server
/// to validate if the email of the user is unique.
Future<Map<String, dynamic>?> _uniqueEmail(
    AbstractControl<dynamic> control) async {
  final error = {'unique': false};

  final emailAlreadyInUse = await Future.delayed(
    const Duration(seconds: 5), // delay to simulate a time consuming operation
    () => inUseEmails.contains(control.value.toString()),
  );

  if (emailAlreadyInUse) {
    control.markAsTouched();
    return error;
  }

  return null;
}
