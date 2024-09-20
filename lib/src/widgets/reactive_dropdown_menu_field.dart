import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A reactive widget that wraps a [DropdownMenu].
class ReactiveDropdownMenuField<T> extends ReactiveFocusableFormField<T, T> {
  final List<DropdownMenuEntry<T>> _dropdownMenuEntries;

  ReactiveDropdownMenuField({
    required List<DropdownMenuEntry<T>> dropdownMenuEntries,
    super.key,
    super.formControlName,
    super.formControl,
    super.focusNode,
    super.validationMessages,
    super.showErrors,
    bool readOnly = false,
    bool enabled = true,
    Widget? label,
    double? width,
    double? menuHeight,
    Widget? leadingIcon,
    Widget? trailingIcon,
    String? hintText,
    String? helperText,
    Widget? selectedTrailingIcon,
    bool enableFilter = false,
    bool enableSearch = true,
    TextStyle? textStyle,
    TextAlign textAlign = TextAlign.start,
    InputDecorationTheme? inputDecorationTheme,
    MenuStyle? menuStyle,
    ValueChanged<FormControl<T?>>? onSelected,
    bool? requestFocusOnTap,
    EdgeInsets? expandedInsets,
    FilterCallback<T>? filterCallback,
    SearchCallback<T>? searchCallback,
    List<TextInputFormatter>? inputFormatters,
  })  : _dropdownMenuEntries = dropdownMenuEntries,
        super(
          builder: (state) {
            final field = state as ReactiveDropdownMenuFieldState<ReactiveDropdownMenuField<T>, T, T>;

            var effectiveValue = field.value;
            if (effectiveValue != null && !dropdownMenuEntries.any((item) => item.value == effectiveValue)) {
              effectiveValue = null;
            }

            return DropdownMenu<T>(
              enabled: enabled,
              width: width,
              menuHeight: menuHeight,
              leadingIcon: leadingIcon,
              trailingIcon: trailingIcon,
              label: label,
              hintText: hintText,
              helperText: helperText,
              errorText: field.errorText,
              selectedTrailingIcon: selectedTrailingIcon,
              enableFilter: enableFilter,
              enableSearch: enableSearch,
              textStyle: textStyle,
              textAlign: textAlign,
              inputDecorationTheme: inputDecorationTheme,
              menuStyle: menuStyle,
              controller: field._controller,
              initialSelection: effectiveValue,
              onSelected: readOnly || field.control.disabled
                  ? null
                  : (value) {
                      field.didChange(value);
                      onSelected?.call(field.control);
                    },
              focusNode: field.focusNode,
              requestFocusOnTap: requestFocusOnTap,
              expandedInsets: expandedInsets,
              filterCallback: filterCallback,
              searchCallback: searchCallback,
              dropdownMenuEntries: dropdownMenuEntries,
              inputFormatters: inputFormatters,
            );
          },
        );

  @override
  ReactiveDropdownMenuFieldState<ReactiveDropdownMenuField<T>, T, T> createState() =>
      ReactiveDropdownMenuFieldState<ReactiveDropdownMenuField<T>, T, T>();
}

class ReactiveDropdownMenuFieldState<W extends ReactiveDropdownMenuField<T>, T, V>
    extends ReactiveFocusableFormFieldState<T, T> {
  final TextEditingController _controller = TextEditingController();

  W get _reactiveWidget => widget as W;

  @override
  void dispose() {
    _controller.removeListener(_ensureValueIsInEntries);
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_ensureValueIsInEntries);
  }

  void _ensureValueIsInEntries() {
    final match = _reactiveWidget._dropdownMenuEntries
        .firstWhereOrNull((item) => item.label.toLowerCase() == _controller.text.toLowerCase());

    if (match != null && match.value != value) {
      didChange(match.value);
    }

    if (match == null && value != null) {
      didChange(null);
    }
  }
}
