part of 'app_resources.dart';

abstract final class AppDropdownThemes {
  //!
  //! MenuButtonTheme
  //!

  /// Used in [ThemeData]. This is the default theme for [MenuTheme] so no need
  /// to access its style property directly, but it's possible.
  static final defaultMenuButtonTheme = MenuButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: AppDimensions.w16, vertical: AppDimensions.h8),
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.gray65;

        return AppColors.text;
      }),
      backgroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) return AppColors.primary030;

        return AppColors.transparent;
      }),
      iconColor: const WidgetStatePropertyAll<Color>(AppColors.text),
      overlayColor: const WidgetStatePropertyAll<Color>(AppColors.primary030),
      textStyle: WidgetStatePropertyAll<TextStyle>(AppTextStyles.uiLabelSmall),
    ),
  );

  //!
  //! MenuTheme
  //!

  /// Used in [ThemeData]. This is the default theme for [MenuTheme] so no need
  /// to access its style property directly, but it's possible.
  static final defaultMenuTheme = MenuThemeData(
    style: MenuStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return const BorderSide(color: AppColors.gray65);

        return const BorderSide(color: AppColors.outline);
      }),
      surfaceTintColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.gray65;

        return AppColors.transparent;
      }),
      backgroundColor: const WidgetStatePropertyAll(AppColors.white),
      elevation: const WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.r4)),
      ),
    ),
  );

  //!
  //! DropdownMenu
  //!

  /// Used in [ThemeData]. This is the default theme for [DropdownMenu] so no need
  /// to access its style property directly, but it's possible.
  static final defaultDropdownMenu = DropdownMenuThemeData(
    textStyle: AppInputThemes.defaultInputTheme.hintStyle?.copyWith(color: AppColors.text),
    menuStyle: defaultMenuTheme.style,
    inputDecorationTheme: AppInputThemes.defaultInputTheme,
  );
}
