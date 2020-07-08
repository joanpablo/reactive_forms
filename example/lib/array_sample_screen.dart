import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_array.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ArraySampleScreen extends StatefulWidget {
  @override
  _ArraySampleScreenState createState() => _ArraySampleScreenState();
}

class _ArraySampleScreenState extends State<ArraySampleScreen> {
  final contacts = ['john@email.com', 'susan@email.com', 'mary@email.com'];
  final form = FormGroup({
    'selectedContacts': FormArray<bool>([]),
  });

  FormArray get selectedContacts =>
      form.formControl('selectedContacts') as FormArray;

  @override
  void initState() {
    selectedContacts.addAll(
      contacts.map((email) => FormControl<bool>(defaultValue: true)),
    );

    super.initState();
  }

  Widget _buildEmailListItem(contact) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(contact)),
        ReactiveCheckbox(
          formControlName: this.contacts.indexOf(contact).toString(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormArray Example'),
      ),
      body: ReactiveForm(
        formGroup: this.form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ReactiveFormArray(
                formArrayName: 'selectedContacts',
                child: Column(
                  children: this.contacts.map(_buildEmailListItem).toList(),
                ),
              ),
              RaisedButton(
                child: Text('Send Email'),
                onPressed: () {
                  print(this.form.value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
