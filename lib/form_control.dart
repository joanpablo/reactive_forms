import 'package:flutter/foundation.dart';
import 'package:reactive_forms/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class FormControl extends ChangeNotifier implements ValueListenable<String> {
  final List<ValidatorFunction> validators;
  final Map<String, dynamic> errors = {};
  final PublishSubject _onStatusChangedSubject = PublishSubject();
  bool touched;

  FormControl({
    String defaultValue,
    this.validators = const [],
    this.touched = false,
  }) : _value = defaultValue {
    _validate();
  }

  @override
  String get value => _value;
  String _value;

  set value(String newValue) {
    if (_value == newValue) return;
    _value = newValue;
    _validate();
    notifyListeners();
  }

  @override
  void dispose() {
    this._onStatusChangedSubject.close();
    super.dispose();
  }

  Stream get onStatusChanged => _onStatusChangedSubject.stream;

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

  void _validate() {
    this.errors.clear();
    this.validators.forEach((validator) {
      final error = validator(this._value);
      if (error != null) {
        this.errors.addAll(error);
      }
    });
  }
}
