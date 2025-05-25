// ignore_for_file: screenutil_usage
part of 'app_resources.dart';

abstract final class AppDimensions {
  AppDimensions._();

  static const UI_DESIGN_SIZE_WIDTH = 400.0;
  static const UI_DESIGN_SIZE_HEIGHT = 850.0;

  static final screenWidth = ScreenUtil().screenWidth;
  static final screenHeight = ScreenUtil().screenHeight;

  static final h2 = ScreenUtil().setHeight(2);
  static final h4 = ScreenUtil().setHeight(4);
  static final h8 = ScreenUtil().setHeight(8);
  static final h12 = ScreenUtil().setHeight(12);
  static final h16 = ScreenUtil().setHeight(16);
  static final h24 = ScreenUtil().setHeight(24);
  static final h32 = ScreenUtil().setHeight(32);
  static final h40 = ScreenUtil().setHeight(40);
  static final h48 = ScreenUtil().setHeight(48);
  static final h56 = ScreenUtil().setHeight(56);
  static final h80 = ScreenUtil().setHeight(80);
  static final h88 = ScreenUtil().setHeight(88);
  static final h104 = ScreenUtil().setHeight(104);

  static final w2 = ScreenUtil().setWidth(2);
  static final w4 = ScreenUtil().setWidth(4);
  static final w8 = ScreenUtil().setWidth(8);
  static final w12 = ScreenUtil().setWidth(12);
  static final w16 = ScreenUtil().setWidth(16);
  static final w24 = ScreenUtil().setWidth(24);
  static final w32 = ScreenUtil().setWidth(32);
  static final w40 = ScreenUtil().setWidth(40);
  static final w48 = ScreenUtil().setWidth(48);
  static final w56 = ScreenUtil().setWidth(56);

  static final r2 = ScreenUtil().radius(2);
  static final r4 = ScreenUtil().radius(4);
  static final r8 = ScreenUtil().radius(8);
  static final r12 = ScreenUtil().radius(12);
  static final r16 = ScreenUtil().radius(16);
  static final r24 = ScreenUtil().radius(24);
  static final r32 = ScreenUtil().radius(32);
  static final r120 = ScreenUtil().radius(120);
  static final r9999 = ScreenUtil().radius(9999);

  static final f12 = ScreenUtil().setSp(12);
  static final f14 = ScreenUtil().setSp(14);
  static final f16 = ScreenUtil().setSp(16);
  static final f18 = ScreenUtil().setSp(18);
  static final f20 = ScreenUtil().setSp(20);
  static final f24 = ScreenUtil().setSp(24);
  static final f32 = ScreenUtil().setSp(32);
  static final f40 = ScreenUtil().setSp(40);
  static final f48 = ScreenUtil().setSp(48);
  static final f56 = ScreenUtil().setSp(56);
  static final f64 = ScreenUtil().setSp(64);
  static final f72 = ScreenUtil().setSp(72);
  static final f80 = ScreenUtil().setSp(80);
}
