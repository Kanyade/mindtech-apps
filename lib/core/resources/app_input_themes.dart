part of 'app_resources.dart';

abstract final class AppInputThemes {
  //!
  //! InputTheme
  //!

  /// Used in [ThemeData]. This is the default theme for [TextField] so no need
  /// to access its style property directly, but it's possible.
  static final defaultInputTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.w8, vertical: AppDimensions.h8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.r4),
      borderSide: const BorderSide(color: AppColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.r4),
      borderSide: const BorderSide(color: AppColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.r4),
      borderSide: const BorderSide(color: AppColors.outline, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.r4),
      borderSide: const BorderSide(color: AppColors.warning),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.r4),
      borderSide: const BorderSide(color: AppColors.warning, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.r4),
      borderSide: const BorderSide(color: AppColors.gray85),
    ),
    errorStyle: AppTextStyles.smallPrint.copyWith(color: AppColors.warning),
    hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.gray40),
    labelStyle: AppTextStyles.smallPrintBold,
  );

  //!
  //! SelectionTheme
  //!

  /// Used in [ThemeData]. This is the default theme for text selections.
  static const defaultSelectionTheme = TextSelectionThemeData(
    cursorColor: AppColors.text,
    selectionColor: AppColors.primary030,
    selectionHandleColor: AppColors.primary,
  );
}
