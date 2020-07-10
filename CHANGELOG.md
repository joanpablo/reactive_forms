## [1.0.5] - 2020-07-10

- Added ***ReactiveTextField.onSubmitted*** for an example of how to handle moving to
  the next/previous field when using *TextInputAction.next* and *TextInputAction.previous* 
  for *textInputAction*.
- Included property *ReactiveSwitchListTile.inactiveThumbImage*
- Included properties *autofocus* to *ReactiveCheckbox*, *ReactiveRadio* and *ReactiveSwitch* 
- Included callbacks *ReactiveSlider.onChangeEnd* and *ReactiveSlider.onChangeStart*

## [1.0.4] - 2020-07-09

### Fixes:
- FormArray now correctly notify status depending of children status.

## [1.0.3] - 2020-07-08

### New Validators
- **Async Validators** (only FormControl for now...)
- Controls have now three different states: **VALID**, **INVALID**, **PENDING** 
  (this last one was specially included due to async validators, the control is **PENDING** 
  until validator completes)
- Added documentations about *Validator.pattern*
- Added *Async Validator's* example in example application */example/main.dart* 

### New Models
- **FormArray** (aggregates the values of each child FormControl into an array)

### New Reactive Widgets:
- ReactiveFormArray
- ReactiveCheckboxListTile
- ReactiveSwitchListTile
- ReactiveRadioListTile
- ReactiveStatusListenableBuilder

## [1.0.2] - 2020-07-05

- Added class ValidationMessage for common validation messages key as: *required*, *email*, etc.
- Added Documentation of ValidationMessage.
- Minor typo fix in documentation text.

## [1.0.1] - 2020-07-04

- Added an example application

## [1.0.0] - 2020-07-04

### Predefined validators
- Validators.required
- Validators.email
- Validators.number
- Validators.minLength
- Validators.maxLength
- Validators.pattern

### Supported Reactive Form Fields Widgets

- ReactiveTextField
- ReactiveDropdownField
- ReactiveSwitch
- ReactiveCheckbox
- ReactiveRadio
- ReactiveSlider

### Other Reactive Forms Widgets

- ReactiveForm
- ReactiveFormConsumer
- ReactiveValueListenableBuilder