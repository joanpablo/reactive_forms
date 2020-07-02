import 'package:flutter/foundation.dart';

abstract class AbstractControl<T> {
  T get value;
  set value(T newValue);
  bool get valid;
  bool get invalid;
  void reset();

  ValueListenable<bool> get onStatusChanged;
  ValueListenable<T> get onValueChanged;

  dispose();

  void addError(Map<String, bool> map);

  void removeError(String error);
}
