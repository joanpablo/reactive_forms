import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

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

  final form = fb.group(<String, dynamic>{
    PHONES: fb.array<String>(<String>['']),
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

  FormArray<String> get phones => this.form.control(PHONES) as FormArray<String>;
}

class AddDynamicControlsSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('New contact'),
      body: ViewModelProvider(
        viewModel: NewContactViewModel(),
        child: Builder(
          builder: (context) {
            final viewModel = ViewModelProvider.of(context);

            return ReactiveForm(
              formGroup: viewModel.form,
              child: ReactiveFormArray(
                formArray: viewModel.phones,
                builder: (context, array, child) {
                  return Column(
                    children: [
                      for (final control in array.controls)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ReactiveTextField<String>(
                            key: ObjectKey(control),
                            formControl: control as FormControl<String>,
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
            );
          },
        ),
      ),
    );
  }
}
