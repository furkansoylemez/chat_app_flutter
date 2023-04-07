import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool isFormValid(GlobalKey<FormState> formKey) =>
    (formKey.currentState?.validate() ?? false) == true;

void onAsyncSuccess(
  AsyncValue<dynamic> nextAsync,
  void Function() onSuccess,
) {
  if (nextAsync is AsyncData && nextAsync.asData?.value != null) {
    onSuccess.call();
  }
}
