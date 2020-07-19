import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is the definition of the builder function used in the widgets
/// [ReactiveStatusListenableBuilder] and [ReactiveValueListenableBuilder].
typedef ReactiveListenableWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AbstractControl<T> control,
  Widget child,
);
