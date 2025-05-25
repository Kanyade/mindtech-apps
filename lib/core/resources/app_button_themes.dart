part of 'app_resources.dart';

enum ButtonPaddingStyle { zero, compact, spacious }

enum ButtonType { outlined, filled, text, icon, iconOutlined }

enum FilledButtonVariant { white }

enum OutlinedButtonVariant { red, gray }

enum TextButtonVariant { gray, red }

enum FilledIconButtonVariant { transparentBlack }

enum OutlinedIconButtonVariant { gray }

//!
//! Size Styles
//!
abstract final class AppSizeThemes {
  static const fullWidthStyle = ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(double.infinity, 0)));
}

//!
//! Padding Styles
//!
abstract final class AppButtonPaddingThemes {
  static const zeroPaddingButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
  );
  static final compactButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: AppDimensions.w16, vertical: AppDimensions.h8),
    ),
  );
  static final spaciousButtonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: AppDimensions.w24, vertical: AppDimensions.h12),
    ),
  );
}

//!
//! Fill Styles
//!
abstract final class _AppButtonFillThemes {
  static final filledStyle = ButtonStyle(
    side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
      if (states.contains(WidgetState.disabled)) return const BorderSide(color: AppColors.gray65);

      return const BorderSide(color: AppColors.primary);
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray85;

      return AppColors.white;
    }),
    iconColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray85;

      return AppColors.white;
    }),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray55;

      return AppColors.primary;
    }),
  );

  static final outlinedStyle = ButtonStyle(
    side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
      if (states.contains(WidgetState.disabled)) return const BorderSide(color: AppColors.gray55);

      return const BorderSide(color: AppColors.primary);
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray55;

      return AppColors.primary;
    }),
    iconColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray55;

      return AppColors.primary;
    }),
    backgroundColor: const WidgetStatePropertyAll(AppColors.transparent),
  );

  static final textButtonStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray55;

      return AppColors.primary;
    }),
    iconColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) return AppColors.gray55;

      return AppColors.primary;
    }),
  );
}

//!
//! Shape Styles
//!
abstract final class _AppButtonShapeThemes {
  static const iconStyle = ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder()));
  static final standardStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.r24))),
  );
}

//!
//! Main Button Themes
//!
abstract final class AppButtonThemes {
  static final _buttonTextStyle = WidgetStatePropertyAll(AppTextStyles.uiLabelSmall);
  static const _minimumSize = WidgetStatePropertyAll(Size.zero);

  static final defaultIconButton = IconButtonThemeData(
    style: ButtonStyle(
      padding: AppButtonPaddingThemes.compactButtonStyle.padding,
      shape: _AppButtonShapeThemes.iconStyle.shape,
      side: _AppButtonFillThemes.filledStyle.side,
      foregroundColor: _AppButtonFillThemes.filledStyle.foregroundColor,
      backgroundColor: _AppButtonFillThemes.filledStyle.backgroundColor,
      iconColor: _AppButtonFillThemes.filledStyle.iconColor,
      textStyle: _buttonTextStyle,
      minimumSize: _minimumSize,
    ),
  );

  static final defaultOutlinedIconButton = ButtonStyle(
    padding: AppButtonPaddingThemes.compactButtonStyle.padding,
    shape: _AppButtonShapeThemes.iconStyle.shape,
    side: _AppButtonFillThemes.outlinedStyle.side,
    foregroundColor: _AppButtonFillThemes.outlinedStyle.foregroundColor,
    backgroundColor: _AppButtonFillThemes.outlinedStyle.backgroundColor,
    iconColor: _AppButtonFillThemes.outlinedStyle.iconColor,
    textStyle: _buttonTextStyle,
    minimumSize: _minimumSize,
  );

  static final defaultTextButton = TextButtonThemeData(
    style: ButtonStyle(
      padding: AppButtonPaddingThemes.compactButtonStyle.padding,
      shape: _AppButtonShapeThemes.standardStyle.shape,
      foregroundColor: _AppButtonFillThemes.textButtonStyle.foregroundColor,
      iconColor: _AppButtonFillThemes.textButtonStyle.iconColor,
      textStyle: _buttonTextStyle,
      minimumSize: _minimumSize,
    ),
  );

