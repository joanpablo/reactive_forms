# Reactive Forms

This is a model-driven approach to handling Forms inputs and validations, heavily inspired in [Angular's Reactive Forms](https://angular.io/guide/reactive-forms).

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

## How to get Form data
You can get the value of a single **FormControl** as simple as:

```dart
String get name() => this.form.formControl('name').value;
```

But you can also get the complete *Form* data as follows:

```dart
final form = FromGroup({
  'name': FormControl(defaultValue: 'John Doe'),
  'email': FormControl(defaultValue: 'johndoe@email.com'),
});

print(form.value);
```

The previous code prints the following output:

```json
{
  "name": "John Doe",
  "email": "johndoe@email.com"
}
```

> **FormGroup.value** returns an instance of **Map<String, dynamic>** with each field and its value.

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

There are common predefined validators, but you can implement custom validators too.  
### Predefined validators
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

Map<String, dynamic> _emptyWhiteSpaces(dynamic value) {
  final error = {'required': true};
  
  if (value == null) {
    return error;
  } else if (value is String) {
    return value.trim().isEmpty ? error : null;
  }

  return null;
}
```

A custom **FormControl** validator is a function that receives the *value* as a **dynamic** and returns a **Map**. If the the value is correct the function must returns **null** otherwise returns a **Map** with a key and custom information, in the previous example we just set **true** as custom information. 

> You can see the implementation of predefined validators to see more examples. In fact the previous example is the current implementation of the **required** validator, but we have just change the names for demonstration purpose.

### FormGroup validators

There are special validators that can be attached to **FormGroup**. In the next section we will see an example of that.

## What about Password and Password Confirmation?

There are some cases where we want to implement a Form where a validation of a field depends on the value of another field. For example a sign-up form with *email* and *emailConfirmation* or *password* and *passwordConfirmation*.

For that cases we must implement a custom validator and attach it to the **FormGroup**, lets see an example:

```dart
final form = FromGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [Validators.required, Validators.email]),
  'password': FormControl(validators: [Validators.required, Validators.minLength(8)]),
  'passwordConfirmation': FormControl(validators: [Validators.required]),
}, validators: [_mustMatch('password', 'passwordConfirmation')]);
```
> Notice the use of *Validators.**minLength(8)***

In the previous code we have added two more fields to the form: *password* and *passwordConfirmation*, both fields are required and the password must be at least 8 characters length.

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

Fortunately you don't have to implement a custom *must match* validator because we have already included it into the code of the **reactive_forms** package so you could reuse it. The previous form definition example will become into:

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

## Groups of Groups :grin:

**FormGroup** is not restricted to contains only **FormControl**, it can nest others **FormGroup** so you can create more complex **Forms**.

Supose you have a *Registration Wizzard* with several screens. Each screen collect specific information and at the end you want to collect all that information as one piece of data:

```dart
final form = FormGroup({
  'personal': FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [Validators.required]),
  }),
  'phone': FormGroup({
    'phoneNumber': FormControl<String>(validators: [Validators.required]),
    'countryIso': FormControl<String>(validators: [Validators.required]),
  }),
  'address': FormGroup({
    'street': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'zip': FormControl<String>(validators: [Validators.required]),
  }),
});
```

> Note how we set the *data type* to a **FormControl**, this is not mandatory when define *Forms* but we recommend this syntax.

You can collect all data using **FormGroup.value**:

```dart
void _printFormData(FormGroup form) {
  print(form.value);
}
```

The previous method outputs a *Map* as the following one:

```json
{
  "personal": {
    "name": "...",
    "email": "..."
  },
  "phone": {
    "phoneNumber": "...",
    "countryIso": "..."
  },
  "address": {
    "street": "...",
    "city": "...",
    "zip": "..."
  }
}
```

And of course you can access to a nested **FormGroup** as following:

```dart
FormGroup personalForm = form.formControl('personal');
```

A simple way to create a wizzard is for example to wrap a [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) within a **ReactiveForm** and each *Page* inside the [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) can contains a **ReactiveForm** to collect specific data.

## Reactive Form Widgets

So far we have only defined our model-driven form, but how do we bind the form definition with our Flutter widgets? Reactive Forms Widgets is the answer ;)

Lets see an example:

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
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
    child: Column(
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

## When does Validation Messages begin to show up?

Even when the **FormControl** is invalid, validation messages will begin to show up when the **FormControl** is **touched**. That means when the user taps on the **ReactiveTextField** widget and then remove focus or completes the text edition.

You can initialize a **FormControl** as **touched** to force the validation messages to show up at the very first time the widget builds.

```dart
final form = FormGroup({
  'name': FormControl(
    defaultValue: 'John Doe',
    validators: [Validators.required],
    touched: true,
  ),
});
```

Also when we set a *value* to a **FormControl** the validations messages begin to show up, even if the UI widget haven't been touched by the user. For example:

```dart
set name(String newName) {
  final formControl = this.form.formControl('name');
  formControl.value = newName; // if newName is invalid then messages will show up in UI
}
```

## Enable/Disable Submit button

For a better User Experience some times we want to enable/disable the *Submit* button based on the validity of the *Form*. Getting this behavior, even in such a great framework as Flutter, some times can be hard and can lead to have individual implementations for each *Form* of the same application plus boilerplate code.  

We will show you two different approaches to accomplish this very easily:
1. Separating Submit Button in a different Widget.
2. Using **ReactiveFormConsumer** widget.

### Separating Submit Button in a different Widget:
Lets add a submit button to our *Form*:

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
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

> The above is a simple sign-in form with *email*, *password*, and a *submit* button.

Now lets see the implementation of the **MySubmitButton** widget:

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

In the previous example we have separated the implementation of the *submit* button in a different widget. The reasons behind this is that we want to re-build the *submit* button each time the *validity* of the **FormGroup** changes. We don't want to rebuild the entire *Form*, but just the button.

How is that possible? Well, the answer is in the expression:

```dart
final form = ReactiveForm.of(context);
```

The expression above have two important responsibilities:
- Obtains the nearest **FormGroup** up the widget's tree.
- Register the current **context** with the changes in the **FormGroup** so that if the validity of the **FormGroup** change then the current **context** is *rebuilt*.

The **ReactiveForm** widget has this behavior because is implemented using the [**InheritedNotifier**](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html).

### Using **ReactiveFormConsumer** widget:

**ReactiveFormConsumer** widget is a wrapped around the **ReactiveForm.of(context)** expression so that we can reimplement the previous example as follows:

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
      children: <Widget>[
        ReactiveTextField(
          formControlName: 'email',
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
        ),
        ReactiveFormConsumer(
          builder: (context, form, child) {
            return RaisedButton(
              child: Text('Submit'),
              onPressed: form.invalid ? null : _onSubmit,
            );
          },
        ),
      ],
    ),
  );
}

void _onSubmit() {
  print('Hello Reactive Forms!!!');
}
```

