# Reactive Forms

This is a model driven approach to handling form inputs and validations, heavily inspired in Angular's Reactive Forms

## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Installation and Usage

Once you're familiar with Flutter you may install this package adding `reactive_forms` (0.0.1 or higher) to the dependencies list
of the `pubspec.yaml` file as follow:

```yaml
dependencies:
  flutter:
    sdk: flutter

  reactive_froms: ^0.0.1
```

Then run the command `flutter packages get` on the console.

## Create a form

A *form* is composed by multiple fields or *controls*.

To declare a form with the fields *name* and *email* is as simple as:

```dart
final form = FromGroup({
  'name': FormControl(defaultValue: 'John Doe'),
  'email': FormControl(),
});
```

## Default Values

Notice that in the examble above that in the case of the *name* we have also set a default value, in the case of the *email* the default value is **null**.

## What about Validators?

You can add validators to the FormControl as follows:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [
    Validators.required,
    Validators.email,
  ]),
});
```

There are common predifined validators, but you can implement custom validators too.
### Predifined validators
- Validators.required
- Validators.email
- Validators.number
- Validators.minLength
- Validators.maxLength
- Validators.pattern

### Custom Validators
Lets implement a custom validator that validates empty white spaces value:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required, _emptyWhiteSpaces]),
});

Map<String, dynamic> _emptyWhiteSpaces(String value) {
    return (value != null && value.trim().isNotEmpty)
        ? null
        : {'emptyWhiteSpaces': true};
  }
```

A custom FormControl validator is a function that receives the value as a String and returns a Map. If the the value is correct the function must returns **null** otherwise returns a **Map** with a key and custom information, in the previous example we just set **true** as custom information. 

You can see the implementation of predefined validators to see more examples. In fact the previous example is the current implementation of the **required** validator, but we have just change the names for demostration porpouse.

### FormGroup validators

There are special validators that can be attached to **FormGroup**. In the Next section we will see an example of that.

## What about Password and PasswordConfirmation?

There are some cases where we want to implement a Form where a validation of a field depends on the value of another field, For example a sign-up form with *email* and *emailConfirmation* or *password* and *passwordConfirmation*.

For that cases we must implement a custom validator and attach it to the **FormGroup**, lets see an example:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [Validators.required, Validators.email]),
  'password': FormControl(validators: [Validators.required, Validators.minLenght(8)]),
  'passwordConfirmation': FormControl(validators: [Validators.required]),
}, validators: [_mustMatch('password', 'passwordConfirmation')]);
```

In the previous code you can notice that we have added two more fields to the form: *password* and *passwordConfirmation*, also that boths fields are required and that the password must be at least 8 charactares lenght.

But the must important thing here is that we have attached a **validator** to the **FormGroup**, this validator is a custom validator and here is the implementation:

```dart
Map<String, dynamic> _mustMatch(String controlName, String matchingControlName) {
  return (FormGroup form) {
    final control = form.formControl(controlName);
    final matchingControl = form.formControl(matchingControlName);

    if (control.value != matchingControl.value) {
      matchingControl.addError({'mustMatch': true});
    } else {
      matchingControl.removeError('mustMatch');
    }

    return null;
  };
}
```