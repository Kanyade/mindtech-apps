import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:flutter/material.dart';

enum SnackbarType { error, attention, success }

void showSnackbar<T>({
  required BuildContext context,
  required SnackbarType type,
  required String text,
  bool showCloseIcon = true,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: AppTextStyles.uiLabelSmall),
      showCloseIcon: true,
      backgroundColor: switch (type) {
        SnackbarType.success => AppColors.success,
        SnackbarType.error => AppColors.warning,
        SnackbarType.attention => AppColors.attention,
      },
      behavior: behavior,
    ),
  );
}
