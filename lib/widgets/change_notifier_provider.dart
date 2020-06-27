import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/base_notifier_impl.dart';

typedef ChangeNotifierProviderDispose<T> = void Function(T notifier);

///This class is responsible for create an InheritedNotifier for
///exposing a notifier to all descendants widgets. It also
///brings a mechanism to dispose when the provider disposes itself.
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T notifier;
  final ChangeNotifierProviderDispose<T> dispose;

  const ChangeNotifierProvider(
      {Key key, @required this.notifier, this.dispose, @required this.child})
      : super(key: key);

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  @override
  Widget build(BuildContext context) {
    print('build ChangeNotifierProvider');
    return BaseInheritedNotifier<T>(
      notifier: widget.notifier,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.dispose?.call(widget.notifier);
    super.dispose();
  }
}
