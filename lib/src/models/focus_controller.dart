import 'package:flutter/foundation.dart';

abstract class FocusController extends ChangeNotifier {
  bool _hasFocus = false;

  bool get hasFocus => _hasFocus;

  void updateFocus(bool hasFocus, {bool emitEvent = true}) {
    if (_hasFocus != hasFocus) {
      _hasFocus = hasFocus;
      if (emitEvent) {
        notifyListeners();
      }
    }
  }

  void onControlFocusChanged(bool hasFocus);
}
