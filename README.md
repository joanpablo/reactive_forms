# Reactive Forms

This is a model-driven approach to handling Forms inputs and validations, heavily inspired in [Angular's Reactive Forms](https://angular.io/guide/reactive-forms).

![Pub Version](https://img.shields.io/pub/v/reactive_forms) ![GitHub](https://img.shields.io/github/license/joanpablo/reactive_forms) ![GitHub top language](https://img.shields.io/github/languages/top/joanpablo/reactive_forms) ![flutter tests](https://github.com/joanpablo/reactive_forms/workflows/flutter%20tests/badge.svg?branch=master) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/a4e40d632feb41b5af624cbd36064c83)](https://www.codacy.com/manual/joanpablo/reactive_forms?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=joanpablo/reactive_forms&amp;utm_campaign=Badge_Grade) [![codecov](https://codecov.io/gh/joanpablo/reactive_forms/branch/master/graph/badge.svg)](https://codecov.io/gh/joanpablo/reactive_forms)

## Getting Started

For help getting started with Flutter, view the 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Minimum Requirements

- Dart SDK: >=2.7.0 <3.0.0
- Flutter: >= 1.17.0

## Installation and Usage

Once you're familiar with Flutter you may install this package adding `reactive_forms` to the dependencies list
of the `pubspec.yaml` file as follow:

```yaml
dependencies:
  flutter:
    sdk: flutter

  reactive_forms: ^7.3.0
```

Then run the command `flutter packages get` on the console.

## Creating a form

A *form* is composed by multiple fields or *controls*.

To declare a form with the fields *name* and *email* is as simple as:

```dart
final form = FormGroup({
  'name': FormControl(value: 'John Doe'),
  'email': FormControl(),
});
```

## Default Values

Notice in the example above that in the case of the *name* we have also set a default value, in the case of the *email* the default value is **null**.

## How to get/set Form data

Given the **FormGroup**:

```dart
final form = FormGroup({
  'name': FormControl(value: 'John Doe'),
  'email': FormControl(value: 'johndoe@email.com'),
});
```

You can get the value of a single **FormControl** as simple as:

```dart
String get name() => this.form.control('name').value;
```

But you can also get the complete *Form* data as follows:

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

#### FormGroup
- Validators.mustMatch
- Validators.compare

#### FormArray
- Validators.minLength
- Validators.maxLength
- Validators.any
- Validators.contains

### Custom Validators
A custom **FormControl** validator is a function that receives the *control* to validate and returns a **Map**. If the the value of the *control* is valid the function must returns **null** otherwise returns a **Map** with a key and custom information, in the previous example we just set **true** as custom information.

Let's implement a custom validator that validates a control's value must be *true*:

```dart
final form = FormGroup({
  'acceptLicense': FormControl<bool>(
    value: false, 
    validators: [_requiredTrue], // custom validator
  ),
});
```

```dart
/// Validates that control's value must be `true`
Map<String, dynamic> _requiredTrue(AbstractControl control) {
  return control.isNotNull && 
         control.value is bool && 
         control.value == true 
  ? null 
  : {'required': true};
}
``` 

> You can see the current implementation of predefined validators in the source code to see more examples.

### Pattern Validator

***Validator.pattern*** is a validator that comes with **Reactive Forms**. Validation using regular expressions have been always a very useful tool to solve validation requirements. Let's see how we can validate American Express card numbers: 

> American Express card numbers start with 34 or 37 and have 15 digits.

```dart
const AmericanExpressPattern = r'^3[47][0-9]{13}$';

final cardNumber = FormControl(
  validators: [Validators.pattern(AmericanExpressPattern)],
);

cardNumber.value = '395465465421'; // not a valid number

expect(cardNumber.valid, false);
expect(cardNumber.hasError('pattern'), true);
```
> The above code is a Unit Test extracted from **Reactive Forms** tests.

If we *print* the value of **FormControl.errors**:

```dart
print(cardNumber.errors);
```

 We will get a *Map* like this:

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

There are some cases where we want to implement a Form where a validation of a field depends on the value of another field. For example a sign-up form with *email* and *emailConfirmation* or *password* and *passwordConfirmation*.

For that cases we must implement a custom validator and attach it to the **FormGroup**, let's see an example:

```dart
final form = FormGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [Validators.required, Validators.email]),
  'password': FormControl(validators: [
    Validators.required,
    Validators.minLength(8),
  ]),
  'passwordConfirmation': FormControl(),
}, validators: [
  _mustMatch('password', 'passwordConfirmation')
]);
```
> Notice the use of *Validators.**minLength(8)***

In the previous code we have added two more fields to the form: *password* and *passwordConfirmation*, both fields are required and the password must be at least 8 characters length.

However the most important thing here is that we have attached a **validator** to the **FormGroup**. This validator is a custom validator and the implementation follows as:

```dart
ValidatorFunction _mustMatch(String controlName, String matchingControlName) {
  return (AbstractControl control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});

      // force messages to show up as soon as possible
      matchingFormControl.markAsTouched(); 
    } else {
      matchingFormControl.setErrors({});
    }

    return null;
  };
}
```

Fortunately you don't have to implement a custom *must match* validator because we have already included it into the code of the **reactive_forms** package so you could reuse it. The previous form definition example will become into:

```dart
final form = FormGroup({
  'name': FormControl(validators: [Validators.required]),
  'email': FormControl(validators: [Validators.required, Validators.email]),
  'emailConfirmation': FormControl(),
  'password': FormControl(validators: [
    Validators.required,
    Validators.minLength(8),
  ]),
  'passwordConfirmation': FormControl(),
}, validators: [
  Validators.mustMatch('email', 'emailConfirmation'),
  Validators.mustMatch('password', 'passwordConfirmation'),
]);
```

## Asynchronous Validators :sunglasses:

Some times you want to perform a validation against a remote server, this operations are more time consuming and need to be done asynchronously. 

For example you want to validate that the *email* the user is currently typing in a *registration form* is unique and is not already used in your application. **Asynchronous Validators** are just another tool so use it wisely.

**Asynchronous Validators** are very similar to their synchronous counterparts, with the following difference:

- The validator function returns a [Future](https://api.dart.dev/stable/dart-async/Future-class.html)

Asynchronous validation executes after the synchronous validation, and is performed only if the synchronous validation is successful. This check allows forms to avoid potentially expensive async validation processes (such as an HTTP request) if the more basic validation methods have already found invalid input.

After asynchronous validation begins, the form control enters a **pending** state. You can inspect the control's pending property and use it to give visual feedback about the ongoing validation operation.

Code speaks more than a thousand words :) so let's see an example.

Let's implement the previous mentioned example: the user is typing the email in a registration Form and you want to validate that the *email* is unique in your System. We will implement a *custom async validator* for that purpose.

```dart
final form = FormGroup({
  'email': FormControl<String>(
    validators: [
      Validators.required, // traditional required and email validators
      Validators.email,
    ],
    asyncValidators: [_uniqueEmail], // custom asynchronous validator :)
  ),
});
```

We have declared a simple **Form** with an email **field** that is *required* and must have a valid email value, and we have include a custom async validator that will validate if the email is unique. Let's see the implementation of our new async validator:

```dart
/// just a simple array to simulate a database of emails in a server
const inUseEmails = ['johndoe@email.com', 'john@email.com'];

/// Async validator example that simulates a request to a server
/// and validates if the email of the user is unique.
Future<Map<String, dynamic>> _uniqueEmail(AbstractControl control) async {
  final error = {'unique': false};

  final emailAlreadyUsed = await Future.delayed(
    Duration(seconds: 5), // a delay to simulate a time consuming operation
    () => inUseEmails.contains(control.value),
  );

  if (emailAlreadyUsed) {
    control.markAsTouched();
    return error;
  }

  return null;
}
```
> Note the use of **control.markAsTouched()** to force the validation message to show up as soon as possible.

The previous implementation was a simple function that receives the **AbstractControl** and returns a [Future](https://api.dart.dev/stable/dart-async/Future-class.html) that completes 5 seconds after its call and performs a simple check: if the *value* of the *control* is contained in the *server* array of emails.

>If you want to see **Async Validators** in action with a **full example** using widgets and animations to feedback the user we strong advice you to visit our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Asynchronous-Validators). We have not included the full example in this README.md file just to simplify things here and to not anticipate things that we will see later in this doc.

### Debounce time in async validators  

Asynchronous validators have a debounce time that is useful if you want to minimize requests to a remote API. The debounce time is set in milliseconds and the default value is 250 milliseconds.

You can set a different debounce time as an optionally argument in the **FormControl** constructor.

```dart
final control = FormControl(
  asyncValidators: [_uniqueEmail],
  asyncValidatorsDebounceTime: 1000, // sets 1 second of debounce time.
);
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

Using **FormBuilder** *(read FormBuilder section below)*:

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
  'address': FormGroup({
    'street': ['', Validators.required],
    'city': ['', Validators.required],
    'zip': ['', Validators.required],
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
FormGroup personalForm = form.control('personal');
```

A simple way to create a wizzard is for example to wrap a [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) within a **ReactiveForm** and each *Page* inside the [PageView](https://api.flutter.dev/flutter/widgets/PageView-class.html) can contains a **ReactiveForm** to collect specific data.

## Dynamic forms with **FormArray**

FormArray is an alternative to **FormGroup** for managing any number of unnamed controls. As with **FormGroup** instances, you can dynamically insert and remove controls from **FormArray** instances, and the form array instance value and validation status is calculated from its child controls.

You don't need to define a *key* for each control by *name*, so this is a great option if you don't know the number of child values in advance.

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

If we output the *value* of the previous form group we will get something like this:

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
> To get a control from the array you must pass the index position as a *String*. This is because **FormGroup** and **FormArray** inherited from the same parent class and **FormControl** gets the controls by name (String).

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
````

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
    'city': FormControl(value: 'Sofia'),
    'zipCode': FormControl(value: 1000),
  }),
  FormGroup({
    'city': FormControl(value: 'Havana'),
    'zipCode': FormControl(value: 10400),
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
        .forEach((form) => form.control('city').value);
```

> A common mistake is to declare an *array* of groups as *FormArray&lt;FormGroup&gt;*.   
>An array of *FormGroup* must be declared as **FormArray()** or as **FormArray&lt;Map&lt;String, dynamic&gt;&gt;()**.

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
  'password': FormControl(validators: [Validators.required]),
});
```  

### Arrays

```dart
// creates an array
final aliases = fb.array(['john', 'little john']);
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
    'zipCode': FormControl<int>(value: 1000),
    'city': FormControl<String>(value: 'Sofia'),
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
          validationMessages: (control) => {
            'required': 'The name must not be empty'
          },
        ),
        ReactiveTextField(
          formControlName: 'email',
          validationMessages: (control) => {
            'required': 'The email must not be empty',
            'email': 'The email value must be a valid email'
          },
        ),
        ReactiveTextField(
          formControlName: 'password',
          obscureText: true,
          validationMessages: (control) => {
            'required': 'The password must not be empty',
            'minLenght': 'The password must have at least 8 characters'
          },
        ),
      ],
    ),
  );
}
```

> **Reactive Forms** have an utility class called **ValidationMessage** that brings access to 
> common *validation messages*: *required*, *email*, *pattern* and so on. So instead of write 'required' you
> could use *ValidationMessage.required* as the key of validation messages:
> ```dart
> return ReactiveTextField(
>    formControlName: 'email',
>    validationMessages: (control) => {
>      ValidationMessage.required: 'The email must not be empty',
>      ValidationMessage.email: 'The email value must be a valid email',
>    },
> ),
> ````
> nice isn't it? ;)

## When does Validation Messages begin to show up?

### Touching a control

Even when the **FormControl** is invalid, validation messages will begin to show up when the **FormControl** is **touched**. That means when the user taps on the **ReactiveTextField** widget and then remove focus or completes the text edition.

You can initialize a **FormControl** as **touched** to force the validation messages to show up at the very first time the widget builds.

```dart
final form = FormGroup({
  'name': FormControl(
    value: 'John Doe',
    validators: [Validators.required],
    touched: true,
  ),
});
```

When you set a *value* to a **FormControl** from code and want to show up validations messages 
you must call *FormControl.markAsTouched()* method:

```dart
set name(String newName) {
  final formControl = this.form.control('name');
  formControl.value = newName;
  formControl.markAsTouched();// if newName is invalid then validation messages will show up in UI
}
```

>To mark all children controls of a **FormGroup** and **FormArray** you must call **markAllAsTouched()**.
>```dart
> final form = FormGroup({
>   'name': FormControl(
>     value: 'John Doe',
>     validators: [Validators.required],
>     touched: true,
>   ),
> });
> 
> // marks all children as touched
> form.markAllAsTouched();
>```
>

### Overriding Reactive Widgets *show errors* behavior

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

For a better User Experience some times we want to enable/disable the *Submit* button based on the validity of the *Form*. Getting this behavior, even in such a great framework as Flutter, some times can be hard and can lead to have individual implementations for each *Form* of the same application plus boilerplate code.  

We will show you two different approaches to accomplish this very easily:
1. Separating Submit Button in a different Widget.
2. Using **ReactiveFormConsumer** widget.

### Separating Submit Button in a different Widget:
Let's add a submit button to our *Form*:

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

> Notice the use of ***ReactiveForm.of(context)*** to get access to the nearest **FormGroup** up the widget's tree.

In the previous example we have separated the implementation of the *submit* button in a different widget. The reasons behind this is that we want to re-build the *submit* button each time the *validity* of the **FormGroup** changes. We don't want to rebuild the entire *Form*, but just the button.

How is that possible? Well, the answer is in the expression:

```dart
final form = ReactiveForm.of(context);
```

The expression above have two important responsibilities:
- Obtains the nearest **FormGroup** up the widget's tree.
- Registers the current **context** with the changes in the **FormGroup** so that if the validity of the **FormGroup** changes then the current **context** is *rebuilt*.  

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

Another example is when you have a form with several text fields and each time the user completes edition in one field you wnat to request next focus field using the keyboard actions:

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

>When you remove focus of a control, the control is marked as touched, that means that the validation error messages will show up in UI. To prevent validation messages to show up you can optionally set argument **touched** to *false*.
>
>```dart
>// remove the focus to the control and marks it as untouched. 
>this.form.unfocus(touched: false);
>```

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
        ),
      ],
    ),
  );
}
```

> As you can see from the above example the usage of **ReactiveDropdownField** is almost the same as the usage of a common [DropdownButtonFormField](https://api.flutter.dev/flutter/material/DropdownButtonFormField-class.html), except for the additional *formControlName* and *validationMessages* properties.

## **ReactiveValueListenableBuilder** to listen when value changes in a **FormControl**

If you want to rebuild a widget each time a FormControl value changes you could use the **ReactiveValueListenableBuilder** widget.

In the following example we are listening for changes in *lightIntensity*. We change that value with a **ReactiveSlider** and show all the time the value in a **Text** widget:

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

The main differences are that **ReactiveForm** is a *StatelessWidget* so it doesn't save the instance of the **FormGroup**. You must declare the instance of the **FormGroup** in a StatefulWidget or resolve it from some Provider (state management library).

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

> If you declare a **FormGroup** in a *StatelessWidget* the *group* will be destroyed a created each time the instance of the *StatelessWidget* is destroyed and created, so you must preserve the **FormGroup** in a state or in a Bloc/Provider/etc.

By the other hand **ReactiveFormBuilder** is implemented as a *StatefulWidget* so it holds the created **FormGroup** in its state. That way is safe to declares the **FormGroup** in a StatelessWidget or get it from a Bloc/Provider/etc.

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

## Reactive Forms + [Provider](https://pub.dev/packages/provider) plugin :muscle:

Although **Reactive Forms** can be used with any state management library or even without any one at all, **Reactive Forms** gets its maximum potential when is used in combination with a state management library like the [Provider](https://pub.dev/packages/provider) plugin.

This way you can separate UI logic from business logic and you can define the **FormGroup** inside a business logic class and then exposes that class to widgets with mechanism like the one [Provider](https://pub.dev/packages/provider) plugin brings.

## How create a custom Reactive Widget?

**Reactive Forms** is not limited just to common widgets in *Forms* like text, dropdowns, sliders switch fields and etc, you can easily create **custom widgets** that **two-way** binds to **FormControls** and create your own set of *Reactive Widgets* ;)

In our [Wiki](https://github.com/joanpablo/reactive_forms/wiki/Custom-Reactive-Widgets) you can find a tutorial of how to create your custom Reactive Widget. 

You can also check [Star Rating with Flutter Reactive Forms](https://dev.to/joanpablo/star-rating-with-flutter-reactive-forms-2d52) post as another example of a custom reactive widget.

## What is not **Reactive Forms**

- **Reactive Forms** is not a fancy widgets package. It is not a library that brings some new Widgets with new shapes, colors or animations. It lets you to decide the shapes, colors, and animations you want for your widgets, but frees you from the responsibility of gathering and validating the data. And keeps the data in sync between your model and your widgets.

- **Reactive Forms** does not pretend to replace the native widgets that you commonly use in your Flutter projects like *TextFormField*, *DropdownButtonFormField* or *CheckboxListTile*. Instead of that it brings new two-way binding capabilities and much more features to those same widgets.

## What is **Reactive Forms**

- **Reactive Forms** provides a model-driven approach to handling form inputs whose values change over time. It's heavily inspired in Angular Reactive Form.
- It lets you focus on business logic and save you time from collect, validate and mantain synchronization between your models and widgets.
- Remove boilerplate code and brings you the posibility to write clean code defining a separation between model and UI with minimal efforts.
- And it integrates perfectly well with common state management libraries like [Provider](https://pub.dev/packages/provider), [Bloc](https://pub.dev/packages/bloc) and many others good libraries the community has created.

## Migrate versions

Visit [Migration Guide](https://github.com/joanpablo/reactive_forms/wiki/Migration-Guide) to see 
more details about different version breaking changes.