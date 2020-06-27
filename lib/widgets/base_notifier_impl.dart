import 'package:flutter/material.dart';

/// Represents an Inherited Widget that exposes a ChangeNotifier
/// to its descendants and listen to changes in notifier/model and rebuilds all
/// the dependents widgets.
class BaseInheritedNotifier<T extends Listenable> extends InheritedNotifier<T> {
  BaseInheritedNotifier({@required T notifier, @required Widget child})
      : super(notifier: notifier, child: child);
}
