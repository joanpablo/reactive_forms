import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveTwoFieldTestingWidget extends StatefulWidget {
  final FormGroup form;
  final Map<String, String> bindings;

  const ReactiveTwoFieldTestingWidget({
    Key? key,
    required this.form,
    this.bindings = const {
      'field1': 'name1',
      'field2': 'name2',
    },
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ReactiveTwoFieldTestingWidgetState();
  }
}

class ReactiveTwoFieldTestingWidgetState extends State<ReactiveTwoFieldTestingWidget> {
  bool showField1 = true;

  void switchField() {
    setState(() => showField1 = !showField1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: widget.form,
          child: Column(
            children: <Widget>[
              if (showField1)
                ReactiveTextField<String>(
                  formControlName: widget.bindings['field1'],
                )
              else
                ReactiveTextField<String>(
                  formControlName: widget.bindings['field2'],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
