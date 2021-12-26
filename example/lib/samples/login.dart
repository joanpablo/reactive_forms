import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'login.gform.dart';

Map<String, dynamic>? requiredValidator(AbstractControl<dynamic> control) {
  return Validators.required(control);
}

enum UserMode { user, admin }

@ReactiveFormAnnotation()
class Login {
  final String email;

  final String password;

  final bool rememberMe;

  final String theme;

  final UserMode mode;

  final int timeout;

  final double height;

  final String? unAnnotated;

  Login({
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        this.email = 'default@e.mail',
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        required this.password,
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        required this.rememberMe,
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        required this.theme,
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        required this.mode,
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        required this.timeout,
    @FormControlAnnotation(
      validators: [
        requiredValidator,
      ],
    )
        required this.height,
    this.unAnnotated,
  });
}
