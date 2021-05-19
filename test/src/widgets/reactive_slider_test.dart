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
          'sliderValue': FormControl<double>(value: 50.0),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: gets slider value
        final slider = tester.firstWidget<Slider>(find.byType(Slider));
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
          'sliderValue': FormControl<double>(value: 0.0),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: updates control value
        form.control('sliderValue').value = 100.0;

        // And: gets slider value
        await tester.pump();
        final slider = tester.firstWidget<Slider>(find.byType(Slider));
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
          'sliderValue': FormControl<double>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // Then: the slider is disabled
        final slider = tester.firstWidget<Slider>(find.byType(Slider));
        expect(slider.onChanged, null);
      },
    );

    testWidgets(
      'Disable a control disable Slider',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'sliderValue': FormControl<double>(),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: disable form
        form.markAsDisabled();
        await tester.pump();

        // Then: the slider is disabled
        final slider = tester.firstWidget<Slider>(find.byType(Slider));
        expect(slider.onChanged, null);
      },
    );

    testWidgets(
      'Enable a control enable Slider',
      (WidgetTester tester) async {
        // Given: a form with disabled control
        final form = FormGroup({
          'sliderValue': FormControl<double>(disabled: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: enable form
        form.markAsEnabled();
        await tester.pump();

        // Then: the slider is enabled
        final slider = tester.firstWidget<Slider>(find.byType(Slider));
        expect(slider.onChanged != null, true);
      },
    );

    testWidgets(
      'IntValueAccessor selected when control is FormControl<int>',
      (WidgetTester tester) async {
        // Given: a form with an int control
        final form = FormGroup({
          'sliderValue': FormControl<int>(value: 10),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // When: get the state of the text field
        final state = tester.allStates
                .firstWhere((state) => state.widget is ReactiveSlider)
            as ReactiveFormFieldState<num, double>;

        // Then: the value accessor is IntValueAccessor
        expect(state.valueAccessor, isInstanceOf<SliderIntValueAccessor>());
      },
    );
  });
}
