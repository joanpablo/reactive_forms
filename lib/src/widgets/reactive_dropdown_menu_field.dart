import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A reactive widget that wraps a [DropdownMenu].
class ReactiveDropdownMenuField<T> extends ReactiveFocusableFormField<T, T> {
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
    TextEditingController? controller,
    ValueChanged<FormControl<T?>>? onSelected,
    bool? requestFocusOnTap,
    EdgeInsets? expandedInsets,
    FilterCallback<T>? filterCallback,
    SearchCallback<T>? searchCallback,
    List<TextInputFormatter>? inputFormatters,
  }) : super(
          builder: (field) {
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
              controller: controller,
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
}
