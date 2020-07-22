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

  /// Emits when a control is added or removed from collection.
  Stream<Iterable<AbstractControl>> get collectionChanges =>
      _collectionChanges.stream;

  /// Returns the calculated status depending of the status of the children
  /// controls
  ControlStatus get childrenStatus;

  /// Recalculates the validation status of the control based on children.
  void updateStatusAndValidity();

  /// Recalculates the value and validation status of the control
  /// based on children.
  void updateValueAndValidity();

  void closeCollectionEvents() {
    _collectionChanges.close();
  }

  void emitsCollectionChanged(Iterable<AbstractControl> controls) {
    _collectionChanges.add(List.unmodifiable(controls));
  }
}
