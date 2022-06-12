import 'package:flutter/material.dart';
import 'package:reactive_forms_example/sample_screen.dart';

class DisableFormSample extends StatefulWidget {
  @override
  State<DisableFormSample> createState() => _DisableFormSampleState();
}

class _DisableFormSampleState extends State<DisableFormSample> {
  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: const Text('Disable form sample'),
      body: Container(),
    );
  }
}
