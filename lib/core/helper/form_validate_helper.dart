import 'package:flutter/material.dart';

bool isFormValid(GlobalKey<FormState> formKey) =>
    (formKey.currentState?.validate() ?? false) == true;
