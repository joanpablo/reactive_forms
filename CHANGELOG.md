# 5.0.0

## Breaking changes
- Rename *touch()* and *untouch()* by *markAsTouched()* and *markAsUntouched()*
- Rename *enable()* and *disable()* by *markAsEnabled()* and *markAsDisabled()*
- Add **AbstractControl.markAllAsTouched** to mark all controls of a 
**FromGroup** or a **FormArray** as touched. **AbstractControl.markAsTouched** doesn't marks 
children as touched anymore.
 
## Features
- Add new control status **pristine** and **dirty**.
- **FormGroup.control(String name)** and **FormArray.control(String name)** now let specify the 
*name* argument as a dot-delimited string that represents the path to the nested control as 
*nested1.nested2.nested.3.etc*.
- Add **FormBuilder.array()** and **FormBuilder.control()** for creating *arrays* and *controls*.
- **ReactiveValueListenableBuilder** brings now the possibility to provide directly the *control* 
instead of just the *control name*.

## Validators
- Add validators:
    - **Validators.requiredTrue**
    - **Validators.equals**
    - **Validators.min**
    - **Validators.max**

## Fixes
- **ReactiveRadioListTile** widget is now available.

# 4.0.2

- Fix **FormBuilder.group()** with initial value in null.

## Features

- Add **FormBuilder.state** to create a *ControlState*.

# 4.0.1

- Fix async update in InheritedStreamer widget that raised exception when declare
a form group in a stateless widget.

# 4.0.0

## Features
- **FormControl.reset()** can now set the disabled status of the control as an optional argument.
- Implements **FormGroup.resetState()** and **FormArray.resetState()** to reset children controls 
with initial value and disabled status. 

## Breaking Changes
- **FormControl** constructor receives *value* instead of *defaultValue*. To reset a control
to a initial value you must call **FormControl.reset()** and supply initial value.

# 3.0.1

- Fix Luhn algorithm in credit card validator.

# 3.0.0

- Fixes:
  - **FormGroup.reset()** marks control as untouched and hide UI validation errors.
  - **FormGroup.reset()** sets empty string to input text fields if control value is *null*.

- Features:
  - *InputParser* added to **ReactiveTextField**. Now you can declare a FormControl with **int**
   or **double** data type and bind it to an input text field.
  

# 2.0.8

- Fixed card number length in *Validators.creditCard*

# 2.0.7

- Minor changes and code documentation.
- **New Validator**
  - *Validators.**creditCard*** that validates a credit card number using the [Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm).

# 2.0.6

- Optimized FormGroup and FormArray value gets.
- **FormBuilder** docs added to README.md

# 2.0.5

- fixed ReactiveDropdownField.onChanged not triggered when control value didn't changes

# 2.0.4

- Minor fixes in *ReactiveDropdownField*.  

# 2.0.3  

- Minor fixes.  

# 2.0.2  

- Added basic implementation of **FormBuilder** to build *FormGroup* easily.
- Added *onChanged* callback to *ReactiveDropdownField*.  

# 2.0.1  

- Now ReactiveDropdownField not set value of control to null when no matching item founded.  

# 2.0.0  

- Added onWillPop to ReactiveForm widget.
- Enable/disable controls, groups and arrays.
- Now you can access the parent group or array with the property *FormControl.parent*.

## Fixes  

- Removed restriction of empty item's array in ReactiveDropdown.
- Assert error in ReactiveDropdown when *control* value not match any item values.
- Slider assert error when control bounded to slider initialize in null value.  

## Breaking Changes  

- Use of **Streams** to notify events.
- Renamed event names.

See [Migration Guide](https://github.com/joanpablo/reactive_forms/wiki/Migration-Guide) to see how
to migrate from version 1.x to 2.x.

# 1.1.0

- Async validators now have a **debounce timer** in milliseconds that can be passed as argument to
**FormControl**. This is useful for example to reduce requests to an API. 
- Now you can optionally pass a **FormControl** directly to reactive widgets instead of the 
control's name. You must provide a **formControlName** or a **formControl** but not both at 
the same time.
- Set value an array value to FormArray insert missing items 

# 1.0.10

- Composing validators with **Validators.compose**
- Added optionally type to ReactiveFormArray widget

# 1.0.9  

- Added utilities an extensions to *AbstractControl*
  - AbstractControl.isNull
  - AbstractControl.isNullOrEmpty for controls of type *String*
  
- Minor fixes

# 1.0.8  

### Fixes  

- FormArray and FormGroup now notify value changes when a control without validators changes 
its value.  

# 1.0.7  

- *FormGroup.touch* mask all controls as touched.
- Renamed *FormGroup.formControl* to *FormGroup.control* 
  and *FormArray.formControl* to *FormArray.control* to get *controls* by name.
- *ReactiveValueListenableBuilder.builder* now pass the *control* as parameter instead of the 
  *value* so you can get access to the control within the builder function.
- Added *FormGroup.controls* and *FormArray.controls* to iterate over child controls.  

- **Bonus widgets:**
  - **ReactiveDatePicker**
  - **ReactiveTimePicker**  

# 1.0.6  

- Fixed ReactiveCheckbox and ReactiveCheckboxListTile exception when binding with FormControl with null value.
- Increased code tests coverage to 92% (a lot of tests).
- *FormArray.removeAt* method added to remove a control given the index position.  

# 1.0.5  

- Added ***ReactiveTextField.onSubmitted*** for an example of how to handle moving to
  the next/previous field when using *TextInputAction.next* and *TextInputAction.previous* 
  for *textInputAction*.
- Included property *ReactiveSwitchListTile.inactiveThumbImage*.
- Included properties *autofocus* to *ReactiveCheckbox*, *ReactiveRadio* and *ReactiveSwitch*.
- Included callbacks *ReactiveSlider.onChangeEnd* and *ReactiveSlider.onChangeStart*.  

# 1.0.4  

### Fixes:
- FormArray now correctly notify status depending of children status.  

# 1.0.3  

### New Validators
- **Async Validators** (only FormControl for now...)
- Controls have now three different states: **VALID**, **INVALID**, **PENDING** 
  (this last one was specially included due to async validators, the control is **PENDING** 
  until validator completes)
- Added documentations about *Validator.pattern*
- Added *Async Validator's* example in example application */example/main.dart*.  

### New Models
- **FormArray** (aggregates the values of each child FormControl into an array)  

### New Reactive Widgets:
- ReactiveFormArray
- ReactiveCheckboxListTile
- ReactiveSwitchListTile
- ReactiveRadioListTile
- ReactiveStatusListenableBuilder  

# 1.0.2  

- Added class ValidationMessage for common validation messages key as: *required*, *email*, etc.  
- Added Documentation of ValidationMessage.  
- Minor typo fix in documentation text.  

# 1.0.1  

- Added an example application  

# 1.0.0  

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
