part of 'app_resources.dart';

abstract class AppTheme {
  static const mainFontFamily = FontFamily.jost;

  static const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarDividerColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: false,
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemStatusBarContrastEnforced: false,
  );

  static double calcLineHeight({required double lineHeight, required double fontSize}) => lineHeight / fontSize;

  static ThemeData get defaultTheme {
    return ThemeData(
      fontFamily: mainFontFamily,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, primary: AppColors.primary),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        shadowColor: AppColors.background,
        foregroundColor: AppColors.text,
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        width: double.infinity,
        clipBehavior: Clip.none,
        backgroundColor: AppColors.background,
        shadowColor: AppColors.transparent,
      ),
      inputDecorationTheme: AppInputThemes.defaultInputTheme,
      textSelectionTheme: AppInputThemes.defaultSelectionTheme,
      filledButtonTheme: AppButtonThemes.defaultFilledButtonTheme,
      textButtonTheme: AppButtonThemes.defaultTextButton,
      outlinedButtonTheme: AppButtonThemes.defaultOutlinedButtonTheme,
      dropdownMenuTheme: AppDropdownThemes.defaultDropdownMenu,
      menuTheme: AppDropdownThemes.defaultMenuTheme,
      menuButtonTheme: AppDropdownThemes.defaultMenuButtonTheme,
      splashColor: AppColors.transparent,
      tabBarTheme: TabBarThemeData(
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        labelStyle: AppTextStyles.uiLabelBold,
        unselectedLabelStyle: AppTextStyles.uiLabel,
        splashFactory: NoSplash.splashFactory,
      ),
      secondaryHeaderColor: AppColors.primary,
      primaryTextTheme: TextTheme(
        labelSmall: AppTextStyles.uiLabelSmall,
        labelMedium: AppTextStyles.uiLabel,
        labelLarge: AppTextStyles.uiLabelLarge,
        bodySmall: AppTextStyles.bodySmall,
        bodyMedium: AppTextStyles.bodyBook,
        bodyLarge: AppTextStyles.bodyBook,
        titleSmall: AppTextStyles.mobileTitlesTitleMobile3,
        titleMedium: AppTextStyles.mobileTitlesTitleMobile2,
        titleLarge: AppTextStyles.mobileTitlesTitleMobile1,
        headlineSmall: AppTextStyles.mobileHeadersHeaderMobile5,
        headlineMedium: AppTextStyles.mobileHeadersHeaderMobile3,
        headlineLarge: AppTextStyles.mobileHeadersHeaderMobile1,
        displaySmall: AppTextStyles.mobileDisplayDisplayMobileCaps,
        displayMedium: AppTextStyles.mobileDisplayDisplayMobile2,
        displayLarge: AppTextStyles.mobileDisplayDisplayMobile1,
      ).apply(displayColor: AppColors.text, bodyColor: AppColors.text),
      progressIndicatorTheme: AppProgressIndicatorThemes.defaultLinearIndicatorTheme,
    );
  }

  // Font weights
  static const FontWeight FONTWEIGHT_THIN = FontWeight.w100;
  static const FontWeight FONTWEIGHT_EXTRA_LIGHT = FontWeight.w200;
  static const FontWeight FONTWEIGHT_LIGHT = FontWeight.w300;
  static const FontWeight FONTWEIGHT_REGULAR = FontWeight.w400;
  static const FontWeight FONTWEIGHT_MEDIUM = FontWeight.w500;
  static const FontWeight FONTWEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight FONTWEIGHT_BOLD = FontWeight.w700;
  static const FontWeight FONTWEIGHT_EXTRA_BOLD = FontWeight.w800;
  static const FontWeight FONTWEIGHT_BLACK = FontWeight.w900;
}
