# 1.2.0  

- Removed restriction of empty item's array in ReactiveDropdown.
- Added onWillPop to ReactiveForm widget.

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
