import 'package:form_field_validator/form_field_validator.dart';

class PasswordMatchValidator extends TextFieldValidator {
  PasswordMatchValidator(this.password, {required String errorText})
      : super(errorText);
  final String password;

  @override
  bool isValid(String? value) {
    return value! == password;
  }
}
