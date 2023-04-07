import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/form_validate_helper.dart';
import 'package:birsu/core/helper/toast_helper.dart';
import 'package:birsu/feature/login/logic/login_notifier.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/form_fields/email_form_field.dart';
import 'package:birsu/widgets/form_fields/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus = ref.watch(
      loginNotifierProvider.select((state) => state.loginStatus),
    );

    final toastHelper = ref.watch(toastHelperProvider);

    ref.listen(
      loginNotifierProvider,
      (_, state) {
        if (state.loginStatus is AsyncError && state.loginStatus.hasError) {
          toastHelper.showSnackBar(context, state.loginStatus.error.toString());
        }
      },
    );
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailFormField(
              onChanged: (email) {
                ref.read(loginNotifierProvider.notifier).emailChanged(email);
              },
            ),
            CustomSpacer.column(16.h),
            PasswordFormField(
              onChanged: (password) {
                ref
                    .read(loginNotifierProvider.notifier)
                    .passwordChanged(password);
              },
            ),
            CustomSpacer.column(20.h),
            Builder(
              builder: (context) {
                if (loginStatus is AsyncLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isFormValid(_formKey)) {
                          ref.read(loginNotifierProvider.notifier).login();
                        }
                      },
                      child: Text(context.loc.login),
                    ),
                  );
                }
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
