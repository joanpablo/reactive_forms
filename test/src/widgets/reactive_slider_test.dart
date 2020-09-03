import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_slider_testing_widget.dart';

void main() {
  group('ReactiveSlider Tests', () {
    testWidgets(
      'Slider initialize with control default value',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'sliderValue': FormControl(value: 50.0),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: gets slider value
        Slider slider = tester.firstWidget(find.byType(Slider)) as Slider;
        final sliderValue = slider.value;

        // Then: value equals to control value
        expect(sliderValue, form.control('sliderValue').value);
      },
    );

    testWidgets(
      'Change Control value updates slider value',
      (WidgetTester tester) async {
        // Given: a form with and control with default value
        final form = FormGroup({
          'sliderValue': FormControl(value: 0.0),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: updates control value
        form.control('sliderValue').value = 100.0;

        // And: gets slider value
        await tester.pump();
        Slider slider = tester.firstWidget(find.byType(Slider)) as Slider;
        final sliderValue = slider.value;

        // Then: value equals to control value
        expect(sliderValue, form.control('sliderValue').value);
      },
    );

    testWidgets(
      'Control disabled by default disable Slider',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'sliderValue': FormControl(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // Then: the slider is disabled
        Slider slider = tester.firstWidget(find.byType(Slider)) as Slider;
        expect(slider.onChanged, null);
      },
    );

    testWidgets(
      'Disable a control disable Slider',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'sliderValue': FormControl(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: disable form
        form.disable();
        await tester.pump();

        // Then: the slider is disabled
        Slider slider = tester.firstWidget(find.byType(Slider)) as Slider;
        expect(slider.onChanged, null);
      },
    );

    testWidgets(
      'Enable a control enable Slider',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'sliderValue': FormControl(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: enable form
        form.enable();
        await tester.pump();

        // Then: the slider is enabled
        Slider slider = tester.firstWidget(find.byType(Slider)) as Slider;
        expect(slider.onChanged != null, true);
      },
    );
  });
}
