// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

abstract class InheritedStreamer<T> extends InheritedWidget {
  const InheritedStreamer(this.stream, Widget child, {Key? key})
      : super(key: key, child: child);

  final Stream<T> stream;

  @override
  bool updateShouldNotify(InheritedStreamer<T> oldWidget) {
    return oldWidget.stream != stream;
  }

  @override
  _InheritedNotifierElement<T> createElement() =>
      _InheritedNotifierElement<T>(this);
}

class _InheritedNotifierElement<T> extends InheritedElement {
  _InheritedNotifierElement(InheritedStreamer<T> widget) : super(widget) {
    _subscription = widget.stream.listen(_handleUpdate);
  }

  @override
  InheritedStreamer<T> get widget => super.widget as InheritedStreamer<T>;

  bool _dirty = false;

  late StreamSubscription<T> _subscription;

  @override
  void update(InheritedStreamer<T> newWidget) {
    final oldStream = widget.stream;
    final newStream = newWidget.stream;
    if (oldStream != newStream) {
      _subscription.cancel();
      _subscription = newStream.listen(_handleUpdate);
    }
    super.update(newWidget);
  }

  @override
  Widget build() {
    if (_dirty) notifyClients(widget);
    return super.build();
  }

  void _handleUpdate(T status) {
    _dirty = true;
    markNeedsBuild();
  }

  @override
  void notifyClients(InheritedStreamer<T> oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  void unmount() {
    _subscription.cancel();
    super.unmount();
  }
}
