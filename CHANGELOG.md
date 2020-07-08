## [1.0.3] - 2020-07-08

- Async validators (only FormControl for now...)
- Controls have now three different states: **VALID**, **INVALID**, **PENDING** 
  (this last one was specially included due to async validators, the control is **PENDING** 
  until validator completes)
- Added documentations about *Validator.pattern*
- Added *Async Validator's* example in example application */example/main.dart* 

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