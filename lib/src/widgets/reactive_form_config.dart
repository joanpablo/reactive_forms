// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_form_field.dart';

/// This class is responsible for exposing general configuration
/// properties to all descendants widgets.
///
/// This widget helps to define configurations at application level.
class ReactiveFormConfig extends InheritedWidget {
  /// A function that returns the [Map] that stores custom validation messages
  /// for each error.
  final Map<String, ValidationMessageFunction> validationMessages;

  /// Creates an instance of [ReactiveFormConfig].
  ///
  /// The arguments [validationMessages] and [child] are required.
  ///
  /// ### Example:
  /// This widget is useful to define global configurations at
  /// application level.
  ///
  /// ```dart
  /// ReactiveFormConfig(
  ///   validationMessages: {
  ///     ValidationMessage.required: (_) => 'Field must not be empty',
  ///   },
  ///   child: MaterialApp(...)
  /// );
  /// ```
  const ReactiveFormConfig({
    required super.child,
    required this.validationMessages,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant ReactiveFormConfig oldWidget) {
    return oldWidget.validationMessages != validationMessages;
  }

  /// Returns the nearest model up its widget tree.
  ///
  /// If no model is founded, then `null` is returned.
  static ReactiveFormConfig? of(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<ReactiveFormConfig>();

    return element != null ? (element.widget as ReactiveFormConfig) : null;
  }
}
