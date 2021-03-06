// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

abstract class InheritedStreamer extends InheritedWidget {
  const InheritedStreamer({
    Key key,
    this.stream,
    required Widget child,
  })   : assert(child != null),
        assert(stream != null),
        super(key: key, child: child);

  final Stream stream;

  @override
  bool updateShouldNotify(InheritedStreamer oldWidget) {
    return oldWidget.stream != stream;
  }

  @override
  _InheritedNotifierElement createElement() => _InheritedNotifierElement(this);
}

class _InheritedNotifierElement extends InheritedElement {
  _InheritedNotifierElement(InheritedStreamer widget) : super(widget) {
    _subscription = widget.stream.listen(_handleUpdate);
  }

  @override
  InheritedStreamer get widget => super.widget as InheritedStreamer;

  bool _dirty = false;

  StreamSubscription _subscription;

  @override
  void update(InheritedStreamer newWidget) {
    final Stream oldStream = widget.stream;
    final Stream newStream = newWidget.stream;
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

  void _handleUpdate(_) {
    _dirty = true;
    markNeedsBuild();
  }

  @override
  void notifyClients(InheritedStreamer oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  void unmount() {
    _subscription.cancel();
    super.unmount();
  }
}
