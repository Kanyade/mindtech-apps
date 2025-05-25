import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/context_extension.dart';

class BaseScreen extends HookWidget {
  const BaseScreen({
    super.key,
    this.title,
    this.isRootScreen = false,
    required this.body,
    this.backgroundColor,
    this.backgroundDecoration,
    this.actions,
  });

  final String? title;
  final bool isRootScreen;
  final Widget body;
  final Color? backgroundColor;
  final BoxDecoration? backgroundDecoration;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final extractedBGColor = useMemoized(
      () => backgroundDecoration != null ? AppColors.transparent : backgroundColor ?? AppColors.background,
      [backgroundDecoration, backgroundColor],
    );

    return Stack(
      children: [
        if (backgroundDecoration != null) Positioned.fill(child: DecoratedBox(decoration: backgroundDecoration!)),
        Scaffold(
          backgroundColor: extractedBGColor,
          resizeToAvoidBottomInset: true,
          appBar: isRootScreen
              ? _GeneralAppbar(title: title ?? '', backroundColor: extractedBGColor)
              : _NavigatableAppBar(title: title ?? '', actions: actions, backgroundColor: extractedBGColor),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.h16, horizontal: AppDimensions.w24),
            child: body,
          ),
        ),
      ],
    );
  }
}

class _NavigatableAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _NavigatableAppBar({required this.title, this.actions, this.backgroundColor});

  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: IconButton(
        onPressed: context.popNavigate,
        padding: EdgeInsets.only(left: AppDimensions.w16),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      scrolledUnderElevation: 0,
      actions: actions,
      centerTitle: true,
      title: Text(title, style: AppTextStyles.bodySmall),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.h88);
}

class _GeneralAppbar extends StatelessWidget implements PreferredSizeWidget {
  const _GeneralAppbar({required this.title, required this.backroundColor});

  final String title;
  final Color backroundColor;

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.h104);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + AppDimensions.h32,
          bottom: AppDimensions.h48,
          left: AppDimensions.w24,
          right: AppDimensions.w24,
        ),
        child: Text(title, style: AppTextStyles.mobileHeadersHeaderMobile4),
      ),
    );
  }
}
