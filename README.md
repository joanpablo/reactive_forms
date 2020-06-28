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

Notice that in the examble above in the case of the *name* we have also set a default value, in the case of the *email* the default value is **null**.

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

A custom FormControl validator is a function that receives a the value as a String and returns a Map. If the the value is correct the function must returns **null** otherwise returns a **Map** with a key and custom information, in the previous example we just set **true**. 

You can see the implementation of predefined validators to see more examples. In fact the previous example is the current implementation of the **required** validator, but we have just change the names for demostration porpouse.

### FormGroup validators

There are special validators that can be attached to FormGroup. In the Next section we will see an example.

## What about Password and PasswordConfirmation?