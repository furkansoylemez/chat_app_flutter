import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/dialog_helper.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/core/validators.dart';
import 'package:birsu/feature/register/logic/register_notifier.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/form_fields/display_name_form_field.dart';
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

    final updateDisplayNameStatus = ref.watch(
      registerNotifierProvider.select((state) => state.updateDisplayNameStatus),
    );

    final password =
        ref.watch(registerNotifierProvider.select((state) => state.password));

    _listenRegisterNotifier(ref, context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              DisplayNameFormField(
                onChanged: (displayName) {
                  ref
                      .read(registerNotifierProvider.notifier)
                      .displayNameChanged(displayName);
                },
              ),
              CustomSpacer.column(16.h),
              EmailFormField(
                onChanged: (email) {
                  ref
                      .read(registerNotifierProvider.notifier)
                      .emailChanged(email);
                },
              ),
              CustomSpacer.column(16.h),
              PasswordFormField(
                labelText: context.loc.password,
                onChanged: (password) {
                  ref
                      .read(registerNotifierProvider.notifier)
                      .passwordChanged(password);
                },
              ),
              CustomSpacer.column(16.h),
              PasswordFormField(
                labelText: context.loc.passwordAgain,
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
                  if (registerStatus is AsyncLoading ||
                      updateDisplayNameStatus is AsyncLoading) {
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
      ).center,
    );
  }

  void _listenRegisterNotifier(
    WidgetRef ref,
    BuildContext context,
  ) {
    final dialogHelper = ref.watch(dialogHelperProvider);
    ref.listen(registerNotifierProvider, (prev, next) {
      dialogHelper
        ..onAsyncErrorShowDialog(
          context,
          prev?.registerStatus,
          next.registerStatus,
        )
        ..onAsyncErrorShowDialog(
          context,
          prev?.updateDisplayNameStatus,
          next.updateDisplayNameStatus,
        );

      onAsyncSuccess(prev?.registerStatus, next.registerStatus, () {
        final user = next.registerStatus.asData?.value?.user;
        if (user != null) {
          ref.read(registerNotifierProvider.notifier).updateDisplayName(user);
        }
      });

      onAsyncSuccess(
          prev?.updateDisplayNameStatus, next.updateDisplayNameStatus, () {
        context.router
            .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
      });
    });
  }
}
