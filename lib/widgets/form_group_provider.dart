import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/widgets/form_group_inherited_notifier.dart';

///This class is responsible for create an InheritedNotifier for
///exposing a notifier to all descendants widgets. It also
///brings a mechanism to dispose when the provider disposes itself.
class FormGroupProvider extends StatefulWidget {
  final Widget child;
  final FormGroup formGroup;

  const FormGroupProvider(
      {Key key, @required this.formGroup, @required this.child})
      : super(key: key);

  @override
  _FormGroupProviderState createState() => _FormGroupProviderState();
}

class _FormGroupProviderState extends State<FormGroupProvider> {
  @override
  Widget build(BuildContext context) {
    return FormGroupInheritedNotifier(
      notifier: widget.formGroup,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.formGroup.dispose();
    super.dispose();
  }
}
