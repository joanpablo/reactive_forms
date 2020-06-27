import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_group.dart';

/// Represents an Inherited Widget that exposes a [FormGroup]
/// to its descendants and listen to changes to rebuilds all
/// the dependents widgets.
class FormGroupInheritedNotifier extends InheritedNotifier<FormGroup> {
  FormGroupInheritedNotifier(
      {@required FormGroup formGroup, @required Widget child})
      : super(notifier: formGroup, child: child);
}
