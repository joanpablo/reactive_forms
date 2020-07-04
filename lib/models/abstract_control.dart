import 'package:flutter/foundation.dart';

abstract class AbstractControl<T> {
  T get value;
  set value(T newValue);
  bool get valid;
  bool get invalid;
  final _onStatusChanged = ValueNotifier<bool>(true);

  Map<String, dynamic> get errors;

  /// A [Stream] that emits an event every time the validation status of
  /// the control changes.
  ValueListenable<bool> get onStatusChanged => _onStatusChanged;

  ValueListenable<T> get onValueChanged;

  @protected
  void dispose() {
    _onStatusChanged.dispose();
  }

  void reset();

  void addError(Map<String, bool> map);

  void removeError(String error);

  @protected
  void notifyStatusChanged() {
    this._onStatusChanged.value = this.valid;
  }
}
