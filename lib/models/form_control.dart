import 'package:flutter/foundation.dart';
import 'package:reactive_forms/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class FormControl extends ChangeNotifier implements ValueListenable<dynamic> {
  final List<ValidatorFunction> validators;
  final Map<String, dynamic> errors = {};
  final PublishSubject _onStatusChangedSubject = PublishSubject();
  final PublishSubject _onFocusChangedSubject = PublishSubject();
  bool touched;
  bool _focused = false;
  dynamic _value;
  dynamic defaultValue;

  FormControl({
    this.defaultValue,
    this.validators = const [],
    this.touched = false,
  }) : _value = defaultValue {
    _validate();
  }

  @override
  dynamic get value => _value;

  bool get focused => _focused;

  set value(dynamic newValue) {
    if (_value == newValue) return;
    _value = newValue;
    _validate();
    notifyListeners();
  }

  @override
  void dispose() {
    this._onStatusChangedSubject.close();
    this._onFocusChangedSubject.close();
    super.dispose();
  }

  Stream get onStatusChanged => _onStatusChangedSubject.stream;

  Stream get onFocusChanged => _onFocusChangedSubject.stream;

  bool get valid => this.errors.keys.length == 0;

  bool get invalid => !this.valid;

  void addError(Map<String, dynamic> error) {
    final prevStatus = this.valid;
    this.errors.addAll(error);
    if (prevStatus != this.valid) {
      _onStatusChangedSubject.add(this.valid);
    }
  }

  void removeError(String errorName) {
    final prevStatus = this.valid;
    this.errors.remove(errorName);
    if (prevStatus != this.valid) {
      _onStatusChangedSubject.add(this.valid);
    }
  }

  void reset() {
    this.value = this.defaultValue;
  }

  void _validate() {
    this.errors.clear();
    this.validators.forEach((validator) {
      final error = validator(this._value);
      if (error != null) {
        this.errors.addAll(error);
      }
    });
  }

  void unfocus() {
    if (this._focused) {
      this._focused = false;
      this._onFocusChangedSubject.add(this._focused);
    }
  }

  void focus() {
    if (!this._focused) {
      this._focused = true;
      this._onFocusChangedSubject.add(this._focused);
    }
  }
}
