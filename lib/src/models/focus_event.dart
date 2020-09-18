import 'package:flutter/foundation.dart';

/// Represents a focus changes event triggered by a control
class FocusEvent {
  /// Gets if the control has the focus
  final bool hasFocus;

  /// Gets if control should be marked as touched.
  ///
  /// If *true* the control should be marked as touched by the UI.
  final bool markAsTouched;

  /// Constructs an instance of the event
  FocusEvent({
    @required this.hasFocus,
    @required this.markAsTouched,
  })  : assert(hasFocus != null),
        assert(markAsTouched != null);
}
