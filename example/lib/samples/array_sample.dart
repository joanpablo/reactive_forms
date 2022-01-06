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
      form.control<FormArray<bool>>('selectedContacts');

  FormControl<bool> selectedContactsItem(int i) =>
      form.control<FormControl<bool>>('selectedContacts.$i');

  @override
  void initState() {
    selectedContacts.addAll(
      contacts.map((email) => FormControl<bool>(value: true)).toList(),
    );

    super.initState();
  }

  Widget _buildEmailListItem(String contact) {
    return Row(
      children: [
        Expanded(
          child: ReactiveCheckboxListTile(
            formControlName: contacts.indexOf(contact).toString(),
            title: Text(contact),
          ),
        ),
        IconButton(
            onPressed: () {
              final index = contacts.indexOf(contact);
              contacts.removeAt(index);
              selectedContacts.removeAt(index);
            },
            icon: const Icon(Icons.delete)),
      ],
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
                    onPressed: form.valid
                        ? () {
                            final selectedEmails = contacts
                                .asMap()
                                .keys
                                .where((e) =>
                                    selectedContacts.value?.elementAt(e) ??
                                    false)
                                .map(contacts.elementAt);
                            print('Sent emails to: $selectedEmails');
                          }
                        : null,
                    child: const Text('Send Email'),
                  );
                },
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: () => selectedContacts.reset(),
                    child: const Text('reset'),
                  );
                },
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: () => selectedContacts.updateValue(
                        selectedContacts.value
                            ?.map((e) => !(e ?? false))
                            .toList()),
                    child: const Text('toggle all'),
                  );
                },
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: () => selectedContactsItem(0)
                        .updateValue(!(selectedContactsItem(0).value ?? false)),
                    child: const Text('toggle first item'),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  contacts.add('other${contacts.length + 1}@email.com');
                  selectedContacts.add(FormControl<bool>(value: true));
                },
                child: const Text('add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, Object>? _emptyAddressee(AbstractControl<dynamic> control) {
  final emails = (control as FormArray<bool>).value;
  return emails?.any((isSelected) => isSelected ?? false) == true
      ? null
      : <String, Object>{'emptyAddressee': true};
}
