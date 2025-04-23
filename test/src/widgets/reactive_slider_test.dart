import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_slider_testing_widget.dart';

void main() {
  group('ReactiveSlider Tests', () {
    testWidgets('Slider initialize with control default value', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(value: 50.0),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // When: gets slider value
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      final sliderValue = slider.value;

      // Then: value equals to control value
      expect(sliderValue, form.control(reactiveSliderTestingName).value);
    });

    testWidgets('Slider with label builder', (WidgetTester tester) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(value: 50.0),
      });

      // And: a widget that is bind to the form with a label builder
      await tester.pumpWidget(
        ReactiveSliderTestingWidget(
          form: form,
          labelBuilder: (value) => value.toStringAsPrecision(2),
        ),
      );

      // When: gets slider label
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      final sliderLabel = slider.label;
      final expectedLabel = (form.control(reactiveSliderTestingName)
              as FormControl<double>)
          .value!
          .toStringAsPrecision(2);

      // Then: slider label equals to expected label
      expect(sliderLabel, expectedLabel);
    });

    testWidgets('Slider notify onChanged callback', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(value: 50.0),
      });

      var callbackCalled = false;
      FormControl<num>? callbackArgument;

      // And: a widget that is bind to the form with a label builder
      await tester.pumpWidget(
        ReactiveSliderTestingWidget(
          form: form,
          labelBuilder: (value) => value.toStringAsPrecision(2),
          onChanged: (control) {
            callbackCalled = true;
            callbackArgument = control;
          },
        ),
      );

      // When: change the value of the slider
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      slider.onChanged!(20.0);
      await tester.pump();

      // Then: the slider notify the on changed event
      expect(callbackCalled, true, reason: 'Slider onChanged not called');

      // And: the argument of the callback is the control
      expect(
        callbackArgument,
        form.control(reactiveSliderTestingName),
        reason: 'Slider onChanged does not provide control as argument',
      );
    });

    testWidgets('Slider notify onChangeStart callback', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(value: 50.0),
      });

      var callbackCalled = false;
      FormControl<num>? callbackArgument;

      // And: a widget that is bind to the form with a label builder
      await tester.pumpWidget(
        ReactiveSliderTestingWidget(
          form: form,
          labelBuilder: (value) => value.toStringAsPrecision(2),
          onChangeStart: (control) {
            callbackCalled = true;
            callbackArgument = control;
          },
        ),
      );

      // When: change the value of the slider
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      slider.onChangeStart!(20.0);
      await tester.pump();

      // Then: the slider notify the on changed event
      expect(callbackCalled, true, reason: 'Slider onChangeStart not called');

      // And: the argument of the callback is the control
      expect(
        callbackArgument,
        form.control(reactiveSliderTestingName),
        reason: 'Slider onChangeStart does not provide control as argument',
      );
    });

    testWidgets('Slider notify onChangeEnd callback', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(value: 50.0),
      });

      var callbackCalled = false;
      FormControl<num>? callbackArgument;

      // And: a widget that is bind to the form with a label builder
      await tester.pumpWidget(
        ReactiveSliderTestingWidget(
          form: form,
          labelBuilder: (value) => value.toStringAsPrecision(2),
          onChangeEnd: (control) {
            callbackCalled = true;
            callbackArgument = control;
          },
        ),
      );

      // When: change the value of the slider
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      slider.onChangeEnd!(20.0);
      await tester.pump();

      // Then: the slider notify the on changed event
      expect(callbackCalled, true, reason: 'Slider onChangeEnd not called');

      // And: the argument of the callback is the control
      expect(
        callbackArgument,
        form.control(reactiveSliderTestingName),
        reason: 'Slider onChangeEnd does not provide control as argument',
      );
    });

    testWidgets('Slider with label builder and min value', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with no default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(),
      });

      // And: a widget that is bind to the form with a label builder
      await tester.pumpWidget(
        ReactiveSliderTestingWidget(
          form: form,
          labelBuilder: (value) => value.toStringAsPrecision(2),
        ),
      );

      // When: gets slider label
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      final sliderLabel = slider.label;
      final expectedLabel = slider.min.toStringAsPrecision(2);

      // Then: slider label equals to min value from label builder
      expect(sliderLabel, expectedLabel);
    });

    testWidgets('Change Control value updates slider value', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(value: 0.0),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // When: updates control value
      form.control(reactiveSliderTestingName).value = 100.0;

      // And: gets slider value
      await tester.pump();
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      final sliderValue = slider.value;

      // Then: value equals to control value
      expect(sliderValue, form.control(reactiveSliderTestingName).value);
    });

    testWidgets('Control disabled by default disable Slider', (
      WidgetTester tester,
    ) async {
      // Given: a form with disabled control
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // Then: the slider is disabled
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      expect(slider.onChanged, null);
    });

    testWidgets('Disable a control disable Slider', (
      WidgetTester tester,
    ) async {
      // Given: a form with disabled control
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // When: disable form
      form.markAsDisabled();
      await tester.pump();

      // Then: the slider is disabled
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      expect(slider.onChanged, null);
    });

    testWidgets('Enable a control enable Slider', (WidgetTester tester) async {
      // Given: a form with disabled control
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<double>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // When: enable form
      form.markAsEnabled();
      await tester.pump();

      // Then: the slider is enabled
      final slider = tester.firstWidget<Slider>(find.byType(Slider));
      expect(slider.onChanged != null, true);
    });

    testWidgets('IntValueAccessor selected when control is FormControl<int>', (
      WidgetTester tester,
    ) async {
      // Given: a form with an int control
      final form = FormGroup({
        reactiveSliderTestingName: FormControl<int>(value: 10),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // When: get the state of the text field
      final state =
          tester.allStates.firstWhere((state) => state.widget is ReactiveSlider)
              as ReactiveFormFieldState<num, double>;

      // Then: the value accessor is IntValueAccessor
      expect(state.valueAccessor, isInstanceOf<SliderIntValueAccessor>());
    });

    testWidgets('Call FormControl.focus() request focus on field', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({reactiveSliderTestingName: FormControl<int>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // Expect: that the field has no focus
      var sliderField = tester.firstWidget<Slider>(find.byType(Slider));
      expect(sliderField.focusNode?.hasFocus, false);

      // When: call FormControl.focus()
      (form.control(reactiveSliderTestingName) as FormControl).focus();
      await tester.pump();

      // Then: the reactive field is focused
      sliderField = tester.firstWidget<Slider>(find.byType(Slider));
      expect(sliderField.focusNode?.hasFocus, true);
    });

    testWidgets('Call FormControl.unfocus() remove focus on field', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({reactiveSliderTestingName: FormControl<int>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // And: the field has focused
      var sliderField = tester.firstWidget<Slider>(find.byType(Slider));
      sliderField.focusNode?.requestFocus();
      await tester.pump();
      expect(sliderField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      (form.control(reactiveSliderTestingName) as FormControl).unfocus();
      await tester.pump();

      // Then: the reactive field is unfocused
      sliderField = tester.firstWidget<Slider>(find.byType(Slider));
      expect(sliderField.focusNode?.hasFocus, false);
    });

    testWidgets('Remove focus on an invalid control show error messages', (
      WidgetTester tester,
    ) async {
      // Given: A group with an invalid control
      final form = FormGroup({reactiveSliderTestingName: FormControl<int>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

      // And: the field has focused
      var sliderField = tester.firstWidget<Slider>(find.byType(Slider));
      sliderField.focusNode?.requestFocus();
      await tester.pump();
      expect(sliderField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      (form.control(reactiveSliderTestingName) as FormControl).unfocus();
      await tester.pump();
    });

    testWidgets(
      'Remove focus, and mark a control as untouched does not show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveSliderTestingName: FormControl<int>(
            validators: [Validators.required],
          ),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveSliderTestingWidget(form: form));

        // And: the field has focused
        var textField = tester.firstWidget<Slider>(find.byType(Slider));
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus(touched: false)
        form.control(reactiveSliderTestingName).unfocus(touched: false);
        await tester.pump();
      },
    );

    testWidgets('Provide a FocusNode to ReactiveSlider', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({reactiveSliderTestingName: FormControl<int>()});

      // And: a focus node
      final focusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(
        ReactiveSliderTestingWidget(form: form, focusNode: focusNode),
      );

      // Expect: field has the provided focus node
      final textField = tester.firstWidget<Slider>(find.byType(Slider));
      expect(textField.focusNode, focusNode);
    });

    testWidgets(
      'Provide a FocusNode to ReactiveSlider and access it through focus controller',
      (WidgetTester tester) async {
        // Given: A group with a field
        final nameControl = FormControl<int>();
        final form = FormGroup({reactiveSliderTestingName: nameControl});

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveSliderTestingWidget(form: form, focusNode: focusNode),
        );

        // Expect: field has the provided focus node and is the same of the focus controller
        final textField = tester.firstWidget<Slider>(find.byType(Slider));
        expect(textField.focusNode, nameControl.focusController?.focusNode);
      },
    );
  });
}
