import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.onRetry,
    required this.errorMessage,
  });

  final void Function() onRetry;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        CustomSpacer.column(8.h),
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: Text(context.loc.tryAgain),
        ),
      ],
    );
  }
}
