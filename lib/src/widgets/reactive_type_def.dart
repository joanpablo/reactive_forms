import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveListenableWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AbstractControl<T> control,
  Widget child,
);
