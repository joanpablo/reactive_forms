# Reactive Forms

This is a model driven approach to handling form inputs and validations, heavily inspired in Angular's Reactive Forms.

## Getting Started

For help getting started with Flutter, view the 
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

## Creating a form

A *form* is composed by multiple fields or *controls*.

To declare a form with the fields *name* and *email* is as simple as:

```dart
final form = FromGroup({
  'name': FormControl(defaultValue: 'John Doe'),
  'email': FormControl(),
});
```

## Default Values

Notice in the example above that in the case of the *name* we have also set a default value, in the case of the *email* the default value is **null**.

## What about Validators?

You can add validators to a **FormControl** as follows:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [
    Validators.required,
    Validators.email,
  ]),
});
```

> If at least one **FormControl** is **invalid** then the FormGroup is **invalid**  

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

A custom **FormControl** validator is a function that receives the *value* as a **String** and returns a **Map**. If the the value is correct the function must returns **null** otherwise returns a **Map** with a key and custom information, in the previous example we just set **true** as custom information. 

> You can see the implementation of predefined validators to see more examples. In fact the previous example is the current implementation of the **required** validator, but we have just change the names for demostration porpouse.

### FormGroup validators

There are special validators that can be attached to **FormGroup**. In the Next section we will see an example of that.

## What about Password and Password Confirmation?

There are some cases where we want to implement a Form where a validation of a field depends on the value of another field. For example a sign-up form with *email* and *emailConfirmation* or *password* and *passwordConfirmation*.

For that cases we must implement a custom validator and attach it to the **FormGroup**, lets see an example:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [Validators.required, Validators.email]),
  'password': FormControl(validators: [Validators.required, Validators.minLenght(8)]),
  'passwordConfirmation': FormControl(validators: [Validators.required]),
}, validators: [_mustMatch('password', 'passwordConfirmation')]);
```
> Notice the use of *Validators.**minLenght(8)***

In the previous code we have added two more fields to the form: *password* and *passwordConfirmation*, boths fields are required and the password must be at least 8 charactares lenght.

However the most important thing here is that we have attached a **validator** to the **FormGroup**. This validator is a custom validator and the implementation follows as:

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

Fortunly you don't have to implement a custom *must match* validator because we have already included it into the code of the **reactive_forms** package so you could reuse it. The previous form definition example will become into:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [Validators.required, Validators.email]),
  'emailConfirmation': FormControl(validators: [Validators.required]),
  'password': FormControl(validators: [Validators.required, Validators.minLenght(8)]),
  'passwordConfirmation': FormControl(validators: [Validators.required]),
}, validators: [
  FormGroupValidators.mustMatch('email', 'emailConfirmation'),
  FormGroupValidators.mustMatch('password', 'passwordConfirmation'),
]);
```

## Flutter Reactive Widgets

So far we have only defined our model-driven form, but how do we bind the form definition with our Flutter widgets? Reactive Widgets is the answer ;)

Lets see an example:

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Columns(
      children: <Widget>[
        ReactiveTextField(
          formControlName: 'name',
        ),
        ReactiveTextField(
          formControlName: 'email',
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
        ),
      ],
    ),
  );
}
```

> The example above ignores the *emailConfirmation* and *passwordConfirmation* fields previously seen for simplicity.

## How to customize error messages?

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Columns(
      children: <Widget>[
        ReactiveTextField(
          formControlName: 'name',
          validationMessages: {
            'required': 'The name must not be empty'
          },
        ),
        ReactiveTextField(
          formControlName: 'email',
          validationMessages: {
            'required': 'The email must not be empty',
            'email': 'The email value must be a valid email'
          },
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
          validationMessages: {
            'required': 'The password must not be empty',
            'minLenght': 'The password must have at least 8 characters'
          },
        ),
      ],
    ),
  );
}
```

## Enable/Disable Submit button

For a better User Experience some times we want to enable/disable the *Submit* button based on the validity of the *Form*. Getting this behavior, even in such a great framework as Flutter, some times can be hard and can lead to have individual implementations for each *Form* of the same application plus boilerplate code.  

Lets add a submit button to our *Form*:

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Columns(
      children: <Widget>[
        ReactiveTextField(
          formControlName: 'email',
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
        ),
        MySubmitButton(),
      ],
    ),
  );
}
```

Now lets see the implementation of the **MySubmitButton** custom widget:

```dart
class MySubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return RaisedButton(
      child: Text('Submit'),
      onPressed: form.invalid ? null : _onPressed,
    );
  }

  void _onPressed() {
    print('Hello Reactive Forms!!!');
  }
}
```

> Notice the use of ***ReactiveForm.of(context)*** to get access to the nearest **FormGroup** up the widget's tree.

In the previous example we have separate the implementation of the *submit* button in a different widget. The reason behind that is that we want to re-build the *submit* button each time the *validity* of the **FormGroup** changes, not the entire *Form*, but just the button.