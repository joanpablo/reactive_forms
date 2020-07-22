import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/widgets/form_control_inherited_notifier.dart';

void main() {
  group('FormControlInheritedStreamer tests', () {
    test('Assert Error if child in null', () {
      // Given: an InheritedStreamer with null child
      final inheritedStream = () => FormControlInheritedStreamer(
            child: null,
            stream: Stream.empty(),
            control: FormGroup({}),
          );

      expect(() => inheritedStream(), throwsAssertionError);
    });

    test('Assert Error if stream in null', () {
      // Given: an InheritedStreamer with null child
      final inheritedStream = () => FormControlInheritedStreamer(
            child: Container(),
            stream: null,
            control: FormGroup({}),
          );

      expect(() => inheritedStream(), throwsAssertionError);
    });

    test('Assert Error if control in null', () {
      // Given: an InheritedStreamer with null child
      final inheritedStream = () => FormControlInheritedStreamer(
            child: Container(),
            stream: Stream.empty(),
            control: null,
          );

      expect(() => inheritedStream(), throwsAssertionError);
    });
  });
}
