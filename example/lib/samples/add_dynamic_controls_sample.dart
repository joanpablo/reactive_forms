import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class ViewModelProvider extends InheritedWidget {
  final NewContactViewModel viewModel;

  ViewModelProvider({
    required this.viewModel,
    required Widget child,
  }) : super(child: child);

  static NewContactViewModel? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ViewModelProvider>()?.viewModel;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class NewContactViewModel {
  static const String kPhones = 'phones';

  final form = fb.group(<String, Object>{
    kPhones: fb.array<String>(<String>['']),
  });

  NewContactViewModel() {
    phones.valueChanges.listen((value) {
      final emptyPhones = phones.controls.where(Control.isNullOrEmpty);
      if (emptyPhones.isEmpty) {
        phones.add(fb.control(''));
      } else if (emptyPhones.length > 1) {
        phones.remove(emptyPhones.last);
      }
    });
  }

  FormArray<String> get phones => form.control(kPhones) as FormArray<String>;
}

class AddDynamicControlsSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('New contact'),
      body: ViewModelProvider(
        viewModel: NewContactViewModel(),
        child: Builder(
          builder: (context) {
            final viewModel = ViewModelProvider.of(context);
            final form = viewModel?.form;

            if (form == null) {
              return Container();
            }

            return ReactiveForm(
              formGroup: form,
              child: ReactiveFormArray(
                formArray: viewModel?.phones,
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
                                icon: const Icon(
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
