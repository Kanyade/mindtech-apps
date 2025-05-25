import 'dart:async';

import 'package:app_skeleton/core/resources/app_resources.dart';
import 'package:app_skeleton/core/router/router.dart';
import 'package:app_skeleton/core/services/analytics/repository.dart';
import 'package:app_skeleton/core/utils/logger.dart';
import 'package:app_skeleton/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';

class AppSkeleton extends HookWidget {
  const AppSkeleton({super.key, required AppSkeletonRouter router}) : _router = router;

  final AppSkeletonRouter _router;

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
        AppSkeletonLogger.logInfo('AppLifecycleState.inactive');
        unawaited(analyticsRepository.logEvent(eventName: 'app_visible_but_inactive'));

      case AppLifecycleState.resumed:
        AppSkeletonLogger.logInfo('AppLifecycleState.resumed');
        unawaited(analyticsRepository.logEvent(eventName: 'app_resumed_to_fg'));

      case AppLifecycleState.paused:
        AppSkeletonLogger.logInfo('AppLifecycleState.paused');
        unawaited(analyticsRepository.logEvent(eventName: 'app_paused_in_bg'));

      case AppLifecycleState.detached:
        AppSkeletonLogger.logInfo('AppLifecycleState.detached');
        unawaited(analyticsRepository.logEvent(eventName: 'app_closed'));

      case AppLifecycleState.hidden:
        AppSkeletonLogger.logInfo('AppLifecycleState.hidden');
    }
  }
}

class _CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(_, Widget child, _) => child;
}
