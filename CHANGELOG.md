# 16.0.2

## Fixes

- Fix an issue with `FormBuilder` when trying to build a control with a nullable '?' data type.
- Fix an issue with `FormGroup` that was not triggering the event `collectionChanges` when a control
is removed.
- Fix an issue with `FormGroup` and `FormArray` when trying to find a control with a nullable '?'
data type.

# 16.0.1

## Fixes

- Update the intl dependency version, because in flutter 3.10, 
`flutter_localizations` depends on intl 0.18.0.

# 16.0.0

## Breaking Changes

- Flutter >= 3.10 required for this version.

## Fixes

- Updated some documentation.
- Expose validator classes to allow direct instantiation. 

# 15.0.0

## Breaking Changes

- All validators have been changed to classes with `const` constructors.
- The Asynchronous Validator is now a class from where any custom async validator can inherit.

## Features

- A new validator `Validators.delegate(...)` has been introduced to be used with a custom
  validation function.
- A new validator `Validators.delegateAsync(...)` has been introduced to be used with a custom
  async validation functions.

# 14.3.0

- Fix the inkwell ripple effect in the **ReactiveDropdownField**.
- Add some other minor fixes.

# 14.2.0

- Update intl to latest version 0.18.0.

# 14.1.0

## Enhances

- Create new widget **ReactiveFocusableFormField** as a parent widget for all other widgets that requires to do focus management.

# 14.0.0

## Breaking Changes

- The definition of validation messages is now more consistent.
- Methods like `onTab` in `ReactiveTextField` and `onChanged` in
  `ReactiveDropdownField` now provides the control as argument of
  the callback.

## Enhances

- Add events like `onChanged`, `onEditingComplete` to reactive widgets.

## Features

- Add widget **ReactiveFormConfig** to globally define validation messages
  at Flutter application level. This reliefs the need to define validation
  messages in each reactive widget.

# 13.0.1

## Enhances

- Upgrade example folder project to Flutter 3.0.0.
- Increase code coverage in FormArray.

# 13.0.0

## Breaking Changes

- Reactive Forms is now migrated to Flutter 3.0.0.

# 12.0.0

## Fix

- Update project to new Android wrappers in order to be able to run the example
  using latest Android SDK changes.

# 11.1.0

## Enhances

- Add Focus handling for several reactive widgets:
  - ReactiveSlider
  - ReactiveSwitch
  - ReactiveRadio
  - ReactiveRadioListTile
  - ReactiveCheckbox
  - ReactiveCheckboxListTile

# 11.0.2

## Fix

- Small fix in the _array_sample_ example application.

# 11.0.1

## Fix

- Fix issues in **ReactiveDatePicker** when control value was before or after the range of **firstDate** and **lastDate**

## Enhances

- Add optional argument **initialDate** to the **ReactiveDatePicker**.

# 11.0.0

## Breaking Changes

- Reactive Forms is now migrated to Flutter 2.8.0.

## Enhances

- Update reactive widgets with extra properties presents in Flutter 2.8.0.

# 10.7.0

## Features

- Expose **TextEditingController** as a property of the **ReactiveTextField** for text selection
  purposes only.

# 10.6.8

## Fix

- Fix Async Validators that overrides validations errors from Sync Validators

# 10.6.7

## Enhances

- Improve Complex example in the demo application

# 10.6.6

## Enhances

- Improve the Array example in the demo application
- Better exception handler when creating FormGroups with controls that contains character '.' in the name of the control.

# 10.6.5

## Enhances

- Add an example of deleting item from a **FormArray** in the example folder project.
- Make public the previously private class **InheritedStreamer**

# 10.6.4

## Fix

- Minor documentation fix.

# 10.6.3

## Enhances

- Add documentation of new advanced reactive widgets.

## Fix

- Minor documentation fix.

# 10.6.2

## Enhances

- Converted **ReactiveForm** widget from Stateful to Stateless widget.

# 10.6.1

## Enhances

- Update the lint code analysis to use the las package **lints**.
- Minor internal code checks and improvements.

