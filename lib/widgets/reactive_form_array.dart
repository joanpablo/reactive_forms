import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_array.dart';
import 'package:reactive_forms/models/form_control_collection.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/widgets/form_group_inherited_notifier.dart';

class ReactiveFormArray extends StatefulWidget {
  final String formArrayName;
  final Widget child;

  const ReactiveFormArray({
    Key key,
    @required this.formArrayName,
    @required this.child,
  })  : assert(formArrayName != null),
        assert(child != null),
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
    return FormGroupInheritedNotifier(
      control: _formArray,
      child: widget.child,
    );
  }
}
