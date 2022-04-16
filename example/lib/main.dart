import 'package:flutter/material.dart';
import 'package:reactive_forms_example/samples/add_dynamic_controls_sample.dart';
import 'package:reactive_forms_example/samples/array_sample.dart';
import 'package:reactive_forms_example/samples/complex_sample.dart';
import 'package:reactive_forms_example/samples/date_picker_sample.dart';
import 'package:reactive_forms_example/samples/disable_form_sample.dart';
import 'package:reactive_forms_example/samples/login_sample.dart';
import 'package:reactive_forms_example/samples/reactive_form_widgets_sample.dart';
import 'package:reactive_forms_example/samples/simple_sample.dart';

void main() {
  runApp(ReactiveFormsApp());
}

class Routes {
  static const complex = '/';

  static const simple = '/simple';

  static const addDynamicControls = '/add-dynamic-controls';

  static const disableFormSample = '/disable-form-sample';

  static const arraySample = '/array-sample';

  static const datePickerSample = '/date-picker-sample';

  static const reactiveFormWidgets = '/reactive-form-widgets';

  static const loginSample = '/login-sample';
}

class ReactiveFormsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
      routes: <String, WidgetBuilder>{
        Routes.complex: (_) => ComplexSample(),
        Routes.simple: (_) => SimpleSample(),
        Routes.addDynamicControls: (_) => AddDynamicControlsSample(),
        Routes.disableFormSample: (_) => DisableFormSample(),
        Routes.arraySample: (_) => ArraySample(),
        Routes.loginSample: (_) => LoginSample(),
        Routes.datePickerSample: (_) => DatePickerSample(),
        Routes.reactiveFormWidgets: (_) => ReactiveFormWidgetsSample(),
      },
    );
  }
}

final customTheme = ThemeData.light().copyWith(
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    alignLabelWithHint: true,
  ),
);
