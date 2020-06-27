import 'package:flutter/material.dart';
import 'package:reactive_forms/models/form_group.dart';
import 'package:reactive_forms/widgets/provider.dart';

typedef ReactiveFormConsumerBuilder = Widget Function(
    BuildContext context, FormGroup formGroup, Widget child);

class ReactiveFormConsumer extends StatelessWidget {
  final Widget child;
  final ReactiveFormConsumerBuilder builder;

  const ReactiveFormConsumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final formGroup = Provider.of<FormGroup>(context);
    return this.builder(context, formGroup, this.child);
  }
}
