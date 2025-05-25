part of 'app_resources.dart';

abstract final class AppColors {
  // Core colors
  static const Color inkBlack = Color(0xff191919);
  static const Color white = Color(0xffFFFFFF);
  static const Color transparent = Color(0x00000000);
  static const Color transparentWhite = Color(0x00ffffff);
  static const Color background = Color(0xffF3F4F6);
  static const Color primary = Color(0xff2563EB);

  /// 30% opacity
  static const Color primary030 = Color(0x77009eeb);

  // Grays
  static const Color gray40 = Color(0xff666666);
  static const Color gray45 = Color(0xff737373);
  static const Color gray55 = Color(0xff8c8c8c);
  static const Color gray65 = Color(0xffA6A6A6);
  static const Color gray75 = Color(0xffbfbfbf);
  static const Color gray80 = Color(0xffd9d9d9);
  static const Color gray85 = Color(0xffdadada);
  static const Color gray95 = Color(0xfff2f2f2);

  // Text colors
  static const Color text = Color(0xff374151);
  static const Color textSecondary = Color(0xff4b5563);
  static const Color textDisabled = Color(0x80191919);
  static const Color textLight = Color(0xffffffff);

  // Outline
  static const Color outline = Color(0xff8c8c8c);
  static const Color outlineHover = Color(0xff191919);
  static const Color outlineOnDark = Color(0xffbfbfbf);

  // Alert
  static const Color success = Color(0xff16A34A);
  static const Color warning = Color(0xffDC2626);

  // Shadows
  static const Color surfacesSurfaceShadowEnabled = Color.fromRGBO(25, 25, 25, 0.15);
}

extension ColorFilterColorExt on Color {
  ColorFilter get asColorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}
