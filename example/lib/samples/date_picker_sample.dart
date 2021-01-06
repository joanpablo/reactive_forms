import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class DatePickerSample extends StatefulWidget {
  @override
  _DatePickerSampleState createState() => _DatePickerSampleState();
}

class _DatePickerSampleState extends State<DatePickerSample> {
  FormGroup buildForm() => fb.group({
        'date': FormControl<DateTime>(value: null),
      });

  FocusNode _focusNode;

  @override
  initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('Datepicker sample'),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveDatePicker(
                formControlName: 'date',
                firstDate: DateTime(1985),
                lastDate: DateTime(2030),
                builder: (context, picker, child) {
                  Widget suffix = InkWell(
                    child: Icon(Icons.clear),
                    onTap: () {
                      // workaround until https://github.com/flutter/flutter/issues/39376
                      // will be fixed

                      // Unfocus all focus nodes
                      _focusNode.unfocus();

                      // Disable text field's focus node request
                      _focusNode.canRequestFocus = false;

                      // clear field value
                      picker.control.value = null;

                      //Enable the text field's focus node request after some delay
                      Future.delayed(Duration(milliseconds: 100), () {
                        _focusNode.canRequestFocus = true;
                      });
                    },
                  );

                  if (picker.value == null) {
                    suffix = Icon(Icons.calendar_today);
                  }

                  return ReactiveTextField(
                    onTap: () {
                      if (_focusNode.canRequestFocus) {
                        _focusNode.unfocus();
                        picker.showPicker();
                      }
                    },
                    valueAccessor: DateTimeValueAccessor(
                      dateTimeFormat: DateFormat('dd MMM yyyy'),
                    ),
                    focusNode: _focusNode,
                    formControlName: 'date',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Birthday focus',
                      suffixIcon: suffix,
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