# 10.6.0

## Enhances

- Added optional argument to **Validators.mustMatch** that allows to define if we want to mark
  the _matchingControlName_ control as **DIRTY** when the control is invalid.
  See related [issue](https://github.com/joanpablo/reactive_forms/issues/199).
- Minor changes in model classes that allows to create custom AbstractControl implementations

# 10.5.0

## Enhances

- Added missing props pass through for widgets.

# 10.4.1

## Enhances

- Add minor internal changes for handling focus node in reactive text fields.

# 10.4.0

## Fix

- Add Flutter sdk version restriction in pubspec.yaml file.
- Fix **Validators.compare** in release mode that has different behavior from debug mode.

# 10.3.0

## Features

- Add method in FormGroup that allows to remove a control by its name.

## Enhances

- Add missing extra properties to ReactiveRadioListTile and ReactiveRadio widgets.
- Add a SliderIntValueAccessor that allows ReactiveSlider to bind to controls of type _int_.

# 10.2.0

## Fix

- Fix error when defining a ReactiveTextField with dynamic type and bound the widget with controls
  other than String.

## Enhances

- Add the optionally extra argument _autoValidate_ to the method **AbstractControl.setValidators** to recalculate the validaity of the control after set the new validators without explicitly call _updateValueAndValidity_ on that control.

# 10.1.0

## Features

- Add/Clear validators dynamically

## Fix

- Fix error when defining a ReactiveTextField without specifying a model data type

## Enhances

- Change the data type of ValidatorFunction to returns _Map<String, dynamic>_ instead of _Map<String, Object>_

# 10.0.4

## Fix

- Fix exception when focus a control that does not exist in a group

## Enhances

- Better type definition in a control value accessor within a ReactiveFormField

# 10.0.3

## Fix

- Set **ReactiveTextField** maxLines as optional nullable argument.

# 10.0.2

## Enhances

- Add minor changes in Validators.min and Validators.max for handlig type checks
- Add minor changes in ReactiveValueListenableBuilder for handlig type checks

# 10.0.1

## Fix

- Fix the error when defining a ReactiveFormField<dynamic> (related to control value accessor)

# 10.0.0

## Breaking changes

- Reactive Forms is now migrated to Flutter 2.x.
- Reactive Forms is now Null-safety.
- New Definitions in Custom Reactive Widgets. **ReactiveFormField** now defines the data type of the model (control) and the data type of the view (widget).
- **Validators.requiredTrue** now has the 'requiredTrue' validation message and not 'requiredEquals' as in previous versions.

## Features

- Now you can specify a different _validation message_ to the **Validators.pattern** validator.

# 9.1.0

## Enhances

- Add latest version of intl package

# 9.0.2

## Fix

- Remove Validators String type to fix casts errors when calling _form.control('').validators_
  in a control with a non dynamic type validator.

# 9.0.1

## Fix

- Add minor changes to successfully pass pub dev static analysis.
- Add Library documentation.

# 9.0.0

## Breaking changes

- An enhanced strongly typed system to improve casting at compilation time and improve casting
  exception handler in runtime. This version was created to be compatible with analysis options
  in "implicit-casts: false" and "implicit-dynamic: false".

# 8.0.3

## Fix

- Code formatting issues

# 8.0.2

## Fix

- **Validators.pattern** now validates against a **RegExp** instance.

# 8.0.1

## Fix

- If a control is disabled, then it doesn't fire state change again when
  call **markAsDisabled**.

# 8.0.0

## Breaking changes

- Upgrade **Reactive Forms** to Flutter 1.20

## Features

- Add **intl** package and and optional argument to DateTimeValueAccessor to specify
  the format of the date.
- Add some extra properties to reactive forms widgets.

# 7.6.3

## Fix

- Set cursor at the end of the text when set value to reactive text field from the FormControl.

# 7.6.2

## Fix

- Exposes **ReactiveSwitchListTile**.

# 7.6.1

## Fix

- Fix code formatting to pass pub static analysis.

# 7.6.0

## Features

- Expose focus controller of the **FormControl**. Now is possible to access UI **FocusNode** with
  in a control through **control.focusController.focusNode**.

# 7.5.0

## Features

- Add argument **focusNode** to **ReactiveTextField** to provide a custom **FocusNode**.

## Enhances

- Add some improvement to _TimeOfDayValueAccessor_.
- Add some improvement to example application.

# 7.4.0

## Enhances

- A disabled **ReactiveDropdownField** now tale into account the _selectedItemBuilder_ method to
  show the _disabledHint_.
- More complete **example** app project inside **Reactive Forms**.

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

- Update value accessors in reactive widgets when widget _didUpdateWidget_.

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

- Initialize a **FormGroup** as _disabled_ is now possible with optional constructor argument.

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
  _true_.

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
  - FormControl of type _Iterable_
  - FormControl of type _String_
  - FormGroup
- Add better data types definition in **FormBuilder.array** declaration.

# 6.0.4

## Features

- Add arguments **emitEvent** and **updateParent** to **FormArray.clear()** method.

# 6.0.3

## Enhanced

- Changes all arguments of data type **Iterable** with **List** data type to force compiler errors
  when not correctly cast _MappedListIterable_ with _List_.

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
  **FormControl.focusChanges** event, from **FocusEvent** to _bool_.

## Fixes

- Fix infinity loop that freeze apps when two or more **ReactiveTextField** were binded to the same
  **FormControl** and changing focus between them.
- Fix **FormGroup.addAll** now updates group _pristine_/_dirty_ state of the group and trigger
  **FormControlCollection.collectionChanges** event.

## Features

- Add **FormArray.clear()** that remove all children controls of the array.

# 5.0.4

## Features

- Add optionally argument _showErrors_ to **ReactiveTextField** and **ReactiveDropdownField**
  to customize when to show up validations messages. Validation messages by default change to visible
  when control is _invalid_ and _touched_. With _showErrors_ function this default behavior can be
  customized.

# 5.0.3

## Breaking changes

- Rename **FormControl.focused** by **FormControl.hasFocus**.
- Change **ReactiveFormBuilder.builder(context)** by **ReactiveFormBuilder.builder()**.
- Change argument in FormControl.focusChanges event from _bool_ to **FocusEvent**.

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

- Rename _touch()_ and _untouch()_ by _markAsTouched()_ and _markAsUntouched()_
- Rename _enable()_ and _disable()_ by _markAsEnabled()_ and _markAsDisabled()_
- Add **AbstractControl.markAllAsTouched** to mark all controls of a
  **FromGroup** or a **FormArray** as touched. **AbstractControl.markAsTouched** doesn't marks
  children as touched anymore.
- **Validators.compose** now act as and **AND** and returns a _ValidatorFunction_ instead of a List of
  _ValidatorFunction_
- _InputParsers_ have been replaced by **ControlValueAccessor**.

## Features

- Add new control status **pristine** and **dirty**.
- **FormGroup.control(String name)** and **FormArray.control(String name)** now let specify the
  _name_ argument as a dot-delimited string that represents the path to the nested control as
  _nested1.nested2.nested.3.etc_.
- Add **FormBuilder.array()** and **FormBuilder.control()** for creating _arrays_ and _controls_.
- **ReactiveValueListenableBuilder** brings now the possibility to provide directly the _control_
  instead of just the _control name_.
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

- Add **FormBuilder.state** to create a _ControlState_.

# 4.0.1

- Fix async update in InheritedStreamer widget that raised exception when declare
  a form group in a stateless widget.

# 4.0.0

## Features

- **FormControl.reset()** can now set the disabled status of the control as an optional argument.
- Implements **FormGroup.resetState()** and **FormArray.resetState()** to reset children controls
  with initial value and disabled status.

## Breaking Changes

- **FormControl** constructor receives _value_ instead of _defaultValue_. To reset a control
  to a initial value you must call **FormControl.reset()** and supply initial value.

# 3.0.1

- Fix Luhn algorithm in credit card validator.

# 3.0.0

- Fixes:

  - **FormGroup.reset()** marks control as untouched and hide UI validation errors.
  - **FormGroup.reset()** sets empty string to input text fields if control value is _null_.

- Features:
  - _InputParser_ added to **ReactiveTextField**. Now you can declare a FormControl with **int**
    or **double** data type and bind it to an input text field.

# 2.0.8

- Fixed card number length in _Validators.creditCard_

# 2.0.7

- Minor changes and code documentation.
- **New Validator**
  - \*Validators.**creditCard\*** that validates a credit card number using the [Luhn algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm).

# 2.0.6

- Optimized FormGroup and FormArray value gets.
- **FormBuilder** docs added to README.md

# 2.0.5

- fixed ReactiveDropdownField.onChanged not triggered when control value didn't changes

# 2.0.4

- Minor fixes in _ReactiveDropdownField_.

# 2.0.3

- Minor fixes.

# 2.0.2

- Added basic implementation of **FormBuilder** to build _FormGroup_ easily.
- Added _onChanged_ callback to _ReactiveDropdownField_.

# 2.0.1

- Now ReactiveDropdownField not set value of control to null when no matching item founded.

# 2.0.0

- Added onWillPop to ReactiveForm widget.
- Enable/disable controls, groups and arrays.
- Now you can access the parent group or array with the property _FormControl.parent_.

## Fixes

- Removed restriction of empty item's array in ReactiveDropdown.
- Assert error in ReactiveDropdown when _control_ value not match any item values.
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

- Added utilities an extensions to _AbstractControl_
  - AbstractControl.isNull
  - AbstractControl.isNullOrEmpty for controls of type _String_
- Minor fixes

# 1.0.8

### Fixes

- FormArray and FormGroup now notify value changes when a control without validators changes
  its value.

# 1.0.7

- _FormGroup.touch_ mask all controls as touched.
- Renamed _FormGroup.formControl_ to _FormGroup.control_
  and _FormArray.formControl_ to _FormArray.control_ to get _controls_ by name.
- _ReactiveValueListenableBuilder.builder_ now pass the _control_ as parameter instead of the
  _value_ so you can get access to the control within the builder function.
- Added _FormGroup.controls_ and _FormArray.controls_ to iterate over child controls.

- **Bonus widgets:**
  - **ReactiveDatePicker**
  - **ReactiveTimePicker**

# 1.0.6

- Fixed ReactiveCheckbox and ReactiveCheckboxListTile exception when binding with FormControl with null value.
- Increased code tests coverage to 92% (a lot of tests).
- _FormArray.removeAt_ method added to remove a control given the index position.

# 1.0.5

- Added **_ReactiveTextField.onSubmitted_** for an example of how to handle moving to
  the next/previous field when using _TextInputAction.next_ and _TextInputAction.previous_
  for _textInputAction_.
- Included property _ReactiveSwitchListTile.inactiveThumbImage_.
- Included properties _autofocus_ to _ReactiveCheckbox_, _ReactiveRadio_ and _ReactiveSwitch_.
- Included callbacks _ReactiveSlider.onChangeEnd_ and _ReactiveSlider.onChangeStart_.

# 1.0.4

### Fixes:

- FormArray now correctly notify status depending of children status.

# 1.0.3

### New Validators

- **Async Validators** (only FormControl for now...)
- Controls have now three different states: **VALID**, **INVALID**, **PENDING**
  (this last one was specially included due to async validators, the control is **PENDING**
  until validator completes)
- Added documentations about _Validator.pattern_
- Added _Async Validator's_ example in example application _/example/main.dart_.

### New Models

- **FormArray** (aggregates the values of each child FormControl into an array)

### New Reactive Widgets:

- ReactiveFormArray
- ReactiveCheckboxListTile
- ReactiveSwitchListTile
- ReactiveRadioListTile
- ReactiveStatusListenableBuilder

# 1.0.2

- Added class ValidationMessage for common validation messages key as: _required_, _email_, etc.
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
