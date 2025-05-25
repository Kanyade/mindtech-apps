import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';

class AppButton extends HookWidget {
  const AppButton.filled({
    super.key,
    required this.onPressed,
    required Widget this.label,
    this.icon,
    IconAlignment this.iconAlignment = IconAlignment.start,
    this.paddingStyle = ButtonPaddingStyle.compact,
    this.enableIconColorFiltering = true,
    this.isMono = false,
    this.isFullWidth = false,
    FilledButtonVariant? this.variant,
  }) : type = ButtonType.filled;

  const AppButton.outlined({
    super.key,
    required this.onPressed,
    required Widget this.label,
    this.icon,
    IconAlignment this.iconAlignment = IconAlignment.start,
    this.paddingStyle = ButtonPaddingStyle.compact,
    this.enableIconColorFiltering = true,
    this.isMono = true,
    this.isFullWidth = false,
    OutlinedButtonVariant? this.variant,
  }) : type = ButtonType.outlined;

  const AppButton.text({
    super.key,
    required this.onPressed,
    required Widget this.label,
    this.icon,
    IconAlignment this.iconAlignment = IconAlignment.start,
    this.paddingStyle = ButtonPaddingStyle.compact,
    this.enableIconColorFiltering = true,
    this.isMono = false,
    this.isFullWidth = false,
    TextButtonVariant? this.variant,
  }) : type = ButtonType.text;

  const AppButton.icon({
    super.key,
    required this.onPressed,
    required Widget this.icon,
    this.paddingStyle = ButtonPaddingStyle.compact,
    this.enableIconColorFiltering = true,
    this.isMono = false,
    this.isFullWidth = false,
    FilledIconButtonVariant? this.variant,
  }) : label = null,
       iconAlignment = null,
       type = ButtonType.icon;

  const AppButton.iconOutlined({
    super.key,
    required this.onPressed,
    required Widget this.icon,
    this.paddingStyle = ButtonPaddingStyle.compact,
    this.enableIconColorFiltering = true,
    this.isMono = false,
    this.isFullWidth = false,
    OutlinedIconButtonVariant? this.variant,
  }) : label = null,
       iconAlignment = null,
       type = ButtonType.iconOutlined;

  final VoidCallback? onPressed;
  final Widget? label;
  final Widget? icon;
  final IconAlignment? iconAlignment;
  final ButtonPaddingStyle paddingStyle;
  final bool enableIconColorFiltering;
  final bool isMono;
  final bool isFullWidth;
  final ButtonType type;
  final dynamic variant;

  @override
  Widget build(BuildContext context) {
    final finalStyle = useMemoized(() {
      final baseStyle = switch (type) {
        ButtonType.filled => AppButtonThemes.defaultFilledButtonTheme.style,
        ButtonType.outlined => AppButtonThemes.defaultOutlinedButtonTheme.style,
        ButtonType.text => AppButtonThemes.defaultTextButton.style,
        ButtonType.icon => AppButtonThemes.defaultIconButton.style,
        ButtonType.iconOutlined => AppButtonThemes.defaultOutlinedIconButton,
      }!;

      final colorSchemeButtonStyle = switch ((isMono, type, variant)) {
        (true, ButtonType.icon || ButtonType.filled, _) => AppButtonVariants.monoFilledOverride,
        (true, ButtonType.iconOutlined || ButtonType.outlined, _) => AppButtonVariants.monoOutlinedOverride,
        (true, ButtonType.text, _) => AppButtonVariants.monoTextOverride,
        (false, _, _) => null,
      };

      final paddingButtonStyle = switch (paddingStyle) {
        ButtonPaddingStyle.zero => AppButtonPaddingThemes.zeroPaddingButtonStyle,
        ButtonPaddingStyle.compact => AppButtonPaddingThemes.compactButtonStyle,
        ButtonPaddingStyle.spacious => AppButtonPaddingThemes.spaciousButtonStyle,
      };

      final sizeButtonStyle = isFullWidth ? AppSizeThemes.fullWidthStyle : null;

      final variantButtonStyle = switch ((type, variant)) {
        (ButtonType.outlined, OutlinedButtonVariant.red) => AppButtonVariants.redOutlinedOverride,
        (ButtonType.outlined, OutlinedButtonVariant.gray) => AppButtonVariants.grayOutlinedOverride,
        (ButtonType.text, TextButtonVariant.gray) => AppButtonVariants.grayTextOverride,
        (ButtonType.text, TextButtonVariant.red) => AppButtonVariants.redTextOverride,
        (ButtonType.filled, FilledButtonVariant.white) => AppButtonVariants.whiteFilledOverride,
        (ButtonType.icon, FilledIconButtonVariant.transparentBlack) => AppButtonVariants.transparentFilledBlackOverride,
        (ButtonType.iconOutlined, OutlinedIconButtonVariant.gray) => AppButtonVariants.grayOutlinedOverride,
        (_, _) => null,
      };

      final styles = [
        sizeButtonStyle,
        variantButtonStyle,
        paddingButtonStyle,
        colorSchemeButtonStyle,
        baseStyle,
      ].nonNulls;
      return styles.fold(styles.first, (current, next) => current.merge(next));
    }, [paddingStyle, isMono, type, variant, isFullWidth]);

    final colorFilteredIcon = useMemoized(() {
      if (!enableIconColorFiltering || icon is! SvgPicture) return icon;

      return Builder(
        builder: (context) {
          final color = IconTheme.of(context).color;
          if (color == null) return icon!;

          return ColorFiltered(colorFilter: ColorFilter.mode(color, BlendMode.srcIn), child: icon);
        },
      );
    }, [enableIconColorFiltering, icon?.key]);

    return DefaultTextHeightBehavior(
      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
      child: switch (type) {
        ButtonType.filled => FilledButton.icon(
          onPressed: onPressed,
          label: label!,
          icon: colorFilteredIcon,
          iconAlignment: iconAlignment!,
          style: finalStyle,
        ),
        ButtonType.outlined => OutlinedButton.icon(
          onPressed: onPressed,
          label: label!,
          icon: colorFilteredIcon,
          iconAlignment: iconAlignment!,
          style: finalStyle,
        ),
        ButtonType.text => TextButton.icon(
          onPressed: onPressed,
          label: label!,
          icon: colorFilteredIcon,
          iconAlignment: iconAlignment!,
          style: finalStyle,
        ),
        ButtonType.icon => IconButton.filled(onPressed: onPressed, icon: colorFilteredIcon!, style: finalStyle),
        ButtonType.iconOutlined => IconButton.outlined(
          onPressed: onPressed,
          icon: colorFilteredIcon!,
          style: finalStyle,
        ),
      },
    );
  }
}
