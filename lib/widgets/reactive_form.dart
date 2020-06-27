import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_group.dart';
import 'package:reactive_forms/widgets/form_group_inherited_notifier.dart';
import 'package:reactive_forms/widgets/form_group_provider.dart';

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

  /// Returns the nearest model up its widget tree
  ///
  /// If [rebuildContext] is `true` (default value), all the dependents widgets
  /// will rebuild
  ///
  /// `rebuildContext: false` is necessary if want to avoid rebuilding the
  /// [context] when model changes:
  static FormGroup of(BuildContext context, {bool rebuildContext: true}) {
    if (rebuildContext) {
      return context
          .dependOnInheritedWidgetOfExactType<FormGroupInheritedNotifier>()
          .notifier;
    }

    final element = context
        .getElementForInheritedWidgetOfExactType<FormGroupInheritedNotifier>();
    return (element.widget as InheritedNotifier<FormGroup>).notifier;
  }

  @override
  Widget build(BuildContext context) {
    return FormGroupProvider(
      formGroup: this.formGroup,
      child: this.child,
    );
  }
}
