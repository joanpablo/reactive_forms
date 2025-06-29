# Reactive Forms

This is a model-driven approach to handling Forms inputs and validations, heavily inspired in [Angular's Reactive Forms](https://angular.io/guide/reactive-forms).

[![Pub Version](https://img.shields.io/pub/v/reactive_forms)](https://pub.dev/packages/reactive_forms) ![GitHub](https://img.shields.io/github/license/joanpablo/reactive_forms) ![GitHub top language](https://img.shields.io/github/languages/top/joanpablo/reactive_forms) ![flutter tests](https://github.com/joanpablo/reactive_forms/workflows/reactive_forms/badge.svg?branch=master) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/a4e40d632feb41b5af624cbd36064c83)](https://www.codacy.com/manual/joanpablo/reactive_forms?utm_source=github.com&utm_medium=referral&utm_content=joanpablo/reactive_forms&utm_campaign=Badge_Grade) [![codecov](https://codecov.io/gh/joanpablo/reactive_forms/branch/master/graph/badge.svg)](https://codecov.io/gh/joanpablo/reactive_forms)

## Table of Contents

- [Getting Started](#getting-started)
  - [Minimum Requirements](#minimum-requirements)
  - [Installation and Usage](#installation-and-usage)
- [Creating a form](#creating-a-form)
- [How to get/set Form data](#how-to-getset-form-data)
- [Validators](#what-about-validators)
  - [Predefined validators](#predefined-validators)
  - [Custom Validators](#custom-validators)
  - [Pattern Validator](#pattern-validator)
  - [FormGroup validators](#formgroup-validators)
  - [Password and Password Confirmation](#what-about-password-and-password-confirmation)
  - [Asynchronous Validators](#asynchronous-validators-sunglasses)
  - [Debounce time in async validators](#debounce-time-in-async-validators)
  - [Composing Validators](#composing-validators)
- [Groups of Groups](#groups-of-groups-grin)
- [Dynamic forms with FormArray](#dynamic-forms-with-formarray)
- [Arrays of Groups](#arrays-of-groups)
- [FormBuilder](#formbuilder)
  - [Groups](#groups)
  - [Arrays](#arrays)
  - [Control](#control)
  - [Control state](#control-state)
- [Reactive Form Widgets](#reactive-form-widgets)
- [How to customize error messages?](#how-to-customize-error-messages)
  - [Reactive Widget level](#1-reactive-widget-level)
  - [Global/Application level](#2-globalapplication-level)
  - [Parameterized validation messages](#parameterized-validation-messages)
- [When does Validation Messages begin to show up?](#when-does-validation-messages-begin-to-show-up)
  - [Touching a control](#touching-a-control)
  - [Overriding Reactive Widgets show errors behavior](#overriding-reactive-widgets-show-errors-behavior)
- [Enable/Disable Submit button](#enabledisable-submit-button)
  - [Submit Button in a different Widget](#separating-submit-button-in-a-different-widget)
  - [ReactiveFormConsumer widget](#using-reactiveformconsumer-widget)
- [Focus/UnFocus a FormControl](#focusunfocus-a-formcontrol)
- [Focus flow between Text Fields](#focus-flow-between-text-fields)
- [Enable/Disable a widget](#how-enabledisable-a-widget)
- [How does ReactiveTextField differs from native TextFormField or TextField?](#how-does-reactivetextfield-differs-from-native-textformfieldhttpsapiflutterdevfluttermaterialtextformfield-classhtml-or-textfieldhttpsapiflutterdevfluttermaterialtextfield-classhtml)
- [Reactive Form Field Widgets](#supported-reactive-form-field-widgets)
- [Bonus Field Widgets](#bonus-field-widgets)
- [Other Reactive Forms Widgets](#other-reactive-forms-widgets)
- [Advanced Reactive Field Widgets](#advanced-reactive-field-widgets)
- [ReactiveValueListenableBuilder to listen when value changes in a FormControl](#reactivevaluelistenablebuilder-to-listen-when-value-changes-in-a-formcontrol)
- [ReactiveForm vs ReactiveFormBuilder which one?](#reactiveform-vs-reactiveformbuilder-which-one)
- [Reactive Forms + Provider plugin](#reactive-forms--providerhttpspubdevpackagesprovider-plugin-muscle)
- [Reactive Forms + code generation plugin](#reactive-forms--code-generationhttpspubdevpackagesreactive_forms_generator-)
- [How create a custom Reactive Widget?](#how-create-a-custom-reactive-widget)
- [What is not Reactive Forms](#what-is-not-reactive-forms)
- [What is Reactive Forms](#what-is-reactive-forms)
- [Migrate versions](#migrate-versions)

## Getting Started

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Minimum Requirements

- Dart SDK: ^3.7.0
- Flutter: ">=3.29.0"

> For using **Reactive Forms** in projects below Flutter 2.8.0 please use the version <= 10.7.0 of
> **Reactive Forms**.

> For using **Reactive Forms** in projects below Flutter 2.2.0 please use the version <= 10.2.0 of
> **Reactive Forms**.

> For using **Reactive Forms** in projects with Flutter 1.17.0 please use the version 7.6.3 of
> **Reactive Forms**.

> **Reactive Forms v8.x** includes the **intl** package. If a version conflict is present, then you should use [**dependency_overrides**](https://dart.dev/tools/pub/dependencies#dependency-overrides) to temporarily override all references to **intl** and set the one that better fits your needs.

## Installation and Usage

Once you're familiar with Flutter you may install this package adding `reactive_forms` to the dependencies list
of the `pubspec.yaml` file as follow:

```yaml
dependencies:
  flutter:
    sdk: flutter

  reactive_forms: ^18.0.1
```

Then run the command `flutter packages get` on the console.

## Creating a form

A _form_ is composed by multiple fields or _controls_.

To declare a form with the fields _name_ and _email_ is as simple as:

```dart
final form = FormGroup({
  'name': FormControl<String>(value: 'John Doe'),
  'email': FormControl<String>(),
});
```

## Default Values

Notice in the example above that in the case of the _name_ we have also set a default value, in the case of the _email_ the default value is **null**.

## How to get/set Form data

Given the **FormGroup**:

```dart
final form = FormGroup({
  'name': FormControl<String>(value: 'John Doe'),
  'email': FormControl<String>(value: 'johndoe@email.com'),
});
```

You can get the value of a single **FormControl** as simple as:

```dart
String get name() => this.form.control('name').value;
```

But you can also get the complete _Form_ data as follows:

```dart
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

To set value to controls you can use two approaches:

```dart
// set value directly to the control
this.form.control('name').value = 'John';

// set value to controls by setting value to the form
this.form.value = {
  'name': 'John',
  'email': 'john@email.com',
};
```

## What about Validators?

You can add validators to a **FormControl** as follows:

```dart
final form = FormGroup({
  'name': FormControl<String>(validators: [Validators.required]),
  'email': FormControl<String>(validators: [
    Validators.required,
    Validators.email,
  ]),
});
```

> If at least one **FormControl** is **invalid** then the FormGroup is **invalid**

There are common predefined validators, but you can implement custom validators too.

### Predefined validators

#### FormControl

- Validators.required
- Validators.requiredTrue
- Validators.email
- Validators.number
- Validators.min
- Validators.max
- Validators.minLength
- Validators.maxLength
- Validators.pattern
- Validators.creditCard
- Validators.equals
- Validators.compose
- Validators.composeOR
- Validators.any
- Validators.contains
- Validators.oneOf

#### FormGroup

- Validators.mustMatch
- Validators.compare

#### FormArray

- Validators.minLength
- Validators.maxLength
- Validators.any
- Validators.contains

### Custom Validators

All validators are instances of classes that inherit from the `Validator` abstract class.
In order to implement a custom validator you can follow two different approaches:

1- Extend from `Validator` class and override the `validate` method.  
2- Or implement a custom validator function|method, and use it with the `Validators.delegate(...)` validator.

Let's implement a custom validator that validates a control's value must be `true`:

### Inheriting from `Validator` class:

Let's create a class that extends from `Validator` and overrides the `validate` method:

```dart
/// Validator that validates the control's value must be `true`.
class RequiredTrueValidator extends Validator<dynamic> {
  const RequiredTrueValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return control.isNotNull &&
           control.value is bool &&
           control.value == true
    ? null
    : {'requiredTrue': true};
  }
}
```

The `validator` method is a function that receives the _control_ to validate and returns a `Map`. If the value of the _control_ is valid the function returns `null`, otherwise returns a `Map` with the error key and a custom information. In the previous example we have defined `requiredTrue` as the error key and `true` as the custom information.

In order to use the new validator class we provide an instance of it in the FormControl definition.

```dart
final form = FormGroup({
  'acceptLicense': FormControl<bool>(
    value: false,
    validators: [
      RequiredTrueValidator(), // providing the new custom validator
    ],
  ),
});
```

### Using the `Validators.delegate()` validator:

Sometimes it's more convenient to implement a custom validator in a separate method|function than in a different new class. In that case, it is necessary to use the `Validators.delegate()` validator. It creates a validator that delegates the validation to the external function|method.

```dart
final form = FormGroup({
  'acceptLicense': FormControl<bool>(
    value: false,
    validators: [
      Validators.delegate(_requiredTrue) // delegates validation to a custom function
    ],
  ),
});
```

```dart
/// Custom function that validates that control's value must be `true`.
Map<String, dynamic>? _requiredTrue(AbstractControl<dynamic> control) {
  return control.isNotNull &&
         control.value is bool &&
         control.value == true
  ? null
  : {'requiredTrue': true};
}
```

> Check the [Migration Guide](https://github.com/joanpablo/reactive_forms/wiki/Migration-Guide/_edit#breaking-changes-in-15x) to learn more about custom validators after version 15.0.0 of the package.

### Pattern Validator

**_Validator.pattern_** is a validator that comes with **Reactive Forms**. Validation using regular expressions have been always a very useful tool to solve validation requirements. Let's see how we can validate American Express card numbers:

> American Express card numbers start with 34 or 37 and have 15 digits.

```dart
const americanExpressCardPattern = r'^3[47][0-9]{13}$';

final cardNumber = FormControl<String>(
  validators: [Validators.pattern(americanExpressCardPattern)],
);

cardNumber.value = '395465465421'; // not a valid number

expect(cardNumber.valid, false);
expect(cardNumber.hasError('pattern'), true);
```

> The above code is a Unit Test extracted from **Reactive Forms** tests.

If we _print_ the value of **FormControl.errors**:

```dart
print(cardNumber.errors);
```

We will get a _Map_ like this:

```json
{
  "pattern": {
    "requiredPattern": "^3[47][0-9]{13}$",
    "actualValue": 395465465421
  }
}
```

### FormGroup validators

There are special validators that can be attached to **FormGroup**. In the next section we will see an example of that.

## What about Password and Password Confirmation?

There are some cases where we want to implement a Form where a validation of a field depends on the value of another field. For example a sign-up form with _email_ and _emailConfirmation_ or _password_ and _passwordConfirmation_.

For those cases we could implement a custom validator as a class and attach it to the **FormGroup**. Let's see an example:

```dart
final form = FormGroup({
  'name': FormControl<String>(validators: [Validators.required]),
  'email': FormControl<String>(validators: [Validators.required, Validators.email]),
  'password': FormControl<String>(validators: [
    Validators.required,
    Validators.minLength(8),
  ]),
  'passwordConfirmation': FormControl<String>(),
}, validators: [
  MustMatchValidator(controlName: 'password', matchingControlName: 'passwordConfirmation')
]);
```

> Notice the use of \*Validators.**minLength(8)\***

In the previous code we have added two more fields to the form: _password_ and _passwordConfirmation_, both fields are required and the password must be at least 8 characters length.

However the most important thing here is that we have attached a **validator** to the **FormGroup**. This validator is a custom validator and the implementation follows as:

```dart
class MustMatchValidator extends Validator<dynamic> {
  final String controlName;
  final String matchingControlName;

  MustMatchValidator({
    required this.controlName,
    required this.matchingControlName,
  }) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});

      // force messages to show up as soon as possible
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  }
}
```

Fortunately you don't have to implement a custom _must match_ validator because we have already included it into the code of the **reactive_forms** package so you should reuse it. The previous form definition becomes into:

```dart
final form = FormGroup({
  'name': FormControl<String>(validators: [Validators.required]),
  'email': FormControl<String>(validators: [Validators.required, Validators.email]),
  'emailConfirmation': FormControl<String>(),
  'password': FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
  'passwordConfirmation': FormControl<String>(),
}, validators: [
  Validators.mustMatch('email', 'emailConfirmation'),
  Validators.mustMatch('password', 'passwordConfirmation'),
]);
```

## Asynchronous Validators :sunglasses:

Some times you want to perform a validation against a remote server, this operations are more time consuming and need to be done asynchronously.

For example you want to validate that the _email_ the user is currently typing in a _registration form_ is unique and is not already used in your application. **Asynchronous Validators** are just another tool so use them wisely.

**Asynchronous Validators** are very similar to their synchronous counterparts, with the following difference:

- The validator function returns a [Future](https://api.dart.dev/stable/dart-async/Future-class.html)

Asynchronous validation executes after the synchronous validation, and is performed only if the synchronous validation is successful. This check allows forms to avoid potentially expensive async validation processes (such as an HTTP request) if the more basic validation methods have already found invalid input.

After asynchronous validation begins, the form control enters a **pending** state. You can inspect the control's pending property and use it to give visual feedback about the ongoing validation operation.

Code speaks more than a thousand words :) so let's see an example.

Let's implement the previous mentioned example: the user is typing the email in a registration Form and you want to validate that the _email_ is unique in your System. We will implement a _custom async validator_ for that purpose.

```dart
final form = FormGroup({
  'email': FormControl<String>(
    validators: [
      Validators.required, // traditional required and email validators
      Validators.email,
    ],
    asyncValidators: [
      UniqueEmailAsyncValidator(), // custom asynchronous validator :)
    ],
  ),
});
```

We have declared a simple **Form** with an email **field** that is _required_ and must have a valid email value, and we have include a custom async validator that will validate if the email is unique. Let's see the implementation of our new async validator:

```dart
/// Validator that validates the user's email is unique, sending a request to
/// the Server.
class UniqueEmailAsyncValidator extends AsyncValidator<dynamic> {
  @override
  Future<Map<String, dynamic>?> validate(AbstractControl<dynamic> control) async {
    final error = {'unique': false};

    final isUniqueEmail = await _getIsUniqueEmail(control.value.toString());
    if (!isUniqueEmail) {
      control.markAsTouched();
      return error;
    }

    return null;
  }

  /// Simulates a time consuming operation (i.e. a Server request)
  Future<bool> _getIsUniqueEmail(String email) {
    // simple array that simulates emails stored in the Server DB.
    final storedEmails = ['johndoe@email.com', 'john@email.com'];

    return Future.delayed(
      const Duration(seconds: 5),
              () => !storedEmails.contains(email),
    );
  }
}
```

> Note the use of **control.markAsTouched()** to force the validation message to show up as soon as possible.

The previous implementation was a simple validator that receives the **AbstractControl** and returns a [Future](https://api.dart.dev/stable/dart-async/Future-class.html) that completes 5 seconds after its call and performs a simple check: if the _value_ of the _control_ is contained in the _server_ array of emails.

> If you want to see **Async Validators** in action with a **full example** using widgets and animations to feedback the user we strong advice you to visit our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Asynchronous-Validators). We have not included the full example in this README.md file just to simplify things here and to not anticipate things that we will see later in this doc.

> The validator `Validators.delegateAsync()` is another way to implement custom validator, for more reference
> check the [Custom validators](https://github.com/joanpablo/reactive_forms#custom-validators) section.

### Debounce time in async validators

Asynchronous validators have a debounce time that is useful if you want to minimize requests to a remote API. The debounce time is set in milliseconds and the default value is 250 milliseconds.

You can set a different debounce time as an optionally argument in the **FormControl** constructor.

```dart
final control = FormControl<String>(
  asyncValidators: [UniqueEmailAsyncValidator()],
  asyncValidatorsDebounceTime: 1000, // sets 1 second of debounce time.
);
```

### Custom debounce time in async validators

You can also specify a custom debounce time for a single async validator. This is useful when you have multiple async validators with different debounce time requirements.

```dart
final control = FormControl<String>(
  asyncValidators: [
    Validators.debounced(
      Validators.delegateAsync((control) async {
        // Your validation logic here
        return null;
      }),
      500, // Debounce time in milliseconds
    ),
  ],
);
```

### Custom debounce time in delegateAsync validator

The `Validators.delegateAsync()` function now accepts an optional `debounceTime` parameter, defaulting to 0. This allows immediate execution or custom debouncing for asynchronous validation.

```dart
final form = fb.group({
  'userName': FormControl<String>(
    asyncValidators: [
      Validators.delegateAsync((control) async {
        // Simulate a call to a backend service
        await Future<void>.delayed(Duration(seconds: 1));
        if (control.value == 'existingUser') {
          return {'unique': true};
        }
        return null;
      }, debounceTime: 300),
    ],
  ),
});
```

You can also use it without a debounce time:

```dart
final form = fb.group({
  'userName': FormControl<String>(
    asyncValidators: [
      Validators.delegateAsync((control) async {
        // Simulate a call to a backend service
        await Future<void>.delayed(Duration(seconds: 1));
        if (control.value == 'existingUser') {
          return {'unique': true};
        }
        return null;
      }), // No debounce time
    ],
  ),
});
```

## Composing Validators

To explain what Composing Validators is, let's see an example:

We want to validate a text field of an authentication form.
In this text field the user can write an **email** or a **phone number** and we want to make sure that the information is correctly formatted. We must validate that input is a valid email or a valid phone number.

```dart

final phonePattern = '<some phone regex pattern>';

final form = FormGroup({
  'user': FormControl<String>(
    validators: [
      Validators.composeOR([
        Validators.email,
        Validators.pattern(phonePattern),
      ])
    ],
  ),
});
```

> Note that **Validators.composeOR** receives a collection of validators as argument and returns a validator.

With **Validators.composeOR** we are saying to **FormControl** that **if at least one validator evaluate as VALID then the control is VALID** it's not necessary that both validators evaluate to valid.

Another example could be to validate multiples Credit Card numbers. In that case you have several regular expression patterns for each type of credit card. So the user can introduce a card number and if the information match with at least one pattern then the information is considered as valid.

```dart
final form = FormGroup({
  'cardNumber': FormControl<String>(
    validators: [
      Validators.composeOR([
        Validators.pattern(americanExpressCardPattern),
        Validators.pattern(masterCardPattern),
        Validators.pattern(visaCardPattern),
      ])
    ],
  ),
});
```

### One Of Validator

The `oneOf` validator is used to validate that the control's value is one of the values in the provided collection. For `String` values, the comparison can be made case-sensitive or insensitive.

```dart
final form = FormGroup({
  'fruit': FormControl<String>(
    validators: [
      Validators.oneOf(['apple', 'banana', 'orange']),
    ],
  ),
});
```

## Groups of Groups :grin:

**FormGroup** is not restricted to contains only **FormControl**, it can nest others **FormGroup** so you can create more complex **Forms**.

Supose you have a _Registration Wizzard_ with several screens. Each screen collect specific information and at the end you want to collect all that information as one piece of data:

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

> Note how we have set the _data type_ to a **FormControl**, although this is not mandatory when
> declaring a _Form_, we highly recommend this syntax as good practice or to use the FormBuilder
> syntax.

Using **FormBuilder** _(read FormBuilder section below)_:

```dart
final form = fb.group({
  'personal': fb.group({
    'name': ['', Validators.required],
    'email': ['', Validators.required],
  }),
  'phone': fb.group({
    'phoneNumber': ['', Validators.required],
    'countryIso': ['', Validators.required],
  }),
  'address': fb.group({
    'street': ['', Validators.required],
    'city': ['', Validators.required],
    'zip': ['', Validators.required],
  }),
});
```

You can collect all data using **FormGroup.value**:

```dart
void _printFormData(FormGroup form) {
  print(form.value);
}
```

The previous method outputs a _Map_ as the following one:

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
FormGroup personalForm = form.control('personal');
```

A simple way to create a wizard is for example to wrap a [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) within a **ReactiveForm** and each _Page_ inside the [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) can contains a **ReactiveForm** to collect specific data.

## Dynamic forms with **FormArray**

FormArray is an alternative to **FormGroup** for managing any number of unnamed controls. As with **FormGroup** instances, you can dynamically insert and remove controls from **FormArray** instances, and the form array instance value and validation status is calculated from its child controls.

You don't need to define a _key_ for each control by _name_, so this is a great option if you don't know the number of child values in advance.

Let's see a simple example:

```dart
final form = FormGroup({
  'emails': FormArray<String>([]), // an empty array of emails
});
```

We have defined just an empty array. Let's define another array with two controls:

```dart
final form = FormGroup({
  'emails': FormArray<String>([
    FormControl<String>(value: 'john@email.com'),
    FormControl<String>(value: 'susan@email.com'),
  ]),
});
```

> Note that you don't have to specify the name of the controls inside of the array.

If we output the _value_ of the previous form group we will get something like this:

```dart
print(form.value);
```

```json
{
  "emails": ["john@email.com", "susan@email.com"]
}
```

Let's dynamically add another control:

```dart
final array = form.control('emails') as FormArray<String>;

// adding another email
array.add(
  FormControl<String>(value: 'caroline@email.com'),
);

print(form.value);
```

```json
{
  "emails": ["john@email.com", "susan@email.com", "caroline@email.com"]
}
```

Another way of add controls is to assign values directly to the array:

```dart
// Given: an empty array of strings
final array = FormArray<String>([]);

// When: set value to array
array.value = ["john@email.com", "susan@email.com", "caroline@email.com"];

// Then: the array is no longer empty
expect(array.controls.length, 3);

// And: array has a control for each inserted value
expect(array.controls('0').value, "john@email.com");
expect(array.controls('1').value, "susan@email.com");
expect(array.controls('2').value, "caroline@email.com");
```

> To get a control from the array you must pass the index position as a _String_. This is because **FormGroup** and **FormArray** inherited from the same parent class and **FormControl** gets the controls by name (String).

A more advanced example:

```dart
// an array of contacts
final contacts = ['john@email.com', 'susan@email.com', 'caroline@email.com'];

// a form with a list of selected emails
final form = FormGroup({
  'selectedEmails': FormArray<bool>([], // an empty array of controls
    validators: [emptyAddressee], // validates that at least one email is selected
  ),
});

// get the array of controls
final formArray = form.control('selectedEmails') as FormArray<bool>;

// populates the array of controls.
// for each contact add a boolean form control to the array.
formArray.addAll(
  contacts.map((email) => FormControl<bool>(value: true)).toList(),
);
```

```dart
// validates that at least one email is selected
Map<String, dynamic> emptyAddressee(AbstractControl control) {
  final emails = (control as FormArray<bool>).value;
  return emails.any((isSelected) => isSelected)
      ? null
      : {'emptyAddressee': true};
}
```

## Arrays of Groups

You can also create arrays of groups:

```dart
// an array of groups
final addressArray = FormArray([
  FormGroup({
    'city': FormControl<String>(value: 'Sofia'),
    'zipCode': FormControl<int>(value: 1000),
  }),
  FormGroup({
    'city': FormControl<String>(value: 'Havana'),
    'zipCode': FormControl<int>(value: 10400),
  }),
]);
```

Another example using **FormBuilder**:

```dart
// an array of groups using FormBuilder
final addressArray = fb.array([
  fb.group({'city': 'Sofia', 'zipCode': 1000}),
  fb.group({'city': 'Havana', 'zipCode': 10400}),
]);
```

or just:

```dart
// an array of groups using a very simple syntax
final addressArray = fb.array([
  {'city': 'Sofia', 'zipCode': 1000},
  {'city': 'Havana', 'zipCode': 10400},
]);
```

You can iterate over groups as follow:

```dart
final cities = addressArray.controls
        .map((control) => control as FormGroup)
        .map((form) => form.control('city').value)
        .toList();
```

> A common mistake is to declare an _array_ of groups as _FormArray&lt;FormGroup&gt;_.  
> An array of _FormGroup_ must be declared as **FormArray()** or as **FormArray&lt;Map&lt;String, dynamic&gt;&gt;()**.

## FormBuilder

The **FormBuilder** provides syntactic sugar that shortens creating instances of a FormGroup, FormArray and FormControl. It reduces the amount of boilerplate needed to build complex forms.

### Groups

```dart
// creates a group
final form = fb.group({
  'name': 'John Doe',
  'email': ['', Validators.required, Validators.email],
  'password': Validators.required,
});
```

The previous code is equivalent to the following one:

```dart
final form = FormGroup({
  'name': FormControl<String>(value: 'John Doe'),
  'email': FormControl<String>(value: '', validators: [Validators.required, Validators.email]),
  'password': FormControl<String>(validators: [Validators.required]),
});
```

### Arrays

```dart
// creates an array
final aliases = fb.array(['john', 'little john']);
```

### Control

```dart
// creates a control of type String with a required validator
final control = fb.control<String>('', [Validators.required]);
```

### Control state

```dart
// create a group
final group = fb.group(
  // creates a control with default value and disabled state
  'name': fb.state(value: 'john', disabled: true),
);
```

## Nested Controls

To retrieves nested controls you can specify the name of the control as a dot-delimited string that define the path to the control:

```dart
final form = FormGroup({
  'address': FormGroup({
    'city': FormControl<String>(value: 'Sofia'),
    'zipCode': FormControl<int>(value: 1000),
  }),
});

// get nested control value
final city = form.control('address.city');

print(city.value); // outputs: Sofia
```

## Reactive Form Widgets

So far we have only defined our model-driven form, but how do we bind the form definition with our Flutter widgets? Reactive Forms Widgets is the answer ;)

Let's see an example:

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

> The example above ignores the _emailConfirmation_ and _passwordConfirmation_ fields previously seen for simplicity.

## How to customize error messages?

Validation messages can be defined at two different levels:

1. Reactive Widget level.
2. Global/Application level.

### 1. Reactive Widget level.

Each reactive widget like `ReactiveTextField`, `ReactiveDropdownField`, and all others have the
property `validationMessages` as an argument of their constructors. In order to define custom
validation messages at widget level, just provide the property `validationMessages` with the
corresponding text values for each error as shown below:

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
            'required': (error) => 'The name must not be empty'
          },
        ),
        ReactiveTextField(
          formControlName: 'email',
          validationMessages: {
            'required': (error) => 'The email must not be empty',
            'email': (error) => 'The email value must be a valid email'
          },
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
          validationMessages: {
            'required': (error) => 'The password must not be empty',
            'minLength': (error) => 'The password must have at least 8 characters'
          },
        ),
      ],
    ),
  );
}
```

> **Reactive Forms** have an utility class called **ValidationMessage** that brings access to
> common _validation messages_: _required_, _email_, _pattern_ and so on. So instead of write 'required' you
> could use _ValidationMessage.required_ as the key of validation messages:
>
> ```dart
> return ReactiveTextField(
>    formControlName: 'email',
>    validationMessages: {
>      ValidationMessage.required: (error) => 'The email must not be empty',
>      ValidationMessage.email: (error) => 'The email value must be a valid email',
>    },
> ),
> ```
>
> nice isn't it? ;)

### 2. Global/Application level.

You can also define custom validation messages at a higher level, for example, at the application
level. When a reactive widget looks for an error message text, it first looks at widget level
definition, if it doesn't find any config at widget level then it looks at the global config
definition.

The global definition of validation messages allows you to define error messages in a centralized
way and relieves you to define validation messages on each reactive widget of your application.

In order to define these configs at a higher level use the widget **ReactiveFormConfig** and
define the `validationMessages`.

Here is an example of the global definition for custom validation messages:

### Validation messages with error arguments:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => 'Field must not be empty',
        ValidationMessage.email: (error) => 'Must enter a valid email',
      },
      child: MaterialApp(
        home: Scaffold(
          body: const Center(
            child: Text('Hello Flutter Reactive Forms!'),
          ),
        ),
      ),
    );
  }
}
```

### Parameterized validation messages

You can enrich the validation messages using parameters of the error instance. In the next example
we are giving a more complete validation error to the user:

```dart
final form = FormGroup({
  'password': FormControl<String>(
    validators: [Validators.minLength(8)],
  ),
});
```

```dart
ReactiveTextField(
  formControlName: 'password',
  validationMessage: {
    ValidationMessages.minLength: (error) =>
    'The password must be at least ${(error as Map)['requiredLength']} characters long'
  },
)
```

This will show the message: `The password must be at least 8 characters long`

## When does Validation Messages begin to show up?

### Touching a control

Even when the **FormControl** is invalid, validation messages will begin to show up when the **FormControl** is **touched**. That means when the user taps on the **ReactiveTextField** widget and then remove focus or completes the text edition.

You can initialize a **FormControl** as **touched** to force the validation messages to show up at the very first time the widget builds.

```dart
final form = FormGroup({
  'name': FormControl<String>(
    value: 'John Doe',
    validators: [Validators.required],
    touched: true,
  ),
});
```

When you set a _value_ to a **FormControl** from code and want to show up validations messages
you must call _FormControl.markAsTouched()_ method:

```dart
set name(String newName) {
  final formControl = this.form.control('name');
  formControl.value = newName;
  formControl.markAsTouched();// if newName is invalid then validation messages will show up in UI
}
```

> To mark all children controls of a **FormGroup** and **FormArray** you must call **markAllAsTouched()**.
>
> ```dart
> final form = FormGroup({
>   'name': FormControl<String>(
>     value: 'John Doe',
>     validators: [Validators.required],
>     touched: true,
>   ),
> });
>
> // marks all children as touched
> form.markAllAsTouched();
> ```

### Overriding Reactive Widgets show errors behavior

The second way to customize when to show error messages is to override the method **showErrors** in reactive widgets.

Let's suppose you want to show validation messages not only when it is **invalid** and **touched** (default behavior), but also when it's **dirty**:

```dart
ReactiveTextField(
  formControlName: 'email',
  // override default behavior and show errors when: INVALID, TOUCHED and DIRTY
  showErrors: (control) => control.invalid && control.touched && control.dirty,
),
```

> A control becomes **dirty** when its value change through the UI.  
> The method **setErrors** of the controls can optionally mark it as dirty too.

## Enable/Disable Submit button

For a better User Experience some times we want to enable/disable the _Submit_ button based on the validity of the _Form_. Getting this behavior, even in such a great framework as Flutter, some times can be hard and can lead to have individual implementations for each _Form_ of the same application plus boilerplate code.

We will show you two different approaches to accomplish this very easily:

1. Separating Submit Button in a different Widget.
2. Using **ReactiveFormConsumer** widget.

### Separating Submit Button in a different Widget:

Let's add a submit button to our _Form_:

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

> The above is a simple sign-in form with _email_, _password_, and a _submit_ button.

Now let's see the implementation of the **MySubmitButton** widget:

```dart
class MySubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return RaisedButton(
      child: Text('Submit'),
      onPressed: form.valid ? _onPressed : null,
    );
  }

  void _onPressed() {
    print('Hello Reactive Forms!!!');
  }
}
```

> Notice the use of **_ReactiveForm.of(context)_** to get access to the nearest **FormGroup** up the widget's tree.

In the previous example we have separated the implementation of the _submit_ button in a different widget. The reasons behind this is that we want to re-build the _submit_ button each time the _validity_ of the **FormGroup** changes. We don't want to rebuild the entire _Form_, but just the button.

How is that possible? Well, the answer is in the expression:

```dart
final form = ReactiveForm.of(context);
```

The expression above have two important responsibilities:

- Obtains the nearest **FormGroup** up the widget's tree.
- Registers the current **context** with the changes in the **FormGroup** so that if the validity of the **FormGroup** changes then the current **context** is _rebuilt_.

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
              onPressed: form.valid ? _onSubmit : null,
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
final form = fb.group({'name': 'John Doe'});

FormControl control = form.control('name');

control.focus(); // UI text field get focus and the device keyboard pop up

control.unfocus(); // UI text field lose focus
```

You can also set focus directly from the Form like:

```dart
final form = fb.group({'name': ''});

form.focus('name'); // UI text field get focus and the device keyboard pop up
```

```dart
final form = fb.group({
  'person': fb.group({
    'name': '',
  }),
});

// set focus to a nested control
form.focus('person.name');
```

## Focus flow between Text Fields

Another example is when you have a form with several text fields and each time the user completes edition in one field you want to request next focus field using the keyboard actions:

```dart
final form = fb.group({
  'name': ['', Validators.required],
  'email': ['', Validators.required, Validators.email],
  'password': ['', Validators.required],
});
```

```dart
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: Column(
      children: <Widget>[
        ReactiveTextField(
          formControlName: 'name',
          textInputAction: TextInputAction.next,
          onSubmitted: () => this.form.focus('email'),
        ),
        ReactiveTextField(
          formControlName: 'email',
          textInputAction: TextInputAction.next,
          onSubmitted: () => this.form.focus('password'),
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

> When you remove focus of a control, the control is marked as touched, that means that the validation error messages will show up in UI. To prevent validation messages to show up you can optionally set argument **touched** to _false_.
>
> ```dart
> // remove the focus to the control and marks it as untouched.
> this.form.unfocus(touched: false);
> ```

## How Enable/Disable a widget

To disabled a widget like **ReactiveTextField** all you need to do is to _mark_ the _control_ as disabled:

```dart
final form = FormGroup({
  'name': FormControl<String>(),
});

FormControl control = form.control('name');

// the control is disabled and also the widget in UI is disabled.
control.markAsDisabled();
```

> When a control is disabled it is exempt from validation checks and excluded from the aggregate
> value of any parent. Its status is **DISABLED**.
>
> To retrieves all values of a FormGroup or FormArray regardless of disabled status in children use
> **FormControl.rawValue** or **FormArray.rawValue** respectively.

## How does **ReactiveTextField** differs from native [TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html) or [TextField](https://api.flutter.dev/flutter/material/TextField-class.html)?

**ReactiveTextField** has more in common with _TextFormField_ that with _TextField_. As we all know _TextFormField_ is a wrapper around the _TextField_ widget that brings some extra capabilities such as _Form validations_ with properties like _autovalidate_ and _validator_. In the same way **ReactiveTextField** is a wrapper around _TextField_ that handle the features of validations in a own different way.

**ReactiveTextField** has all the properties that you can find in a common _TextField_, it can be customizable as much as you want just as a simple _TextField_ or a _TextFormField_. In fact must of the code was taken from the original TextFormField and ported to have a reactive behavior that binds itself to a **FormControl** in a **two-way** binding.

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

> Because of the **two-binding** capability of the **ReactiveTextField** with a **FormControl**
> the widget **don't** include properties as _controller_, _validator_, _autovalidate_, _onSaved_,
> the **FormControl** is responsible for handling validation as well as changes
> notifications.
>
> It does include some events like **onChanged**, **onTab**, **onEditingComplete**,
> and **onSubmitted**.

## Supported Reactive Form Field Widgets

- ReactiveTextField
- ReactiveDropdownField
- ReactiveSwitch
- ReactiveCheckbox
- ReactiveRadio
- ReactiveSlider
- ReactiveCheckboxListTile
- ReactiveSwitchListTile
- ReactiveRadioListTile

## Bonus Field Widgets

- ReactiveDatePicker
- ReactiveTimePicker

## Other Reactive Forms Widgets

- ReactiveForm
- ReactiveFormConsumer
- ReactiveFormBuilder
- ReactiveFormArray
- ReactiveValueListenableBuilder
- ReactiveStatusListenableBuilder

## Advanced Reactive Field Widgets

We are trying to keep `reactive_forms` from bloating with third party dependencies this is why there is
a separate library [`reactive_forms_widgets`](https://pub.dev/packages/reactive_forms_widgets) which is under construction yet that provides
a variety of more advanced field widgets. To know more about how to install it please visit the library repo and read the documentation about the widgets it contains.

- **[ReactiveAdvancedSwitch](https://pub.dev/packages/reactive_advanced_switch)** - wrapper around [`flutter_advanced_switch`](https://pub.dev/packages/flutter_advanced_switch)
- **[ReactiveDateRangePicker](https://pub.dev/packages/reactive_date_range_picker)** - wrapper around [showDateRangePicker](https://api.flutter.dev/flutter/material/showDateRangePicker.html)
- **[ReactiveDateTimePicker](https://pub.dev/packages/reactive_date_time_picker)** - wrapper around [showDatePicker](https://api.flutter.dev/flutter/material/showDatePicker.html) and [showTimePicker](https://api.flutter.dev/flutter/material/showTimePicker.html)
- **[ReactiveDropdownSearch](https://pub.dev/packages/reactive_dropdown_search)** - wrapper around [`dropdown_search`](https://pub.dev/packages/dropdown_search)
- **[ReactiveFilePicker](https://pub.dev/packages/reactive_file_picker)** - wrapper around [`file_picker`](https://pub.dev/packages/file_picker)
- **[ReactiveImagePicker](https://pub.dev/packages/reactive_image_picker)** - wrapper around [`image_picker`](https://pub.dev/packages/image_picker)
- **[ReactiveMultiImagePicker](https://pub.dev/packages/reactive_multi_image_picker)** - wrapper around [`multi_image_picker`](https://pub.dev/packages/multi_image_picker)
- **[ReactiveSegmentedControl](https://pub.dev/packages/reactive_segmented_control)** - wrapper around [`CupertinoSegmentedControl`](https://api.flutter.dev/flutter/cupertino/CupertinoSegmentedControl-class.html)
- **[ReactiveSignature](https://pub.dev/packages/reactive_signature)** - wrapper around [`signature`](https://pub.dev/packages/signature)
- **[ReactiveTouchSpin](https://pub.dev/packages/reactive_touch_spin)** - wrapper around [`flutter_touch_spin`](https://pub.dev/packages/flutter_touch_spin)
- **[ReactiveRangeSlider](https://pub.dev/packages/reactive_range_slider)** - wrapper around [`RangeSlider`](https://api.flutter.dev/flutter/material/RangeSlider-class.html)
- **[ReactiveSleekCircularSlider](https://pub.dev/packages/reactive_sleek_circular_slider)** - wrapper around [`sleek_circular_slider`](https://pub.dev/packages/sleek_circular_slider)
- **[ReactiveCupertinoTextField](https://pub.dev/packages/reactive_cupertino_text_field)** - wrapper around [`CupertinoTextField`](https://api.flutter.dev/flutter/cupertino/CupertinoTextField-class.html)
- **[ReactiveRatingBar](https://pub.dev/packages/reactive_flutter_rating_bar)** - wrapper around [`flutter_rating_bar`](https://pub.dev/packages/flutter_rating_bar)
- **[ReactiveMacosUi](https://pub.dev/packages/reactive_macos_ui)** - wrapper around [`macos_ui`](https://pub.dev/packages/macos_ui)
- **[ReactivePinPut](https://pub.dev/packages/reactive_pinput)** - wrapper around [`pinput`](https://pub.dev/packages/pinput)
- **[ReactiveCupertinoSwitch](https://pub.dev/packages/reactive_cupertino_switch)** - wrapper around [`CupertinoSwitch`](https://api.flutter.dev/flutter/cupertino/CupertinoSwitch-class.html)
- **[ReactivePinCodeTextField](https://pub.dev/packages/reactive_pin_code_fields)** - wrapper around [`pin_code_fields`](https://pub.dev/packages/pin_code_fields)
- **[ReactiveSlidingSegmentedControl](https://pub.dev/packages/reactive_sliding_segmented)** - wrapper around [`CupertinoSlidingSegmentedControl`](https://api.flutter.dev/flutter/cupertino/CupertinoSlidingSegmentedControl-class.html)
- **[ReactiveCupertinoSlider](https://pub.dev/packages/reactive_cupertino_slider)** - wrapper around [`CupertinoSlider`](https://api.flutter.dev/flutter/cupertino/CupertinoSlider-class.html)
- **[ReactiveColorPicker](https://pub.dev/packages/reactive_color_picker)** - wrapper around [`flutter_colorpicker`](https://pub.dev/packages/flutter_colorpicker)
- **[ReactiveMonthPickerDialog](https://pub.dev/packages/reactive_month_picker_dialog)** - wrapper around [`month_picker_dialog`](https://pub.dev/packages/month_picker_dialog)
- **[ReactiveRawAutocomplete](https://pub.dev/packages/reactive_raw_autocomplete)** - wrapper around [`RawAutocomplete`](https://api.flutter.dev/flutter/widgets/RawAutocomplete-class.html)
- **[ReactiveFlutterTypeahead](https://pub.dev/packages/reactive_flutter_typeahead)** - wrapper around [`flutter_typeahead`](https://pub.dev/packages/flutter_typeahead)
- **[ReactivePinInputTextField](https://pub.dev/packages/reactive_pin_input_text_field)** - wrapper around [`pin_input_text_field`](https://pub.dev/packages/pin_input_text_field)
- **[ReactiveDirectSelect](https://pub.dev/packages/reactive_direct_select)** - wrapper around [`direct_select`](https://pub.dev/packages/direct_select)
- **[ReactiveMarkdownEditableTextInput](https://pub.dev/packages/reactive_md_editable_textinput)** - wrapper around [`markdown_editable_textinput`](https://pub.dev/packages/markdown_editable_textinput)
- **[ReactiveCodeTextField](https://pub.dev/packages/reactive_code_text_field)** - wrapper around [`code_text_field`](https://pub.dev/packages/code_text_field)
- **[ReactivePhoneFormField](https://pub.dev/packages/reactive_phone_form_field)** - wrapper around [`phone_form_field`](https://pub.dev/packages/phone_form_field)
- **[ReactiveExtendedTextField](https://pub.dev/packages/reactive_extended_text_field)** - wrapper around [`extended_text_field`](https://pub.dev/packages/extended_text_field)
- **[ReactiveCupertinoSlidingSegmentedControl](https://pub.dev/packages/reactive_cup_slide_segmented)** - wrapper around [`CupertinoSlidingSegmentedControl`](https://api.flutter.dev/flutter/cupertino/CupertinoSlidingSegmentedControl-class.html)

### ReactiveTextField

We have explain the common usage of a **ReactiveTextField** along this documentation.

### ReactiveDropdownField

**ReactiveDropdownField** as all the other _reactive field widgets_ is almost the same as its native version [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html) but adding two-binding capabilities. The code is ported from the original native implementation. It have all the capability of styles and themes of the native version.

```dart
final form = FormGroup({
  'payment': FormControl<int>(validators: [Validators.required]),
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
        ),
      ],
    ),
  );
}
```

> As you can see from the above example the usage of **ReactiveDropdownField** is almost the same as the usage of a common [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html), except for the additional _formControlName_ and _validationMessages_ properties.

## **ReactiveValueListenableBuilder** to listen when value changes in a **FormControl**

If you want to rebuild a widget each time a FormControl value changes you could use the **ReactiveValueListenableBuilder** widget.

In the following example we are listening for changes in _lightIntensity_. We change that value with a **ReactiveSlider** and show all the time the value in a **Text** widget:

```dart
final form = FormGroup({
  'lightIntensity': FormControl<double>(value: 50.0),
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
            return Text('lights at ${value?.toStringAsFixed(2)}%');
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

## **ReactiveForm** vs **ReactiveFormBuilder** which one?

Both widgets are responsible for exposing the **FormGroup** to descendants widgets in the tree. Let see an example:

```dart
// using ReactiveForm
@override
Widget build(BuildContext context) {
  return ReactiveForm(
    formGroup: this.form,
    child: ReactiveTextField(
      formControlName: 'email',
    ),
  );
}
```

```dart
// using ReactiveFormBuilder
@override
Widget build(BuildContext context) {
  return ReactiveFormBuilder(
    form: () => this.form,
    builder: (context, form, child) {
      return ReactiveTextField(
        formControlName: 'email',
      );
    },
  );
}
```

The main differences are that **ReactiveForm** is a _StatelessWidget_ so it doesn't save the instance of the **FormGroup**. You must declare the instance of the **FormGroup** in a StatefulWidget or resolve it from some Provider (state management library).

```dart
// Using ReactiveForm in a StatelessWidget and resolve the FormGroup from a provider
class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignInViewModel>(context, listen: false);

    return ReactiveForm(
      formGroup: viewModel.form,
      child: ReactiveTextField(
        formControlName: 'email',
      ),
    );
  }
}
```

```dart
// Using ReactiveForm in a StatefulWidget and declaring FormGroup in the state.
class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final form = fb.group({
    'email': Validators.email,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: this.form,
      child: ReactiveTextField(
        formControlName: 'email',
      ),
    );
  }
}
```

> If you declare a **FormGroup** in a _StatelessWidget_ the _group_ will be destroyed a created each time the instance of the _StatelessWidget_ is destroyed and created, so you must preserve the **FormGroup** in a state or in a Bloc/Provider/etc.

By the other hand **ReactiveFormBuilder** is implemented as a _StatefulWidget_ so it holds the created **FormGroup** in its state. That way is safe to declares the **FormGroup** in a StatelessWidget or get it from a Bloc/Provider/etc.

```dart
class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => fb.group({'email': Validators.email}),
      builder: (context, form, child) {
        return ReactiveTextField(
          formControlName: 'email',
        );
      },
    );
  }
}
```

You should use **ReactiveForm** if:

- The form is complex enough.
- You need to listen for changes in some child control to execute some business logic.
- You are using some State Management library like Provider or Bloc.
- Using a StatefulWidget to declare a very simple form is something that really doesn't bother you.

You should use **ReactiveFormBuilder** if:

- The form is quite simple enough and doesn't need a separate Provider/Bloc state.
- You don't want to use a StatefulWidget to declare the FormGroup.

But the final decision is really up to you, you can use any of them in any situations ;)

## Widget testing

**note: mark your fields with `Key`'s for easy access via widget tester**

### example component

```dart
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final form = FormGroup({
    'email': FormControl<String>(validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: <Widget>[
          ReactiveTextField(
            key: const Key('email'),
            formControlName: 'email',
          ),
          ReactiveTextField(
            key: const Key('password'),
            formControlName: 'password',
            obscureText: true,
          ),
          ElevatedButton(
            key: const Key('submit'),
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

### example test

```dart

void main() {
  testWidgets('LoginForm should pass with correct values', (tester) async {
    // Build the widget.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: LoginForm()),
    ));

    await tester.enterText(find.byKey(const Key('email')), 'etc@test.qa');
    await tester.enterText(find.byKey(const Key('password')), 'password');

    await tester.tap(find.byKey(const Key('submit')));

    await tester.pump();

    // Expect to find the item on screen if needed
    expect(find.text('etc@test.qa'), findsOneWidget);

    // Get form state
    final LoginFormState loginFormState = tester.state(find.byType(LoginForm));

    // Check form state
    expect(loginFormState.form.valid, true);
  });
}

```



## Reactive Forms + [Provider](https://pub.dev/packages/provider) plugin :muscle:

Although **Reactive Forms** can be used with any state management library or even without any one at all, **Reactive Forms** gets its maximum potential when is used in combination with a state management library like the [Provider](https://pub.dev/packages/provider) plugin.

This way you can separate UI logic from business logic and you can define the **FormGroup** inside a business logic class and then exposes that class to widgets with mechanism like the one [Provider](https://pub.dev/packages/provider) plugin brings.

## Reactive Forms + [code generation](https://pub.dev/packages/reactive_forms_generator) 🤖

[ReactiveFormsGenerator](https://pub.dev/packages/reactive_forms_generator) is the code generator for reactive_forms which will save you tons of time and make your forms type safe.

There is no reason write code manually! Let the code generation work for you.

## How create a custom Reactive Widget?

**Reactive Forms** is not limited just to common widgets in _Forms_ like text, dropdowns, sliders switch fields and etc, you can easily create **custom widgets** that **two-way** binds to **FormControls** and create your own set of _Reactive Widgets_ ;)

In our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Custom-Reactive-Widgets) you can find a tutorial of how to create your custom Reactive Widget.

You can also check [Star Rating with Flutter Reactive Forms](https://dev.to/joanpablo/star-rating-with-flutter-reactive-forms-2d52) post as another example of a custom reactive widget.

## What is not **Reactive Forms**

- **Reactive Forms** is not a fancy widgets package. It is not a library that brings some new Widgets with new shapes, colors or animations. It lets you to decide the shapes, colors, and animations you want for your widgets, but frees you from the responsibility of gathering and validating the data. And keeps the data in sync between your model and your widgets.

- **Reactive Forms** does not pretend to replace the native widgets that you commonly use in your Flutter projects like _TextFormField_, _DropdownButtonFormField_ or _CheckboxListTile_. Instead of that it brings new two-way binding capabilities and much more features to those same widgets.

## What is **Reactive Forms**

- **Reactive Forms** provides a model-driven approach to handling form inputs whose values change over time. It's heavily inspired in Angular Reactive Form.
- It lets you focus on business logic and save you time from collect, validate and mantain synchronization between your models and widgets.
- Remove boilerplate code and brings you the posibility to write clean code defining a separation between model and UI with minimal efforts.
- And it integrates perfectly well with common state management libraries like [Provider](https://pub.dev/packages/provider), [Bloc](https://pub.dev/packages/bloc) and many others good libraries the community has created.

## Migrate versions

Visit [Migration Guide](https://github.com/joanpablo/reactive_forms/wiki/Migration-Guide) to see
more details about different version breaking changes.
