// ignore_for_file: go_usage, pop_usage
import 'dart:async';
import 'dart:convert';

import 'package:app_skeleton/core/router/router.dart';
import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  void popNavigate<T>([T? result]) => pop(result);
  void navigate(AppRoute route) =>
      goNamed(route.name, queryParameters: {AppRoute.QUERY_INPUT_KEY: jsonEncode(route.queryParameters)});

  void navigateToPath(AppRoute route) => go(route.name);

  Future<T?> navigatePush<T>(AppRoute<T> route) {
    final name = route.name;
    final queryParameters = {AppRoute.QUERY_INPUT_KEY: jsonEncode(route.queryParameters)};

    return pushNamed(name, queryParameters: queryParameters);
  }

  Future<void> navigatePushReplacement(AppRoute route) =>
      pushReplacementNamed(route.name, queryParameters: {AppRoute.QUERY_INPUT_KEY: jsonEncode(route.queryParameters)});
}
