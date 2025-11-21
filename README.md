# Reactive Forms

This is a model-driven approach to handling form inputs and validations, heavily inspired by [Angular's Reactive Forms](https://angular.io/guide/reactive-forms).

[![Pub Version](https://img.shields.io/pub/v/reactive_forms)](https://pub.dev/packages/reactive_forms) ![GitHub](https://img.shields.io/github/license/joanpablo/reactive_forms) ![GitHub top language](https://img.shields.io/github/languages/top/joanpablo/reactive_forms) ![flutter tests](https://github.com/joanpablo/reactive_forms/workflows/reactive_forms/badge.svg?branch=master) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/a4e40d632feb41b5af624cbd36064c83)](https://www.codacy.com/manual/joanpablo/reactive_forms?utm_source=github.com&utm_medium=referral&utm_content=joanpablo/reactive_forms&utm_campaign=Badge_Grade) [![codecov](https://codecov.io/gh/joanpablo/reactive_forms/branch/master/graph/badge.svg)](https://codecov.io/gh/joanpablo/reactive_forms)

## Table of Contents

- [Getting Started](#getting-started)
  - [Minimum Requirements](#minimum-requirements)
  - [Installation and Usage](#installation-and-usage)
- [Creating a Form](#creating-a-form)
- [Getting/Setting Form Data](#how-to-getset-form-data)
- [Validators](#what-about-validators)
  - [Predefined Validators](#predefined-validators)
  - [Custom Validators](#custom-validators)
  - [Pattern Validator](#pattern-validator)
  - [FormGroup Validators](#formgroup-validators)
  - [Password and Password Confirmation](#what-about-password-and-password-confirmation)
  - [Asynchronous Validators](#asynchronous-validators-sunglasses)
  - [Debounce Time in Async Validators](#debounce-time-in-async-validators)
  - [Composing Validators](#composing-validators)
- [Groups of Groups](#groups-of-groups-grin)
- [Dynamic Forms with FormArray](#dynamic-forms-with-formarray)
- [Arrays of Groups](#arrays-of-groups)
- [FormBuilder](#formbuilder)
  - [Groups](#groups)
  - [Arrays](#arrays)
  - [Control](#control)
  - [Control State](#control-state)
- [Reactive Form Widgets](#reactive-form-widgets)
- [How to Customize Error Messages](#how-to-customize-error-messages)
  - [Reactive Widget Level](#1-reactive-widget-level)
  - [Global/Application Level](#2-globalapplication-level)
  - [Parameterized Validation Messages](#parameterized-validation-messages)
- [When do Validation Messages Appear?](#when-does-validation-messages-begin-to-show-up)
  - [Touching a Control](#touching-a-control)
  - [Overriding Reactive Widgets Show Errors Behavior](#overriding-reactive-widgets-show-errors-behavior)
- [Enable/Disable Submit Button](#enabledisable-submit-button)
  - [Submit Button in a Separate Widget](#separating-submit-button-in-a-different-widget)
  - [ReactiveFormConsumer Widget](#using-reactiveformconsumer-widget)
- [Focus/Unfocus a FormControl](#focusunfocus-a-formcontrol)
- [Focus Flow Between Text Fields](#focus-flow-between-text-fields)
- [Enable/Disable a Widget](#how-enabledisable-a-widget)
- [How does ReactiveTextField differ from native TextFormField or TextField?](#how-does-reactivetextfield-differs-from-native-textformfieldhttpsapiflutterdevfluttermaterialtextformfield-classhtml-or-textfieldhttpsapiflutterdevfluttermaterialtextfield-classhtml)
- [Reactive Form Field Widgets](#supported-reactive-form-field-widgets)
- [Bonus Field Widgets](#bonus-field-widgets)
- [Other Reactive Forms Widgets](#other-reactive-forms-widgets)
- [Advanced Reactive Field Widgets](#advanced-reactive-field-widgets)
- [ReactiveValueListenableBuilder for Listening to Value Changes in a FormControl](#reactivevaluelistenablebuilder-to-listen-when-value-changes-in-a-formcontrol)
- [ReactiveForm vs. ReactiveFormBuilder: Which to Choose?](#reactiveform-vs-reactiveformbuilder-which-one)
- [Reactive Forms + Provider Plugin](#reactive-forms--providerhttpspubdevpackagesprovider-plugin-muscle)
- [Reactive Forms + Code Generation Plugin](#reactive-forms--code-generationhttpspubdevpackagesreactive_forms_generator-)
- [How to Create a Custom Reactive Widget](#how-create-a-custom-reactive-widget)
- [What Reactive Forms is Not](#what-is-not-reactive-forms)
- [What Reactive Forms Is](#what-is-reactive-forms)
- [Migration Versions](#migrate-versions)

## Getting Started

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Minimum Requirements

- Dart SDK: ^3.7.0
- Flutter: ">=3.29.0"

> For using **Reactive Forms** in projects below Flutter 2.8.0, please use version <= 10.7.0 of
> **Reactive Forms**.

> For using **Reactive Forms** in projects below Flutter 2.2.0, please use version <= 10.2.0 of
> **Reactive Forms**.

> For using **Reactive Forms** in projects with Flutter 1.17.0, please use version 7.6.3 of
> **Reactive Forms**.

> **Reactive Forms v8.x** includes the **intl** package. If a version conflict is present, you should use [**dependency_overrides**](https://dart.dev/tools/pub/dependencies#dependency-overrides) to temporarily override all references to **intl** and set the one that better fits your needs.

## Installation and Usage

Once you're familiar with Flutter, you can install this package by adding `reactive_forms` to the dependencies list
of your `pubspec.yaml` file as follows:

```yaml
dependencies:
  flutter:
    sdk: flutter

  reactive_forms: ^18.2.0
```

Then, run the command `flutter packages get` in the console.

## Creating a Form

A _form_ is composed of multiple fields or _controls_.

To declare a form with the fields _name_ and _email_, it's as simple as:

```dart
final form = FormGroup({
  'name': FormControl<String>(value: 'John Doe'),
  'email': FormControl<String>(),
});
```

## Default Values

Notice in the example above that for the _name_ field, we have set a default value. For the _email_ field, the default value is **null**.

## How to Get/Set Form Data

Given the **FormGroup**:

```dart
final form = FormGroup({
  'name': FormControl<String>(value: 'John Doe'),
  'email': FormControl<String>(value: 'johndoe@email.com'),
});
```

You can get the value of a single **FormControl** as simply as:

```dart
String get name => this.form.control('name').value;
```

You can also get the complete _Form_ data as follows:

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

To set values to controls, you can use two approaches:

```dart
// Set the value directly to the control
this.form.control('name').value = 'John';

// Set values to controls by setting the value to the form
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

> If at least one **FormControl** is **invalid**, then the FormGroup is **invalid**.

There are common predefined validators, but you can also implement custom validators.

### Predefined Validators

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
To implement a custom validator, you can follow two different approaches:

1. Extend the `Validator` class and override the `validate` method.
2. Implement a custom validator function/method and use it with the `Validators.delegate(...)` validator.

Let's implement a custom validator that validates that a control's value must be `true`:

### Inheriting from the `Validator` class:

Let's create a class that extends `Validator` and overrides the `validate` method:

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

The `validate` method is a function that receives the _control_ to validate and returns a `Map`. If the value of the _control_ is valid, the function returns `null`; otherwise, it returns a `Map` with the error key and custom information. In the previous example, we defined `requiredTrue` as the error key and `true` as the custom information.

To use the new validator class, we provide an instance of it in the FormControl definition.

```dart
final form = FormGroup({
  'acceptLicense': FormControl<bool>(
    value: false,
    validators: [
      RequiredTrueValidator(), // Providing the new custom validator
    ],
  ),
});
```

### Using the `Validators.delegate()` validator:

Sometimes, it's more convenient to implement a custom validator in a separate method/function than in a new class. In that case, it's necessary to use the `Validators.delegate()` validator. It creates a validator that delegates the validation to the external function/method.

```dart
final form = FormGroup({
  'acceptLicense': FormControl<bool>(
    value: false,
    validators: [
      Validators.delegate(_requiredTrue) // Delegates validation to a custom function
    ],
  ),
});
```

```dart
/// Custom function that validates that the control's value must be `true`.
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

**_Validator.pattern_** is a validator that comes with **Reactive Forms**. Validation using regular expressions has always been a very useful tool to solve validation requirements. Let's see how we can validate American Express card numbers:

> American Express card numbers start with 34 or 37 and have 15 digits.

```dart
const americanExpressCardPattern = r'^3[47][0-9]{13}$';

final cardNumber = FormControl<String>(
  validators: [Validators.pattern(americanExpressCardPattern)],
);

cardNumber.value = '395465465421'; // Not a valid number

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

### FormGroup Validators

There are special validators that can be attached to a **FormGroup**. In the next section, we will see an example of that.

## What about Password and Password Confirmation?

There are some cases where we want to implement a Form where the validation of one field depends on the value of another. For example, a sign-up form with _email_ and _emailConfirmation_ or _password_ and _passwordConfirmation_.

For those cases, we can implement a custom validator as a class and attach it to the **FormGroup**. Let's see an example:

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

> Notice the use of **_Validators.minLength(8)_**

In the previous code, we added two more fields to the form: _password_ and _passwordConfirmation_. Both fields are required, and the password must be at least 8 characters long.

However, the most important thing here is that we have attached a **validator** to the **FormGroup**. This validator is a custom validator, and the implementation is as follows:

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

      // Force messages to show up as soon as possible
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  }
}
```

Fortunately, you don't have to implement a custom _must match_ validator because we have already included it in the **reactive_forms** package, so you should reuse it. The previous form definition becomes:

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

Sometimes, you want to perform a validation against a remote server. These operations are more time-consuming and need to be done asynchronously.

For example, you want to validate that the _email_ the user is currently typing in a _registration form_ is unique and not already used in your application. **Asynchronous Validators** are just another tool, so use them wisely.

**Asynchronous Validators** are very similar to their synchronous counterparts, with the following difference:

- The validator function returns a [Future](https://api.dart.dev/stable/dart-async/Future-class.html).

Asynchronous validation executes after synchronous validation and is performed only if the synchronous validation is successful. This check allows forms to avoid potentially expensive async validation processes (such as an HTTP request) if the more basic validation methods have already found invalid input.

After asynchronous validation begins, the form control enters a **pending** state. You can inspect the control's `pending` property and use it to give visual feedback about the ongoing validation operation.

Code speaks louder than words, so let's see an example.

Let's implement the previously mentioned example: the user is typing an email in a registration form, and you want to validate that the _email_ is unique in your system. We will implement a _custom async validator_ for that purpose.

```dart
final form = FormGroup({
  'email': FormControl<String>(
    validators: [
      Validators.required, // Traditional required and email validators
      Validators.email,
    ],
    asyncValidators: [
      UniqueEmailAsyncValidator(), // Custom asynchronous validator :)
    ],
  ),
});
```

We have declared a simple **Form** with an email **field** that is _required_ and must have a valid email value. We have also included a custom async validator that will validate if the email is unique. Let's see the implementation of our new async validator:

```dart
/// Validator that validates the user's email is unique by sending a request to
/// the server.
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

  /// Simulates a time-consuming operation (e.g., a server request).
  Future<bool> _getIsUniqueEmail(String email) {
    // Simple array that simulates emails stored in the server DB.
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

> If you want to see **Async Validators** in action with a **full example** using widgets and animations to provide feedback to the user, we strongly advise you to visit our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Asynchronous-Validators). We have not included the full example in this README.md file to simplify things here and not to anticipate things that we will see later in this doc.

> The validator `Validators.delegateAsync()` is another way to implement a custom validator. For more reference,
> check the [Custom Validators](#custom-validators) section.

### Debounce Time in Async Validators

Asynchronous validators have a debounce time that is useful if you want to minimize requests to a remote API. The debounce time is set in milliseconds, and the default value is 250 milliseconds.

You can set a different debounce time as an optional argument in the **FormControl** constructor.

```dart
final control = FormControl<String>(
  asyncValidators: [UniqueEmailAsyncValidator()],
  asyncValidatorsDebounceTime: 1000, // Sets a 1-second debounce time.
);
```

### Custom Debounce Time in Async Validators

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

### Custom Debounce Time in delegateAsync Validator

The `Validators.delegateAsync()` function now accepts an optional `debounceTime` parameter, defaulting to 0. This allows for immediate execution or custom debouncing for asynchronous validation.

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
In this text field, the user can write an **email** or a **phone number**, and we want to make sure that the information is correctly formatted. We must validate that the input is a valid email or a valid phone number.

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

> Note that **Validators.composeOR** receives a collection of validators as an argument and returns a validator.

With **Validators.composeOR**, we are telling the **FormControl** that **if at least one validator evaluates as VALID, then the control is VALID**. It's not necessary for both validators to evaluate to valid.

Another example could be to validate multiple Credit Card numbers. In that case, you have several regular expression patterns for each type of credit card. So, the user can introduce a card number, and if the information matches at least one pattern, then the information is considered valid.

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

**FormGroup** is not restricted to containing only **FormControl**; it can nest other **FormGroups**, so you can create more complex **Forms**.

Suppose you have a _Registration Wizard_ with several screens. Each screen collects specific information, and at the end, you want to collect all that information as one piece of data:

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

> Note how we have set the _data type_ to a **FormControl**. Although this is not mandatory when
> declaring a _Form_, we highly recommend this syntax as a good practice or to use the FormBuilder
> syntax.

Using **FormBuilder** _(read the FormBuilder section below)_:

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

The previous method outputs a _Map_ like the following one:

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

And of course, you can access a nested **FormGroup** as follows:

```dart
FormGroup personalForm = form.control('personal');
```

A simple way to create a wizard is, for example, to wrap a [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) within a **ReactiveForm**, and each _Page_ inside the [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) can contain a **ReactiveForm** to collect specific data.

## Dynamic Forms with **FormArray**

FormArray is an alternative to **FormGroup** for managing any number of unnamed controls. As with **FormGroup** instances, you can dynamically insert and remove controls from **FormArray** instances, and the form array instance value and validation status are calculated from its child controls.

You don't need to define a _key_ for each control by _name_, so this is a great option if you don't know the number of child values in advance.

Let's see a simple example:

```dart
final form = FormGroup({
  'emails': FormArray<String>([]), // An empty array of emails
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

> Note that you don't have to specify the name of the controls inside the array.

If we output the _value_ of the previous form group, we will get something like this:

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

// Adding another email
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

Another way to add controls is to assign values directly to the array:

```dart
// Given: an empty array of strings
final array = FormArray<String>([]);

// When: set value to the array
array.value = ["john@email.com", "susan@email.com", "caroline@email.com"];

// Then: the array is no longer empty
expect(array.controls.length, 3);

// And: the array has a control for each inserted value
expect(array.controls('0').value, "john@email.com");
expect(array.controls('1').value, "susan@email.com");
expect(array.controls('2').value, "caroline@email.com");
```

> To get a control from the array, you must pass the index position as a _String_. This is because **FormGroup** and **FormArray** inherit from the same parent class, and **FormControl** gets the controls by name (String).

A more advanced example:

```dart
// An array of contacts
final contacts = ['john@email.com', 'susan@email.com', 'caroline@email.com'];

// A form with a list of selected emails
final form = FormGroup({
  'selectedEmails': FormArray<bool>([], // An empty array of controls
    validators: [emptyAddressee], // Validates that at least one email is selected
  ),
});

// Get the array of controls
final formArray = form.control('selectedEmails') as FormArray<bool>;

// Populates the array of controls.
// For each contact, add a boolean form control to the array.
formArray.addAll(
  contacts.map((email) => FormControl<bool>(value: true)).toList(),
);
```

```dart
// Validates that at least one email is selected
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
// An array of groups
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
// An array of groups using FormBuilder
final addressArray = fb.array([
  fb.group({'city': 'Sofia', 'zipCode': 1000}),
  fb.group({'city': 'Havana', 'zipCode': 10400}),
]);
```

or just:

```dart
// An array of groups using a very simple syntax
final addressArray = fb.array([
  {'city': 'Sofia', 'zipCode': 1000},
  {'city': 'Havana', 'zipCode': 10400},
]);
```

You can iterate over groups as follows:

```dart
final cities = addressArray.controls
        .map((control) => control as FormGroup)
        .map((form) => form.control('city').value)
        .toList();
```

> A common mistake is to declare an _array_ of groups as _FormArray<FormGroup>_.
> An array of _FormGroup_ must be declared as **FormArray()** or as **FormArray<Map<String, dynamic>>()**.

## FormBuilder

The **FormBuilder** provides syntactic sugar that shortens the creation of instances of a FormGroup, FormArray, and FormControl. It reduces the amount of boilerplate needed to build complex forms.

### Groups

```dart
// Creates a group
final form = fb.group({
  'name': 'John Doe',
  'email': ['', Validators.required, Validators.email],
  'password': Validators.required,
});
```

The previous code is equivalent to the following:

```dart
final form = FormGroup({
  'name': FormControl<String>(value: 'John Doe'),
  'email': FormControl<String>(value: '', validators: [Validators.required, Validators.email]),
  'password': FormControl<String>(validators: [Validators.required]),
});
```

### Arrays

```dart
// Creates an array
final aliases = fb.array(['john', 'little john']);
```

### Control

```dart
// Creates a control of type String with a required validator
final control = fb.control<String>('', [Validators.required]);
```

### Control State

```dart
// Create a group
final group = fb.group(
  // Creates a control with a default value and disabled state
  'name': fb.state(value: 'john', disabled: true),
);
```

## Nested Controls

To retrieve nested controls, you can specify the name of the control as a dot-delimited string that defines the path to the control:

```dart
final form = FormGroup({
  'address': FormGroup({
    'city': FormControl<String>(value: 'Sofia'),
    'zipCode': FormControl<int>(value: 1000),
  }),
});

// Get nested control value
final city = form.control('address.city');

print(city.value); // Outputs: Sofia
```

## Reactive Form Widgets

So far, we have only defined our model-driven form, but how do we bind the form definition with our Flutter widgets? Reactive Form Widgets are the answer.

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

## How to Customize Error Messages?

Validation messages can be defined at two different levels:

1. Reactive Widget level.
2. Global/Application level.

### 1. Reactive Widget Level.

Each reactive widget, like `ReactiveTextField`, `ReactiveDropdownField`, and all others, has the
`validationMessages` property as an argument of their constructors. To define custom
validation messages at the widget level, just provide the `validationMessages` property with the
corresponding text values for each error, as shown below:

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

> **Reactive Forms** has a utility class called **ValidationMessage** that provides access to
> common _validation messages_: _required_, _email_, _pattern_, and so on. So instead of writing 'required', you
> could use _ValidationMessage.required_ as the key of validation messages:
>
> ```dart
> return ReactiveTextField(
>    formControlName: 'email',
>    validationMessages: {
>      ValidationMessage.required: (error) => 'The email must not be empty',
>      ValidationMessage.email: (error) => 'The email value must be a valid email',
>    },
> );
> ```
>
> Nice, isn't it? ;)

### 2. Global/Application Level.

You can also define custom validation messages at a higher level, for example, at the application
level. When a reactive widget looks for an error message text, it first looks at the widget-level
definition. If it doesn't find any config at the widget level, then it looks at the global config
definition.

The global definition of validation messages allows you to define error messages in a centralized
way and relieves you from defining validation messages on each reactive widget of your application.

To define these configs at a higher level, use the widget **ReactiveFormConfig** and
define the `validationMessages`.

Here is an example of the global definition for custom validation messages:

### Validation Messages with Error Arguments:

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

### Parameterized Validation Messages

You can enrich the validation messages using parameters of the error instance. In the next example,
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

## When do Validation Messages Appear?

### Touching a Control

Even when the **FormControl** is invalid, validation messages will begin to show up when the **FormControl** is **touched**. That means when the user taps on the **ReactiveTextField** widget and then removes focus or completes the text editing.

You can initialize a **FormControl** as **touched** to force the validation messages to show up the very first time the widget builds.

```dart
final form = FormGroup({
  'name': FormControl<String>(
    value: 'John Doe',
    validators: [Validators.required],
    touched: true,
  ),
});
```

When you set a _value_ to a **FormControl** from code and want to show validation messages,
you must call the _FormControl.markAsTouched()_ method:

```dart
set name(String newName) {
  final formControl = this.form.control('name');
  formControl.value = newName;
  formControl.markAsTouched(); // If newName is invalid, then validation messages will show up in the UI
}
```

> To mark all children controls of a **FormGroup** and **FormArray** as touched, you must call **markAllAsTouched()**.
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
> // Marks all children as touched
> form.markAllAsTouched();
> ```

### Overriding Reactive Widgets Show Errors Behavior

The second way to customize when to show error messages is to override the **showErrors** method in reactive widgets.

Let's suppose you want to show validation messages not only when it is **invalid** and **touched** (default behavior), but also when it's **dirty**:

```dart
ReactiveTextField(
  formControlName: 'email',
  // Override default behavior and show errors when: INVALID, TOUCHED, and DIRTY
  showErrors: (control) => control.invalid && control.touched && control.dirty,
),
```

> A control becomes **dirty** when its value changes through the UI.
> The **setErrors** method of the controls can optionally mark it as dirty too.

## Enable/Disable Submit Button

For a better User Experience, sometimes we want to enable/disable the _Submit_ button based on the validity of the _Form_. Achieving this behavior, even in a great framework like Flutter, can sometimes be hard and can lead to individual implementations for each _Form_ of the same application, plus boilerplate code.

We will show you two different approaches to accomplish this very easily:

1. Separating the Submit Button into a different Widget.
2. Using the **ReactiveFormConsumer** widget.

### Separating Submit Button in a Separate Widget:

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

In the previous example, we separated the implementation of the _submit_ button into a different widget. The reason behind this is that we want to rebuild the _submit_ button each time the _validity_ of the **FormGroup** changes. We don't want to rebuild the entire _Form_, just the button.

How is that possible? Well, the answer is in the expression:

```dart
final form = ReactiveForm.of(context);
```

The expression above has two important responsibilities:

- Obtains the nearest **FormGroup** up the widget's tree.
- Registers the current **context** with the changes in the **FormGroup** so that if the validity of the **FormGroup** changes, the current **context** is _rebuilt_.

### Using the **ReactiveFormConsumer** widget:

The **ReactiveFormConsumer** widget is a wrapper around the **ReactiveForm.of(context)** expression so that we can reimplement the previous example as follows:

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

> It is entirely up to you to decide which of the above two approaches to use, but note that to access the **FormGroup** via **ReactiveForm.of(context)**, the consumer widget must always be down in the tree of the **ReactiveForm** widget.

## Focus/Unfocus a **FormControl**

There are some cases where we want to add or remove focus on a UI TextField without the user's interaction. For those particular cases, you can use the **FormControl.focus()** or **FormControl.unfocus()** methods.

```dart
final form = fb.group({'name': 'John Doe'});

FormControl control = form.control('name');

control.focus(); // UI text field gets focus, and the device keyboard pops up

control.unfocus(); // UI text field loses focus
```

You can also set focus directly from the Form like this:

```dart
final form = fb.group({'name': ''});

form.focus('name'); // UI text field gets focus, and the device keyboard pops up
```

```dart
final form = fb.group({
  'person': fb.group({
    'name': '',
  }),
});

// Set focus to a nested control
form.focus('person.name');
```

## Focus Flow Between Text Fields

Another example is when you have a form with several text fields, and each time the user completes editing in one field, you want to request the next focus field using keyboard actions:

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

> When you remove focus from a control, the control is marked as touched. This means that the validation error messages will show up in the UI. To prevent validation messages from showing up, you can optionally set the **touched** argument to _false_.
>
> ```dart
> // Remove the focus from the control and mark it as untouched.
> this.form.unfocus(touched: false);
> ```

## How to Enable/Disable a Widget

To disable a widget like **ReactiveTextField**, all you need to do is _mark_ the _control_ as disabled:

```dart
final form = FormGroup({
  'name': FormControl<String>(),
});

FormControl control = form.control('name');

// The control is disabled, and the widget in the UI is also disabled.
control.markAsDisabled();
```

> When a control is disabled, it is exempt from validation checks and excluded from the aggregate
> value of any parent. Its status is **DISABLED**.
>
> To retrieve all values of a FormGroup or FormArray regardless of the disabled status of children, use
> **FormControl.rawValue** or **FormArray.rawValue**, respectively.

## How does **ReactiveTextField** differ from native [TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html) or [TextField](https://api.flutter.dev/flutter/material/TextField-class.html)?

**ReactiveTextField** has more in common with _TextFormField_ than with _TextField_. As we all know, _TextFormField_ is a wrapper around the _TextField_ widget that brings some extra capabilities, such as _Form validations_ with properties like _autovalidate_ and _validator_. In the same way, **ReactiveTextField** is a wrapper around _TextField_ that handles the features of validations in its own different way.

**ReactiveTextField** has all the properties that you can find in a common _TextField_. It can be customized as much as you want, just like a simple _TextField_ or a _TextFormField_. In fact, most of the code was taken from the original TextFormField and ported to have a reactive behavior that binds itself to a **FormControl** in a **two-way** binding.

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

> Because of the **two-way binding** capability of the **ReactiveTextField** with a **FormControl**,
> the widget **does not** include properties like _controller_, _validator_, _autovalidate_, or _onSaved_.
> The **FormControl** is responsible for handling validation as well as change
> notifications.
>
> It does include some events like **onChanged**, **onTap**, **onEditingComplete**,
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

We are trying to keep `reactive_forms` from bloating with third-party dependencies. This is why there is
a separate library, [`reactive_forms_widgets`](https://pub.dev/packages/reactive_forms_widgets), which is still under construction, that provides
a variety of more advanced field widgets. To know more about how to install it, please visit the library repo and read the documentation about the widgets it contains.

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

We have explained the common usage of a **ReactiveTextField** throughout this documentation.

### ReactiveDropdownField

**ReactiveDropdownField**, like all the other _reactive field widgets_, is almost the same as its native version, [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html), but adds two-way binding capabilities. The code is ported from the original native implementation. It has all the capability of styles and themes of the native version.

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

> As you can see from the above example, the usage of **ReactiveDropdownField** is almost the same as the usage of a common [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html), except for the additional _formControlName_ and _validationMessages_ properties.

## **ReactiveValueListenableBuilder** to Listen for Value Changes in a **FormControl**

If you want to rebuild a widget each time a FormControl value changes, you can use the **ReactiveValueListenableBuilder** widget.

In the following example, we are listening for changes in _lightIntensity_. We change that value with a **ReactiveSlider** and show the value in a **Text** widget all the time:

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

## **ReactiveForm** vs. **ReactiveFormBuilder**: Which to Choose?

Both widgets are responsible for exposing the **FormGroup** to descendant widgets in the tree. Let's see an example:

```dart
// Using ReactiveForm
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
// Using ReactiveFormBuilder
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

The main differences are that **ReactiveForm** is a _StatelessWidget_, so it doesn't save the instance of the **FormGroup**. You must declare the instance of the **FormGroup** in a StatefulWidget or resolve it from some Provider (state management library).

```dart
// Using ReactiveForm in a StatelessWidget and resolving the FormGroup from a provider
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
// Using ReactiveForm in a StatefulWidget and declaring the FormGroup in the state.
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

> If you declare a **FormGroup** in a _StatelessWidget_, the _group_ will be destroyed and recreated each time the instance of the _StatelessWidget_ is destroyed and created. Therefore, you must preserve the **FormGroup** in a state or in a Bloc/Provider/etc.

On the other hand, **ReactiveFormBuilder** is implemented as a _StatefulWidget_, so it holds the created **FormGroup** in its state. That way, it's safe to declare the **FormGroup** in a StatelessWidget or get it from a Bloc/Provider/etc.

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
- You are using a State Management library like Provider or Bloc.
- Using a StatefulWidget to declare a very simple form is something that really doesn't bother you.

You should use **ReactiveFormBuilder** if:

- The form is simple enough and doesn't need a separate Provider/Bloc state.
- You don't want to use a StatefulWidget to declare the FormGroup.

But the final decision is really up to you; you can use any of them in any situation.

## Widget Testing

**Note: Mark your fields with `Key`s for easy access via the widget tester.**

### Example Component

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

### Example Test

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

Although **Reactive Forms** can be used with any state management library or even without one at all, **Reactive Forms** reaches its maximum potential when used in combination with a state management library like the [Provider](https://pub.dev/packages/provider) plugin.

This way, you can separate UI logic from business logic, and you can define the **FormGroup** inside a business logic class and then expose that class to widgets with a mechanism like the one the [Provider](https://pub.dev/packages/provider) plugin provides.

## Reactive Forms + [Code Generation](https://pub.dev/packages/reactive_forms_generator) 🤖

[ReactiveFormsGenerator](https://pub.dev/packages/reactive_forms_generator) is the code generator for reactive_forms that will save you tons of time and make your forms type-safe.

There is no reason to write code manually! Let the code generation work for you.

## How to Create a Custom Reactive Widget?

**Reactive Forms** is not limited to just common widgets in _Forms_ like text, dropdowns, sliders, switch fields, etc. You can easily create **custom widgets** that **two-way** bind to **FormControls** and create your own set of _Reactive Widgets_.

In our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Custom-Reactive-Widgets), you can find a tutorial on how to create your custom Reactive Widget.

You can also check the [Star Rating with Flutter Reactive Forms](https://dev.to/joanpablo/star-rating-with-flutter-reactive-forms-2d52) post as another example of a custom reactive widget.

## What **Reactive Forms** is Not

- **Reactive Forms** is not a fancy widgets package. It is not a library that brings new Widgets with new shapes, colors, or animations. It lets you decide the shapes, colors, and animations you want for your widgets but frees you from the responsibility of gathering and validating the data. It also keeps the data in sync between your model and your widgets.

- **Reactive Forms** does not pretend to replace the native widgets that you commonly use in your Flutter projects, like _TextFormField_, _DropdownButtonFormField_, or _CheckboxListTile_. Instead, it brings new two-way binding capabilities and many more features to those same widgets.

## What **Reactive Forms** Is

- **Reactive Forms** provides a model-driven approach to handling form inputs whose values change over time. It's heavily inspired by Angular Reactive Forms.
- It lets you focus on business logic and saves you time from collecting, validating, and maintaining synchronization between your models and widgets.
- It removes boilerplate code and gives you the possibility to write clean code by defining a separation between model and UI with minimal effort.
- It integrates perfectly well with common state management libraries like [Provider](https://pub.dev/packages/provider), [Bloc](https://pub.dev/packages/bloc), and many other good libraries the community has created.

## Migration Versions

Visit the [Migration Guide](https://github.com/joanpablo/reactive_forms/wiki/Migration-Guide) to see
more details about different version breaking changes.
