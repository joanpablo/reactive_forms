import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_group.dart';
import 'package:reactive_forms/widgets/change_notifier_provider.dart';
import 'package:reactive_forms/widgets/form_group_inherited_notifier.dart';

///This class is responsible for create an [FormGroupInheritedNotifier] for
///exposing a [FormGroup] to all descendants widgets. It also
///brings a mechanism to dispose when the [ReactiveForm] disposes itself.
class ReactiveForm extends StatelessWidget {
  final Widget child;
  final FormGroup formGroup;

  const ReactiveForm({
    Key key,
    @required this.formGroup,
    @required this.child,
  })  : assert(formGroup != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FormGroup>(
      notifier: this.formGroup,
      child: this.child,
    );
  }
}
