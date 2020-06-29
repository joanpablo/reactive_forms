import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents an Inherited Widget that exposes a ChangeNotifier
/// to its descendants and listen to changes in notifier/model and rebuilds all
/// the dependents widgets.
class FormGroupInheritedNotifier extends InheritedNotifier<FormGroup> {
  FormGroupInheritedNotifier(
      {@required FormGroup notifier, @required Widget child})
      : super(notifier: notifier, child: child);
}