  static final defaultFilledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      padding: AppButtonPaddingThemes.compactButtonStyle.padding,
      shape: _AppButtonShapeThemes.standardStyle.shape,
      side: _AppButtonFillThemes.filledStyle.side,
      foregroundColor: _AppButtonFillThemes.filledStyle.foregroundColor,
      backgroundColor: _AppButtonFillThemes.filledStyle.backgroundColor,
      iconColor: _AppButtonFillThemes.filledStyle.iconColor,
      textStyle: _buttonTextStyle,
      minimumSize: _minimumSize,
    ),
  );

  static final defaultOutlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: AppButtonPaddingThemes.compactButtonStyle.padding,
      shape: _AppButtonShapeThemes.standardStyle.shape,
      side: _AppButtonFillThemes.outlinedStyle.side,
      foregroundColor: _AppButtonFillThemes.outlinedStyle.foregroundColor,
      iconColor: _AppButtonFillThemes.outlinedStyle.iconColor,
      textStyle: _buttonTextStyle,
      minimumSize: _minimumSize,
    ),
  );
}

abstract final class AppButtonVariants {
  static final monoFilledOverride = _buildFilledVariant(AppColors.text, AppColors.white);
  static final whiteFilledOverride = _buildFilledVariant(AppColors.white, AppColors.text);
  static final transparentFilledBlackOverride = _buildFilledVariant(AppColors.transparent, AppColors.text);

  static final monoTextOverride = _buildTextVariant(AppColors.text);
  static final grayTextOverride = _buildTextVariant(AppColors.gray55);
  static final redTextOverride = _buildTextVariant(AppColors.warning);

  static final monoOutlinedOverride = _buildOutlinedVariant(AppColors.text);
  static final grayOutlinedOverride = _buildOutlinedVariant(AppColors.gray40);
  static final redOutlinedOverride = _buildOutlinedVariant(AppColors.warning);
}

ButtonStyle _buildFilledVariant(Color backgroundColor, Color foregroundColor) {
  return ButtonStyle(
    side: _getInheritedStyleProperty<BorderSide>(
      _AppButtonFillThemes.filledStyle.side!,
      value: BorderSide(color: backgroundColor),
    ),
    foregroundColor: _getInheritedStyleProperty<Color>(
      _AppButtonFillThemes.filledStyle.foregroundColor!,
      value: foregroundColor,
    ),
    iconColor: _getInheritedStyleProperty<Color>(_AppButtonFillThemes.filledStyle.iconColor!, value: foregroundColor),
    backgroundColor: _getInheritedStyleProperty<Color>(
      _AppButtonFillThemes.filledStyle.backgroundColor!,
      value: backgroundColor,
    ),
    overlayColor: WidgetStatePropertyAll(foregroundColor.withAlpha(64)),
  );
}

ButtonStyle _buildTextVariant(Color color) {
  return ButtonStyle(
    foregroundColor: _getInheritedStyleProperty<Color>(
      _AppButtonFillThemes.textButtonStyle.foregroundColor!,
      value: color,
    ),
    iconColor: _getInheritedStyleProperty<Color>(_AppButtonFillThemes.textButtonStyle.iconColor!, value: color),
    overlayColor: WidgetStatePropertyAll(color.withAlpha(64)),
  );
}

ButtonStyle _buildOutlinedVariant(Color color) {
  return ButtonStyle(
    side: _getInheritedStyleProperty<BorderSide>(
      _AppButtonFillThemes.outlinedStyle.side!,
      value: BorderSide(color: color),
    ),
    foregroundColor: _getInheritedStyleProperty<Color>(
      _AppButtonFillThemes.outlinedStyle.foregroundColor!,
      value: color,
    ),
    iconColor: _getInheritedStyleProperty<Color>(_AppButtonFillThemes.outlinedStyle.iconColor!, value: color),
    overlayColor: WidgetStatePropertyAll(color.withAlpha(64)),
  );
}

WidgetStateProperty<T?>? _getInheritedStyleProperty<T>(
  WidgetStateProperty<T?> defaultProperty, {
  Set<WidgetState> inheritedStates = const {WidgetState.disabled},
  required T value,
}) {
  return WidgetStateProperty.resolveWith<T?>((states) {
    if (inheritedStates.any(states.contains)) return defaultProperty.resolve(states);
    return value;
  });
}
