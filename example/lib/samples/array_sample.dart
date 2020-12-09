import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class ArraySample extends StatefulWidget {
  @override
  _ArraySampleState createState() => _ArraySampleState();
}

class _ArraySampleState extends State<ArraySample> {
  final contacts = ['john@email.com', 'susan@email.com', 'caroline@email.com'];
  final form = FormGroup({
    'selectedContacts': FormArray<bool>([], validators: [_emptyAddressee]),
  });

  FormArray<bool> get selectedContacts =>
      form.control('selectedContacts') as FormArray;

  @override
  void initState() {
    selectedContacts.addAll(
      contacts.map((email) => FormControl<bool>(value: true)).toList(),
    );

    super.initState();
  }

  Widget _buildEmailListItem(contact) {
    return ReactiveCheckboxListTile(
      formControlName: this.contacts.indexOf(contact).toString(),
      title: Text(contact),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('Array sample'),
      body: ReactiveForm(
        formGroup: this.form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              ReactiveFormArray<bool>(
                formArrayName: 'selectedContacts',
                builder: (context, formArray, child) => Column(
                    children: this.contacts.map(_buildEmailListItem).toList()),
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return RaisedButton(
                    child: Text('Send Email'),
                    onPressed: form.valid
                        ? () {
                            final selectedEmails = this
                                .contacts
                                .asMap()
                                .keys
                                .where(this.selectedContacts.value.elementAt)
                                .map(this.contacts.elementAt);
                            print('Sent emails to: $selectedEmails');
                          }
                        : null,
                  );
                },
              ),
              RaisedButton(
                child: Text('add'),
                onPressed: () {
                  this
                      .contacts
                      .add('other${this.contacts.length + 1}@email.com');
                  this.selectedContacts.add(FormControl<bool>(value: true));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic> _emptyAddressee(AbstractControl control) {
  final emails = (control as FormArray<bool>).value;
  return emails.any((isSelected) => isSelected)
      ? null
      : {'emptyAddressee': true};
}
