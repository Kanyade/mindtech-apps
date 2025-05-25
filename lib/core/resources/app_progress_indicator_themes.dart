part of 'app_resources.dart';

abstract final class AppProgressIndicatorThemes {
  static final defaultLinearIndicatorTheme = ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.gray75,
    linearMinHeight: AppDimensions.h8,
    borderRadius: BorderRadius.circular(AppDimensions.r4),
    circularTrackColor: AppColors.gray75,
  );
}
