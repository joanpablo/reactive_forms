import 'package:flutter/material.dart';
import 'package:reactive_forms/exceptions/form_control_not_found_exception.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveValueListenableBuilderCallback<T> = Widget Function(
    BuildContext context, T value, Widget child);

class ReactiveValueListenableBuilder<T> extends StatefulWidget {
  final String formControlName;
  final Widget child;
  final ReactiveValueListenableBuilderCallback<T> builder;

  const ReactiveValueListenableBuilder({
    Key key,
    @required this.formControlName,
    @required this.builder,
    this.child,
  })  : assert(formControlName != null),
        assert(builder != null);

  @override
  _ReactiveValueListenableBuilderState<T> createState() =>
      _ReactiveValueListenableBuilderState<T>();
}

class _ReactiveValueListenableBuilderState<T>
    extends State<ReactiveValueListenableBuilder<T>> {
  FormControl _control;

  @override
  void initState() {
    final form = ReactiveForm.of(context, listen: false);
    _control = form.formControl(widget.formControlName);
    if (_control == null) {
      throw FormControlNotFoundException(widget.formControlName);
    }

    this.subscribeFormControl();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final form = ReactiveForm.of(context, listen: false);
    final newControl = form.formControl(widget.formControlName);
    if (_control != newControl) {
      this.unsubscribeFormControl();
      _control = newControl;
      subscribeFormControl();
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this.unsubscribeFormControl();
    super.dispose();
  }

  @protected
  void subscribeFormControl() {
    _control.onValueChanged.addListener(_onFormControlValueChanged);
  }

  @protected
  void unsubscribeFormControl() {
    _control.onValueChanged.removeListener(_onFormControlValueChanged);
  }

  void _onFormControlValueChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _control.value, widget.child);
  }
}