> It is entirely up to you to decide which of the above two approaches to use, but note that to access the **FormGroup** via **ReactiveForm.of(context)** the consumer widget must always be down in the tree of the **ReactiveForm** widget.

## Focus/UnFocus a **FormControl**

There are some cases where we want to add or remove focus on a UI TextField without the interaction of the user. For that particular cases you can use **FormControl.focus()** or **FormControl.unfocus()** methods.

```dart
final form = FromGroup({
  'name': FormControl(defaultValue: 'John Doe'),
});

final formControl = form.formControl('name');

formControl.focus(); // UI text field get focus and the device keyboard pop up

formControl.unfocus(); // UI text field lose focus
```

## How does **ReactiveTextField** differs from native [TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html) or [TextField](https://api.flutter.dev/flutter/material/TextField-class.html)?

**ReactiveTextField** has more in common with *TextFormField* that with *TextField*. As we all know *TextFormField* is a wrapper around the *TextField* widget that brings some extra capabilities such as *Form validations* with properties like *autovalidate* and *validator*. In the same way **ReactiveTextField** is a wrapper around *TextField* that handle the features of validations in a own different way.

**ReactiveTextField** has all the properties that you can find in a common *TextField*, it can be customizable as much as you want just as a simple *TextField* or a *TextFormField*. In fact must of the code was taken from the original TextFormField and ported to have a reactive behavior that binds itself to a **FormControl** in a **two-way** binding. 

