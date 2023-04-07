import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    this.onChanged,
  });
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: context.loc.email,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: MultiValidator([
        RequiredValidator(errorText: context.loc.requiredError),
        EmailValidator(errorText: context.loc.invalidEmailError)
      ]),
    );
  }
}
