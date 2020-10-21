import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ViewModelProvider extends InheritedWidget {
  final NewContactViewModel viewModel;

  ViewModelProvider({
    @required this.viewModel,
    @required Widget child,
  }) : super(child: child);

  static NewContactViewModel of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ViewModelProvider>()?.viewModel;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class NewContactViewModel {
  static const String PHONES = 'phones';

  final form = fb.group({
    PHONES: fb.array<String>(['']),
  });

  NewContactViewModel() {
    this.phones.valueChanges.listen((value) {
      final emptyPhones = this.phones.controls.where(Control.isNullOrEmpty);
      if (emptyPhones.length == 0) {
        this.phones.add(fb.control(''));
      } else if (emptyPhones.length > 1) {
        this.phones.remove(emptyPhones.last);
      }
    });
  }

  FormArray<String> get phones => this.form.control(PHONES);
}

class AddDynamicControlsSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: NewContactViewModel(),
      child: Builder(
        builder: (context) {
          final viewModel = ViewModelProvider.of(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('New Contact'),
            ),
            body: ReactiveForm(
              formGroup: viewModel.form,
              child: ReactiveFormArray(
                formArray: viewModel.phones,
                builder: (context, array, child) {
                  return ListView(
                    padding: EdgeInsets.all(20.0),
                    children: [
                      for (final control in array.controls)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ReactiveTextField(
                            key: ObjectKey(control),
                            formControl: control,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => array.remove(control),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
