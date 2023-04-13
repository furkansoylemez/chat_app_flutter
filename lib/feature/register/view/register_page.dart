import 'package:auto_route/auto_route.dart';
import 'package:birsu/core/app_router/app_router.dart';
import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/core/extension/widget_extensions.dart';
import 'package:birsu/core/helper/dialog_helper.dart';
import 'package:birsu/core/helper/other_helpers.dart';
import 'package:birsu/core/resource/resources.dart';
import 'package:birsu/core/validators.dart';
import 'package:birsu/feature/register/logic/register_notifier.dart';
import 'package:birsu/feature/register/logic/register_state.dart';
import 'package:birsu/widgets/common_lottie.dart';
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

    final password =
        ref.watch(registerNotifierProvider.select((state) => state.password));

    final dialogHelper = ref.watch(dialogHelperProvider);

    ref.listen(registerNotifierProvider, (prev, next) {
      _showDialogOnRegisterError(prev, next, dialogHelper, context);
      _navigateOnRegisterSuccess(prev, next, context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.register),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              const CommonLottie(AppLotties.ltMediatingRabbit),
              DisplayNameFormField(
                onChanged: ref
                    .read(registerNotifierProvider.notifier)
                    .displayNameChanged,
              ),
              CustomSpacer.column(16.h),
              EmailFormField(
                onChanged:
                    ref.read(registerNotifierProvider.notifier).emailChanged,
              ),
              CustomSpacer.column(16.h),
              PasswordFormField(
                labelText: context.loc.password,
                onChanged:
                    ref.read(registerNotifierProvider.notifier).passwordChanged,
              ),
              CustomSpacer.column(16.h),
              PasswordFormField(
                labelText: context.loc.passwordAgain,
                onChanged: ref
                    .read(registerNotifierProvider.notifier)
                    .confirmPasswordChanged,
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
                      child: FilledButton(
                        onPressed: () {
                          _onRegisterButtonPressed(ref);
                        },
                        child: Text(
                          context.loc.register,
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
              CustomSpacer.column(50.h),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ).center,
    );
  }

  void _onRegisterButtonPressed(WidgetRef ref) {
    if (isFormValid(_formKey)) {
      ref.read(registerNotifierProvider.notifier).register();
    }
  }

  void _showDialogOnRegisterError(
    RegisterState? prev,
    RegisterState next,
    DialogHelper dialogHelper,
    BuildContext context,
  ) {
    if (prev?.registerStatus != next.registerStatus &&
        next.registerStatus is AsyncError &&
        next.registerStatus.hasError) {
      dialogHelper.showErrorDialog(context, next.registerStatus.error);
    }
  }

  void _navigateOnRegisterSuccess(
    RegisterState? prev,
    RegisterState next,
    BuildContext context,
  ) {
    if (prev?.registerStatus != next.registerStatus &&
        next.registerStatus is AsyncData &&
        (next.registerStatus.value ?? false)) {
      _navigateToConversationsPage(context);
    }
  }

  void _navigateToConversationsPage(BuildContext context) {
    context.router.pushAndPopUntil(
      const ConversationsRoute(),
      predicate: (_) => false,
    );
  }
}
