import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    this.onChanged,
    this.validators,
    required this.labelText,
  });
  final void Function(String)? onChanged;
  final List<FieldValidator<dynamic>>? validators;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: context.loc.requiredError),
        MinLengthValidator(
          AppConstants.passwordMinLength,
          errorText: context.loc
              .passwordMinLengthError(AppConstants.passwordMinLength),
        ),
        if (validators != null) ...validators!,
      ]),
    );
  }
}
