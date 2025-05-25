import 'dart:async';

import 'package:io_mindtechapps_hw/core/router/router.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/go_router_extension.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.primaryTextTheme;

  bool canPop() => GoRouter.of(this).canPop();
  void popNavigate<T>([T? result]) => GoRouter.of(this).popNavigate(result);

  void navigate(AppRoute route) => GoRouter.of(this).navigate(route);
  void navigateToPath(AppRoute route) => GoRouter.of(this).navigateToPath(route);

  bool routeExists(String route) {
    try {
      final uri = Uri.parse(route);

      MindtechAppLogger.logWarning('ContextExtension.routeExists uri: $uri');

      return GoRouter.of(this).routeInformationParser.configuration.findMatch(uri).matches.isNotEmpty;
    } catch (err) {
      MindtechAppLogger.logError('ContextExtension.routeExists ${err.toString()}}');
      return false;
    }
  }

  Future<T?> navigatePush<T>(AppRoute<T> route) => GoRouter.of(this).navigatePush(route);
  Future<T?> navigatePushWithEvent<T>(AppRoute<T> route, {required String event, Map<String, Object?>? parameters}) {
    unawaited(read<AnalyticsRepository>().logEvent(eventName: event, parameters: parameters));
    return GoRouter.of(this).navigatePush(route);
  }

  void navigatePushReplacement(AppRoute route) => unawaited(GoRouter.of(this).navigatePushReplacement(route));

  void navigateWithEvent(AppRoute route, {required String event, Map<String, Object?>? parameters}) {
    unawaited(read<AnalyticsRepository>().logEvent(eventName: event, parameters: parameters));
    return GoRouter.of(this).navigate(route);
  }
}
