import 'dart:async';

import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/router/router.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';
import 'package:io_mindtechapps_hw/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';

class MindtechApp extends HookWidget {
  const MindtechApp({super.key, required MindtechAppRouter router}) : _router = router;

  final MindtechAppRouter _router;

  @override
  Widget build(BuildContext context) {
    final analyticsRepository = context.read<AnalyticsRepository>();

    useEffect(() => logAppStartRemoveSplash(analyticsRepository), const []);
    useOnAppLifecycleStateChange((_, currentState) => logLifecycleChanges(currentState, analyticsRepository));

    return AnnotatedRegion(
      value: AppTheme.systemUiOverlayStyle,
      child: ScreenUtilInit(
        ensureScreenSize: true,
        designSize: const Size(AppDimensions.UI_DESIGN_SIZE_WIDTH, AppDimensions.UI_DESIGN_SIZE_HEIGHT),
        minTextAdapt: true,
        fontSizeResolver: FontSizeResolvers.radius,
        builder: (context, _) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: MaterialApp.router(
            scrollBehavior: _CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) =>
                UpgradeAlert(navigatorKey: _router.router.routerDelegate.navigatorKey, child: child),
            title: 'App Skeleton',
            theme: AppTheme.defaultTheme,
            routerConfig: _router.router,
          ),
        ),
      ),
    );
  }

  Dispose? logAppStartRemoveSplash(AnalyticsRepository analyticsRepository) {
    AppInitializer.tryRemoveSplash();
    unawaited(analyticsRepository.logEvent(eventName: 'app_start'));
    return null;
  }

  void logLifecycleChanges(AppLifecycleState state, AnalyticsRepository analyticsRepository) {
    switch (state) {
      case AppLifecycleState.inactive:
        MindtechAppLogger.logInfo('AppLifecycleState.inactive');
        unawaited(analyticsRepository.logEvent(eventName: 'app_visible_but_inactive'));

      case AppLifecycleState.resumed:
        MindtechAppLogger.logInfo('AppLifecycleState.resumed');
        unawaited(analyticsRepository.logEvent(eventName: 'app_resumed_to_fg'));

      case AppLifecycleState.paused:
        MindtechAppLogger.logInfo('AppLifecycleState.paused');
        unawaited(analyticsRepository.logEvent(eventName: 'app_paused_in_bg'));

      case AppLifecycleState.detached:
        MindtechAppLogger.logInfo('AppLifecycleState.detached');
        unawaited(analyticsRepository.logEvent(eventName: 'app_closed'));

      case AppLifecycleState.hidden:
        MindtechAppLogger.logInfo('AppLifecycleState.hidden');
    }
  }
}

class _CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(_, Widget child, _) => child;
}
