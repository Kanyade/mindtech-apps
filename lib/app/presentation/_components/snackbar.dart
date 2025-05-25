import 'package:flutter/material.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';

enum SnackbarType { error, success }

void showSnackbar<T>({
  required BuildContext context,
  required SnackbarType type,
  required String text,
  bool showCloseIcon = true,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: AppTextStyles.uiLabelSmall.copyWith(color: AppColors.white)),
      showCloseIcon: true,
      backgroundColor: switch (type) {
        SnackbarType.success => AppColors.success,
        SnackbarType.error => AppColors.warning,
      },
      behavior: behavior,
    ),
  );
}
