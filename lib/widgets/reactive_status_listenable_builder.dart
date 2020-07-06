import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveStatusListenableWidgetBuilder = Widget Function(
    BuildContext context, AbstractControl control, Widget child);

class ReactiveStatusListenableBuilder extends StatelessWidget {
  final String formControlName;
  final Widget child;
  final ReactiveStatusListenableWidgetBuilder builder;

  const ReactiveStatusListenableBuilder({
    Key key,
    @required this.formControlName,
    @required this.builder,
    this.child,
  })  : assert(formControlName != null),
        assert(builder != null);

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context, listen: false);
    final formControl = form.formControl(this.formControlName);
    return ValueListenableBuilder<ControlStatus>(
      valueListenable: formControl.onStatusChanged,
      builder: (context, status, child) =>
          this.builder(context, formControl, child),
    );
  }
}
