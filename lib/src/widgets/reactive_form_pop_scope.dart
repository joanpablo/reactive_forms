import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormPopScope extends StatelessWidget {
  final bool Function(FormGroup formGroup)? canPop;
  final void Function(FormGroup formGroup, bool didPop)? onPopInvoked;
  final Widget child;

  const ReactiveFormPopScope({
    super.key,
    this.canPop,
    this.onPopInvoked,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, formGroup, _) {
        return PopScope(
          canPop: canPop != null ? canPop!(formGroup) : true,
          onPopInvoked: onPopInvoked != null
              ? (didPop) => onPopInvoked!(formGroup, didPop)
              : null,
          child: child,
        );
      },
    );
  }
}
