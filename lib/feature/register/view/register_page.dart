import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/dialog_helper.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/core/validators.dart';
import 'package:birsu/feature/register/logic/register_notifier.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/form_fields/email_form_field.dart';
import 'package:birsu/widgets/form_fields/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerStatus = ref.watch(
      registerNotifierProvider.select((state) => state.registerStatus),
    );

    final password =
        ref.watch(registerNotifierProvider.select((state) => state.password));

    final dialogHelper = ref.watch(dialogHelperProvider);

    ref.listen(registerNotifierProvider, (prev, next) {
      dialogHelper.onAsyncErrorShowDialog(
        context,
        prev?.registerStatus,
        next.registerStatus,
      );
      print(next.registerStatus);
      onAsyncSuccess(next.registerStatus, () {
        context.router
            .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
      });
    });
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailFormField(
              onChanged: (email) {
                ref.read(registerNotifierProvider.notifier).emailChanged(email);
              },
            ),
            CustomSpacer.column(16.h),
            PasswordFormField(
              onChanged: (password) {
                ref
                    .read(registerNotifierProvider.notifier)
                    .passwordChanged(password);
              },
            ),
            CustomSpacer.column(16.h),
            PasswordFormField(
              onChanged: (confirmPassword) {
                ref
                    .read(registerNotifierProvider.notifier)
                    .confirmPasswordChanged(confirmPassword);
              },
              validators: [
                PasswordMatchValidator(
                  password,
                  errorText: context.loc.passwordsDoNotMatchError,
                )
              ],
            ),
            CustomSpacer.column(20.h),
            Builder(
              builder: (context) {
                if (registerStatus is AsyncLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isFormValid(_formKey)) {
                          ref
                              .read(registerNotifierProvider.notifier)
                              .register();
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