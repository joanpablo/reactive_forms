# 7.4.0

## Enhances
- A disabled **ReactiveDropdownField** now tale into account the *selectedItemBuilder* method to 
show the *disabledHint*.

# 7.3.0

## Features
- Add **FormGroup.rawValue** and **FormArray.rawValue** to get the value of groups and array 
including any disabled controls.

# 7.2.1

## Fixes
- Fix exception when call **FormGroup.addAll** in a sub-group with parent.

# 7.2.0

## Features
- Add method **patchValue** to FormControl, FormGroup and FormArray to update partially the control 
value.

# 7.1.0

## Features
- Add **Validators.any** that requires any element of the control's iterable value satisfies a test
function.

## Fix
- Update value accessors in reactive widgets when widget *didUpdateWidget*.

# 7.0.12

## Enhances
- Add **readOnly** argument as not nullable in **ReactiveDropdownField**.

# 7.0.11

## Enhances
- Add **readOnly** argument in **ReactiveDropdownField** constructor to enable/disable widget.

## Documentation
- Add documentation about customizing when to show errors in reactive widgets. 

# 7.0.10

## Fixes
- Dispose **FocusNode** after **FocusNodeController** is disposed.

# 7.0.9

## Documentation
- Improves code documentation for control, group and array constructors.

# 7.0.8

## Features
- Add **async validators** to **FormGroup** and **FormArray**.
- Add disabled optional argument to **FormArrayConstructor**.

# 7.0.7

## Fixes
- Fix now **AbstractControl.removeError** doesn't marks the control as dirty by default.

# 7.0.6

## Fixes
- Fix **Validators.compare** in DateTime controls type.

# 7.0.5

## Features
- Initialize a **FormGroup** as *disabled* is now possible with optional constructor argument.

# 7.0.4

## Fixes
- Fix **Validators.maxLength** and **Validators.minLength** when control value is null.

# 7.0.3

## Features
- Add new control value accessor **Iso8601DateTimeValueAccessor** that brings the possibility to
bind a **ReactiveDateTimePicker** widget to a control of type String. 

# 7.0.2

## Fixes
- Fix when the execution of asynchronous validators completes the control is not marked as dirty. 

# 7.0.1

## Features
- Add new AbstractControl validator **Validators.contains**.

## Fixes
- Fix **Validators.minLength** and **Validators.maxLength** with FormControls of type dynamic
when a value is a String. 

# 7.0.0

## Breaking changes
- Change **ReactiveFormField.validationMessages** from a **Map** to a **Function** that receives
the instance of the control and returns the Map with the customized validation messages. This 
upgrade now brings the possibility to dynamically change the validation messages based on the 
current error data.
- Change **Validators.email** response error Map. Now returns the current control value instead of 
*true*.

## Features
- Add **AbstractControl.hasError(...)** for asking if a control has an error based on error code and 
children path.  
- Add **AbstractControl.getError(...)** to get error data based on error code and children path.

# 6.0.5

## Fix
- Fix error when trying to get a deep control within an array of groups. 
- Fix minor issues
- Fix some typos.
- Fix **ReactiveDatePicker** error when **lastDate** is previous to **DateTime.now()** and control 
value is **null**.

## Enhanced
- **FormArray.removeAt** now returns the removed control.
- Improve code documentation.
- Add more tests.
- Add more strict data types in arguments.
- Add extra arguments to **AbstractControl.setErrors** and **AbstractControl.removeError** to marks
the control as **dirty** or **pristine**.
- Refactor **Validators.minLength** and **Validators.maxLength** to be use with:
  - FormArray
  - FormControl of type *Iterable*
  - FormControl of type *String*
  - FormGroup
- Add better data types definition in **FormBuilder.array** declaration.

# 6.0.4

## Features
- Add arguments **emitEvent** and **updateParent** to **FormArray.clear()** method.

# 6.0.3

