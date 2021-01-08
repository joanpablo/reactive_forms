import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';
import 'package:reactive_forms_widgets/reactive_forms_widgets.dart';

class ReactiveFormWidgetsSample extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'menu': FormControl<String>(value: 'Tunisia'),
        'bottomSheet': FormControl<String>(value: 'Brazil'),
        'touchSpin': FormControl<double>(value: 10),
        'rate': FormControl<String>(value: 'a'),
        'date': FormControl<DateTime>(value: DateTime.now()),
        'time': FormControl<DateTime>(value: DateTime.now()),
        'dateTime': FormControl<DateTime>(value: DateTime.now()),
      });

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('Reactive form widgets sample'),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveDropdownSearch(
                formControlName: 'menu',
                decoration: InputDecoration(
                  helperText: '',
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                mode: ReactiveDropdownSearchMode.MENU,
                hint: "Select a country",
                showSelectedItem: true,
                items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                label: "Menu mode *",
                showClearButton: true,
                popupItemDisabled: (String s) => s.startsWith('I'),
              ),
              SizedBox(height: 8),
              ReactiveDropdownSearch<String>(
                formControlName: 'bottomSheet',
                mode: ReactiveDropdownSearchMode.BOTTOM_SHEET,
                decoration: InputDecoration(
                  helperText: '',
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                maxHeight: 300,
                items: ["Brazil", "Italia", "Tunisia", 'Canada'],
                label: "Custom BottomSheet mode",
                showSearchBox: true,
                popupTitle: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ReactiveTouchSpin(
                formControlName: 'touchSpin',
                min: 5,
                max: 100,
                step: 5,
                textStyle: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  labelText: "Search amount",
                  helperText: '',
                ),
              ),
              SizedBox(height: 8),
              ReactiveTouchSpin(
                formControlName: 'touchSpin',
                min: 5,
                max: 100,
                step: 5,
                textStyle: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: BoxDecorationBorder(
                      decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0, 2),
                        blurRadius: 7,
                        spreadRadius: 0,
                      ),
                    ],
                  )),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  labelText: "BoxDecoration border",
                  helperText: '',
                ),
              ),
              SizedBox(height: 8),
              ReactiveSegmentedControl(
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                  helperText: '',
                ),
                padding: EdgeInsets.all(0),
                formControlName: 'rate',
                children: {
                  'a': Text('A'),
                  'b': Text('B'),
                  'c': Text('C'),
                },
              ),
              SizedBox(height: 8),
              ReactiveDateTimePicker(
                formControlName: 'date',
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 8),
              ReactiveDateTimePicker(
                formControlName: 'time',
                type: ReactiveDatePickerFieldType.time,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.watch_later_outlined),
                ),
              ),
              SizedBox(height: 8),
              ReactiveDateTimePicker(
                formControlName: 'dateTime',
                type: ReactiveDatePickerFieldType.dateTime,
                decoration: const InputDecoration(
                  labelText: 'Date & Time',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16),
              // RaisedButton(
              //   child: Text('Sign Up'),
              //   onPressed: () {
              //     if (form.valid) {
              //       print(form.value);
              //     } else {
              //       form.markAllAsTouched();
              //     }
              //   },
              // ),
            ],
          );
        },
      ),
    );
  }
}
