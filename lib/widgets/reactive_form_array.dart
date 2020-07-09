import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_array.dart';
import 'package:reactive_forms/models/form_control_collection.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/widgets/form_control_inherited_notifier.dart';

typedef ReactiveFormArrayBuilder = Widget Function(
    BuildContext context, FormArray formArray, Widget child);

class ReactiveFormArray extends StatefulWidget {
  final String formArrayName;
  final Widget child;
  final ReactiveFormArrayBuilder builder;

  const ReactiveFormArray({
    Key key,
    @required this.formArrayName,
    @required this.builder,
    this.child,
  })  : assert(formArrayName != null),
        assert(builder != null),
        super(key: key);

  @override
  _ReactiveFormArrayState createState() => _ReactiveFormArrayState();
}

class _ReactiveFormArrayState extends State<ReactiveFormArray> {
  FormArray _formArray;

  @override
  void initState() {
    final form =
        ReactiveForm.of(context, listen: false) as FormControlCollection;
    _formArray = form.formControl(widget.formArrayName) as FormArray;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormControlInheritedNotifier(
      control: _formArray,
      notifierDelegate: () => _formArray.onCollectionChanged,
      child: Builder(builder: (context) {
        return widget.builder(context, ReactiveForm.of(context), widget.child);
      }),
    );
  }
}