## Enhanced
- Changes all arguments of data type **Iterable** with **List** data type to force compiler errors
when not correctly cast *MappedListIterable* with *List*.

# 6.0.2

## Fixes
- Fix control value accessor that doesn't update the control when LengthLimitingTextInputFormatter
reached the max length.

# 6.0.1

## Fixes
- Fix error when dispose a FocusController already registered in a control.

# 6.0.0

## Breaking changes
- Add big refactor in focus handlers of a **FormControl**. Change argument data type in 
**FormControl.focusChanges** event, from **FocusEvent** to *bool*.

## Fixes
- Fix infinity loop that freeze apps when two or more **ReactiveTextField** were binded to the same 
**FormControl** and changing focus between them.
- Fix **FormGroup.addAll** now updates group *pristine*/*dirty* state of the group and trigger 
**FormControlCollection.collectionChanges** event.

## Features
- Add **FormArray.clear()** that remove all children controls of the array.

# 5.0.4

## Features
- Add optionally argument *showErrors* to **ReactiveTextField** and **ReactiveDropdownField** 
to customize when to show up validations messages. Validation messages by default change to visible 
when control is *invalid* and *touched*. With *showErrors* function this default behavior can be 
customized.

# 5.0.3

## Breaking changes
- Rename **FormControl.focused** by **FormControl.hasFocus**.
- Change **ReactiveFormBuilder.builder(context)** by **ReactiveFormBuilder.builder()**.
- Change argument in FormControl.focusChanges event from *bool* to **FocusEvent**.

## Features
- Add **FormGroup.unfocus()** and **FormArray.unfocus()** to remove focus of children controls.
- Add **FormArray.focus(String name)** to set focus on a control.
- Add optional argument to **AbstractControl.unfocus(bool touched)** to mark controls as untouched 
when remove focus.
- Add optional argument to **AbstractControl.reset(bool removeFocus)** to remove focus on control
when reset the control/form/array.

## Fixes
- Fix **ReactiveFormBuilder** initializations in debug mode.

# 5.0.2

- Fix add custom valueAccessor to text field.

# 5.0.1

- Fix **Validators.min** and **Validators.max** with non comparable controls.

# 5.0.0

## Breaking changes
- Rename *touch()* and *untouch()* by *markAsTouched()* and *markAsUntouched()*
- Rename *enable()* and *disable()* by *markAsEnabled()* and *markAsDisabled()*
- Add **AbstractControl.markAllAsTouched** to mark all controls of a 
**FromGroup** or a **FormArray** as touched. **AbstractControl.markAsTouched** doesn't marks 
children as touched anymore.
- **Validators.compose** now act as and **AND** and returns a *ValidatorFunction* instead of a List of
*ValidatorFunction*
- *InputParsers* have been replaced by **ControlValueAccessor**.

 
## Features
- Add new control status **pristine** and **dirty**.
- **FormGroup.control(String name)** and **FormArray.control(String name)** now let specify the 
*name* argument as a dot-delimited string that represents the path to the nested control as 
*nested1.nested2.nested.3.etc*.
- Add **FormBuilder.array()** and **FormBuilder.control()** for creating *arrays* and *controls*.
- **ReactiveValueListenableBuilder** brings now the possibility to provide directly the *control* 
instead of just the *control name*.
- Add **Validators.composeOR** to combines multiples validators in one and evaluates as an **OR**, 
if at least one validator evaluates to VALID then the control is valid.
- Add **ControlValueAccessor** to convert value data types from UI to model and vice versa. 
- Add **FormGroup.focus(String name)** to set focus to a child control.

## Widgets

- Add **ReactiveFormBuilder** useful for defining a **FormGroup** and a **ReactiveForm** at the same
time in a stateless widget. 

## Validators
- Add validators:
    - **Validators.requiredTrue**
    - **Validators.equals**
    - **Validators.min**
    - **Validators.max**
    - **Validators.composeOR**
    - **Validators.compare**

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
