import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_array.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ArraySampleScreen extends StatefulWidget {
  @override
  _ArraySampleScreenState createState() => _ArraySampleScreenState();
}

class _ArraySampleScreenState extends State<ArraySampleScreen> {
  final contacts = ['john@email.com', 'susan@email.com', 'caroline@email.com'];
  final form = FormGroup({
    'selectedContacts': FormArray<bool>([], validators: [_emptyAddressee]),
  });

  FormArray<bool> get selectedContacts =>
      form.formControl('selectedContacts') as FormArray;

  @override
  void initState() {
    selectedContacts.addAll(
      contacts.map((email) => FormControl<bool>(defaultValue: true)).toList(),
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
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: this.form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ReactiveFormArray(
                  formArrayName: 'selectedContacts',
                  builder: (context, formArray, child) => Column(
                    children: this.contacts.map(_buildEmailListItem).toList(),
                  ),
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
                    this
                        .selectedContacts
                        .add(FormControl<bool>(defaultValue: true));
                  },
                ),
              ],
            ),
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
