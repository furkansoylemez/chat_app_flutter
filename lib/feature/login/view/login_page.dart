import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: MultiValidator([
                RequiredValidator(errorText: 'username is required'),
              ]),
            ),
            CustomSpacer.column(16.h),
            TextFormField(
              validator: MultiValidator([
                RequiredValidator(errorText: 'password is required'),
                MinLengthValidator(
                  6,
                  errorText: 'password must be at least 6 digits long',
                ),
              ]),
            ),
            CustomSpacer.column(20.h),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('valid');
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
