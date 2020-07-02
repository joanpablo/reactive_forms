import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveValueListenableBuilder<T> extends StatelessWidget {
  final String formControlName;
  final Widget child;
  final ValueWidgetBuilder<T> builder;

  const ReactiveValueListenableBuilder({
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
    return ValueListenableBuilder<T>(
      valueListenable: formControl.onValueChanged,
      builder: this.builder,
    );
  }
}
