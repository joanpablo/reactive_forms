import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Files that wrap Material widgets or types and therefore must import
/// `package:flutter/material.dart`.
///
/// Everything else in `lib` must stay independent of Material so it keeps
/// working when Material is decoupled from the Flutter SDK
/// (https://pub.dev/packages/material_ui).
const _materialFiles = {
  'lib/src/models/form_builder.dart',
  'lib/src/value_accessors/time_of_day_value_accessor.dart',
  'lib/src/widgets/reactive_checkbox.dart',
  'lib/src/widgets/reactive_checkbox_list_tile.dart',
  'lib/src/widgets/reactive_date_picker.dart',
  'lib/src/widgets/reactive_dropdown_field.dart',
  'lib/src/widgets/reactive_radio.dart',
  'lib/src/widgets/reactive_radio_list_tile.dart',
  'lib/src/widgets/reactive_slider.dart',
  'lib/src/widgets/reactive_switch.dart',
  'lib/src/widgets/reactive_switch_list_tile.dart',
  'lib/src/widgets/reactive_text_field.dart',
  'lib/src/widgets/reactive_time_picker.dart',
};

void main() {
  group('Material dependency Tests', () {
    test('Only Material wrappers import package:flutter/material.dart', () {
      // Given: all the library files
      final files = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));

      // When: collect the files importing Material
      final importingMaterial = {
        for (final file in files)
          if (file.readAsStringSync().contains(
            "import 'package:flutter/material.dart'",
          ))
            file.path.replaceAll(r'\', '/'),
      };

      // Then: only the Material wrappers import it
      expect(importingMaterial, _materialFiles);
    });
  });
}
