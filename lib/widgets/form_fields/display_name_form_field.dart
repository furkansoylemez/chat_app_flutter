import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class DisplayNameFormField extends StatelessWidget {
  const DisplayNameFormField({
    super.key,
    this.onChanged,
  });
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: context.loc.displayName,
      ),
      keyboardType: TextInputType.name,
      validator: MultiValidator([
        RequiredValidator(errorText: context.loc.requiredError),
        MinLengthValidator(
          AppConstants.displayNameMinLength,
          errorText: context.loc
              .displayNameMinLengthError(AppConstants.displayNameMinLength),
        )
      ]),
    );
  }
}
