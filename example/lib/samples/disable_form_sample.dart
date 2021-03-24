import 'package:flutter/material.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class DisableFormSample extends StatefulWidget {
  @override
  _DisableFormSampleState createState() => _DisableFormSampleState();
}

class _DisableFormSampleState extends State<DisableFormSample> {
  @override
  Widget build(BuildContext context) {
    return const SampleScreen(
      title: Text('Disable form sample'),
    );
  }
}
