import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/dialog_helper.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/feature/login/logic/login_notifier.dart';
import 'package:birsu/feature/login/logic/login_state.dart';
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
    final dialogHelper = ref.watch(dialogHelperProvider);

    final loginStatus = ref.watch(
      loginNotifierProvider.select((state) => state.loginStatus),
    );

    ref.listen(loginNotifierProvider, (prev, next) {
      _showDialogOnLoginError(prev, next, dialogHelper, context);
      _navigateOnLoginSuccess(prev, next, context);
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Text(
                context.loc.loginHeader1,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              CustomSpacer.column(20.h),
              Text(
                context.loc.loginHeader2,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              CustomSpacer.column(20.h),
              EmailFormField(
                onChanged:
                    ref.read(loginNotifierProvider.notifier).emailChanged,
              ),
              CustomSpacer.column(16.h),
              PasswordFormField(
                labelText: context.loc.password,
                onChanged:
                    ref.read(loginNotifierProvider.notifier).passwordChanged,
              ),
              CustomSpacer.column(20.h),
              Builder(
                builder: (context) {
                  if (loginStatus is AsyncLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return SizedBox(
                      width: double.maxFinite,
                      child: FilledButton(
                        onPressed: () {
                          if (isFormValid(_formKey)) {
                            ref.read(loginNotifierProvider.notifier).login();
                          }
                        },
                        child: Text(
                          context.loc.login,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.loc.dontHaveAnAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(RegisterRoute());
                    },
                    child: Text(
                      context.loc.register,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(vertical: 30.h, horizontal: 20.w),
        ).paddingSymmetric(horizontal: 10.w),
      ).center,
    );
  }

  void _showDialogOnLoginError(
    LoginState? prev,
    LoginState next,
    DialogHelper dialogHelper,
    BuildContext context,
  ) {
    if (prev?.loginStatus != next.loginStatus &&
        next.loginStatus is AsyncError &&
        next.loginStatus.hasError) {
      dialogHelper.showErrorDialog(context, next.loginStatus.error);
    }
  }

  void _navigateOnLoginSuccess(
    LoginState? prev,
    LoginState next,
    BuildContext context,
  ) {
    if (prev?.loginStatus != next.loginStatus &&
        next.loginStatus is AsyncData &&
        (next.loginStatus.value ?? false)) {
      _navigateToConversationsPage(context);
    }
  }

  void _navigateToConversationsPage(BuildContext context) {
    context.router.replace(const ConversationsRoute());
  }
}
