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
      form.control('selectedContacts') as FormArray<bool>;

  @override
  void initState() {
    selectedContacts.addAll(
      contacts.map((email) => FormControl<bool>(value: true)).toList(),
    );

    super.initState();
  }

  Widget _buildEmailListItem(String contact) {
    return ReactiveCheckboxListTile(
      formControlName: contacts.indexOf(contact).toString(),
      title: Text(contact),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('Array sample'),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              ReactiveFormArray<bool>(
                formArrayName: 'selectedContacts',
                builder: (context, formArray, child) => Column(
                    children: contacts.map(_buildEmailListItem).toList()),
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    child: const Text('Send Email'),
                    onPressed: form.valid
                        ? () {
                            final selectedEmails = contacts
                                .asMap()
                                .keys
                                .where(selectedContacts.value.elementAt)
                                .map(contacts.elementAt);
                            print('Sent emails to: $selectedEmails');
                          }
                        : null,
                  );
                },
              ),
              ElevatedButton(
                child: const Text('add'),
                onPressed: () {
                  contacts.add('other${contacts.length + 1}@email.com');
                  selectedContacts.add(FormControl<bool>(value: true));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, Object> _emptyAddressee(AbstractControl<dynamic> control) {
  final emails = (control as FormArray<bool>).value;
  return emails.any((isSelected) => isSelected)
      ? null
      : <String, dynamic>{'emptyAddressee': true};
}
