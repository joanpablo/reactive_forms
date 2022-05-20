// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// The base class form [FormGroup] and [FormArray].
/// Its provides methods for get a control by name and a [Listenable]
/// that emits events each time you add or remove a control to the collection.
abstract class FormControlCollection<T> {
  final _collectionChanges =
      StreamController<List<AbstractControl<Object?>>>.broadcast();

  /// Retrieves a child control given the control's [name] or path.
  ///
  /// The [name] is a dot-delimited string that define the path to the
  /// control.
  ///
  /// Throws [FormControlNotFoundException] if no control founded with
  /// the specified [name]/path.
  AbstractControl<dynamic> control(String name);

  /// Checks if collection contains a control by a given [name].
  ///
  /// Returns true if collection contains the control, otherwise returns false.
  bool contains(String name);

  /// Emits when a control is added or removed from collection.
  Stream<List<AbstractControl<Object?>>> get collectionChanges =>
      _collectionChanges.stream;

  /// Close stream that emit collection change events
  void closeCollectionEvents() {
    _collectionChanges.close();
  }

  /// Notify to listeners that the collection changed.
  ///
  /// This is for internal use only.
  @protected
  void emitsCollectionChanged(List<AbstractControl<Object?>> controls) {
    _collectionChanges.add(List.unmodifiable(controls));
  }

  /// Walks the [path] to find the matching control.
  ///
  /// Returns null if no match is found.
  AbstractControl<Object>? findControlInCollection(List<String> path) {
    if (path.isEmpty) {
      return null;
    }

    final result = path.fold(this as AbstractControl<Object>, (control, name) {
      if (control is FormControlCollection<dynamic>) {
        final collection = control;
        return collection.contains(name) ? collection.control(name) : null;
      } else {
        return null;
      }
    });

    return result != null ? result as AbstractControl<Object> : null;
  }
}