Below is an example of how to create some **ReactiveTextField** with some common properties:

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
      children: <Widget>[
        ReactiveTextField(
          formControlName: 'name',
          decoration: InputDecoration(
            labelText: 'Name',
          ),
          textCapitalization: TextCapitalization.words,
          textAlign: TextAlign.center,
          style: TextStyle(backgroundColor: Colors.white),
        ),
        ReactiveTextField(
          formControlName: 'phoneNumber',
          decoration: InputDecoration(
            labelText: 'Phone number',
          ),
          keyboardType: TextInputType.number,
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
      ],
    ),
  );
}
```

> Because of the **two-binding** capability of the **ReactiveTextField** with a **FormControl** the widget **don't** include properties as *controller*, *validator*, *autovalidate*, *onSaved*, *onChanged*, *onEditingComplete*, *onFieldSubmitted*, the **FormControl** is responsible for handling validation as well as changes notifications.

## Supported Reactive Form Fields Widgets

- ReactiveTextField
- ReactiveDropdownField
- ReactiveSwitch
- ReactiveCheckbox
- ReactiveRadio
- ReactiveSlider

## Other Reactive Forms Widgets

- ReactiveForm
- ReactiveFormConsumer
- ReactiveValueListenableBuilder

### ReactiveTextField

We have explain the common usage of a **ReactiveTextField** along this documentation.

### ReactiveDropdownField

**ReactiveDropdownField** as all the other *reactive field widgets* is almost the same as its native version [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html) but adding two-binding capabilities. The code is ported from the original native implementation. It have all the capability of styles and themes of the native version.

```dart
final form = FormGroup({
  'payment': FormControl(validators: [Validators.required]),
});

@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
      children: <Widget>[
        ReactiveDropdownField<int>(
          formControlName: 'payment',
          hint: Text('Select payment...'),
          items: [
            DropdownMenuItem(
              value: 0,
              child: Text('Free'),
            ),
            DropdownMenuItem(
              value: 1,
              child: Text('Visa'),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text('Mastercard'),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text('PayPal'),
            ),
          ],
          validationMessages: {
            'required': 'You must select a payment method',
          },
        ),
      ],
    ),
  );
}
```

> As you can see from the above example the usage of **ReactiveDropdownField** is almost the same as the usage of a common [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html), except for the additional *formControlName* and *validationMessages* properties.

## **ReactiveValueListenableBuilder** to listen when value changes in a FormControl

If you want to rebuild a widget each time a FormControl value changes you could use the **ReactiveValueListenableBuilder** widget.

In the following example we are listening for changes in *lightIntensity*. We change that value with a **ReactiveSlider** and show all the time the value in a **Text** widget:

```dart
final form = FormGroup({
  'lightIntensity': FormControl<double>(defaultValue: 50.0),
});

@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
      children: <Widget>[
        ReactiveValueListenableBuilder<double>(
          formControlName: 'lightIntensity',
          builder: (context, value, child) {
            return Text('lights at ${value.toStringAsFixed(2)}%');
          },
        ),
        ReactiveSlider(
          formControlName: 'lightIntensity',
          max: 100.0,
        ),
      ],
    )
  );
}
```

## Reactive Forms + [Provider](https://pub.dev/packages/provider) plugin :muscle:

Although **Reactive Forms** can be used with any state management library or even without any one at all, **Reactive Forms** gets its maximum potential when is used in combination with a state management library like the [Provider](https://pub.dev/packages/provider) plugin.

This way you can separate UI logic from business logic and you can define the **FormGroup** inside a business logic class and then exposes that class to widgets with mechanism like the one [Provider](https://pub.dev/packages/provider) plugin brings.

## How create a custom Reactive Widget?

**Reactive Forms** is not limited just to common widgets in *Forms* like text, dropdowns, sliders switch fields and etc, you can easily create **custom widgets** that **two-way** binds to **FormControls** and create your own set of *Reactive Widgets* ;)

In our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Custom-Reactive-Widgets) you can find a tutorial of how to create your custom Reactive Widget. 



