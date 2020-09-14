import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// The base class form [FormGroup] and [FormArray].
/// Its provides methods for get a control by [name] and a [Listenable]
/// that emits events each time you add or remove a control to the collection.
abstract class FormControlCollection {
  final _collectionChanges =
      StreamController<Iterable<AbstractControl>>.broadcast();

  /// Returns a [AbstractControl] by its name.
  ///
  /// Throws [FormControlNotFoundException] if no control founded with
  /// the specified [name].
  AbstractControl control(String name);

  /// Checks if collection contains a control by a given [name].
  ///
  /// Returns true if collection contains the control, otherwise returns false.
  bool contains(String name);

  /// Emits when a control is added or removed from collection.
  Stream<Iterable<AbstractControl>> get collectionChanges =>
      _collectionChanges.stream;

  /// Close stream that emit collection change events
  void closeCollectionEvents() {
    _collectionChanges.close();
  }

  /// Notify to listeners that the collection changed.
  ///
  /// This is for internal use only.
  @protected
  void emitsCollectionChanged(Iterable<AbstractControl> controls) {
    _collectionChanges.add(List.unmodifiable(controls));
  }
}
