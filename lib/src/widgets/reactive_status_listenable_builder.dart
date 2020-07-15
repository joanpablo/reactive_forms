import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This widget listen for changes in the status of a [FormControl] specified
/// in [formControlName] property and call [builder] function to rebuild widgets.
///
/// This widget is just a wrapper around [ValueListenableBuilder]
/// that listen [AbstractControl.onStatusChanged]
///
class ReactiveStatusListenableBuilder extends StatelessWidget {
  final String formControlName;
  final Widget child;
  final ReactiveListenableWidgetBuilder builder;

  /// Creates an instance of [ReactiveStatusListenableBuilder].
  ///
  /// The [formControlName] and the [builder] function must not be null.
  ///
  const ReactiveStatusListenableBuilder({
    Key key,
    @required this.formControlName,
    @required this.builder,
    this.child,
  })  : assert(formControlName != null),
        assert(builder != null);

  @override
  Widget build(BuildContext context) {
    final form =
        ReactiveForm.of(context, listen: false) as FormControlCollection;
    final formControl = form.formControl(this.formControlName);
    return ValueListenableBuilder<ControlStatus>(
      valueListenable: formControl.onStatusChanged,
      builder: (context, status, child) =>
          this.builder(context, formControl, child),
    );
  }
}
