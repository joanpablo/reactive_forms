import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reactive Forms Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Define the form group
  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
  });

  void _login() {
    if (form.valid) {
      // Handle successful login
      print('Login successful!');
      print('Email: ${form.control('email').value}');
      print('Password: ${form.control('password').value}');
      // You would typically navigate to another screen here
      // or make an API call.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
    } else {
      // Mark fields as touched to show errors if not already shown
      form.markAllAsTouched();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Use ReactiveForm widget to bind the FormGroup
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Email Field
              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      'The email must not be empty',
                  ValidationMessage.email: (_) =>
                      'The email value must be a valid email',
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),

              // Password Field
              ReactiveTextField<String>(
                formControlName: 'password',
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      'The password must not be empty',
                  ValidationMessage.minLength: (error) =>
                      'The password must be at least ${(error as Map)['requiredLength']} characters long',
                },
              ),
              const SizedBox(height: 24.0),

              // Login Button
              ElevatedButton(
                onPressed: _login, // Call _login method on press
                child: const Text('Login'),
              ),

              const SizedBox(height: 20),

              // Example of disabling button based on form validity
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  return ElevatedButton(
                    onPressed: formGroup.valid ? _login : null,
                    child: const Text('Login (Enabled when valid)'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
