import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    this.onChanged,
  });
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: context.loc.password,
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: context.loc.requiredError),
        MinLengthValidator(
          8,
          errorText: context.loc.passwordMinLengthError,
        ),
      ]),
    );
  }
}
