import 'package:flutter/foundation.dart';

class FocusEvent {
  final bool hasFocus;
  final bool markAsTouched;

  FocusEvent({
    @required this.hasFocus,
    @required this.markAsTouched,
  })  : assert(hasFocus != null),
        assert(markAsTouched != null);
}
