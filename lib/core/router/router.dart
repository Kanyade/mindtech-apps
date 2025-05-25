import 'dart:async';
import 'dart:convert';

import 'package:io_mindtechapps_hw/app/domain/profile/bloc/bloc.dart';
import 'package:io_mindtechapps_hw/app/domain/profile/repository.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/bottom_navigation_menu.dart';
import 'package:io_mindtechapps_hw/app/presentation/account/screen.dart';
import 'package:io_mindtechapps_hw/app/presentation/start/screen.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/single_child_widget.dart';

part 'navigator_keys.dart';
part 'routes.dart';
part 'routes_builder.dart';

enum BottomNavigationTab { start, account }

class MindtechAppRouter {
  final CrashlyticsRepository _crashlyticsRepository;
  final AnalyticsRepository _analyticsRepository;
  final UserProfileRepository _profileDetailsRepository;
  final RoutesBuilder _routeBuilders;

  late final GoRouter _router;
  GoRouter get router => _router;

  final List<BottomNavigationTab> _mainTabs;

  MindtechAppRouter(
    this._crashlyticsRepository,
    this._analyticsRepository,
    this._profileDetailsRepository,
    this._routeBuilders, [
    this._mainTabs = BottomNavigationTab.values,
  ]) {
    MindtechAppLogger.logSuccess('MindtechAppRouter: Starting...');

    _router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      observers: [_analyticsRepository.navigatorObserver],
      navigatorKey: MindtechAppNavigatorKeys.navigationKey,
      initialLocation: Routes.start,
      onException: (context, state, router) {
        final e = 'MindtechAppRouter: route not found ${state.uri.toString()}';
        if (AppConstants.flavor == AppFlavor.prod) {
          unawaited(_crashlyticsRepository.recordError(exception: e, stackTrace: StackTrace.current));
        } else {
          MindtechAppLogger.logError(e);
        }
      },
      routes: <RouteBase>[
        GoRoute(name: Routes.loading, path: Routes.loading, builder: _routeBuilders.loadingScreenBuilder),
        StatefulShellRoute.indexedStack(
          builder: (_, _, navigationShell) {
            return AnnotatedRegion(
              value: AppTheme.authenticatedSystemUiOverlayStyle,
              child: BlocProvider<UserProfileBloc>(
                lazy: false,
                create: (context) {
                  return UserProfileBloc(_profileDetailsRepository)..add(const UserProfileLoadEvent());
                },
                child: _routeBuilders.bottomNavigationBuilder(navigationShell, _mainTabs),
              ),
            );
          },
          branches: _mainTabs
              .map(
                (tab) => switch (tab) {
                  BottomNavigationTab.start => _startBranch(),
                  BottomNavigationTab.account => _accountBranch(),
                },
              )
              .toList(growable: false),
        ),
      ],
    );
  }

  StatefulShellBranch _startBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.start,
      routes: [GoRoute(path: Routes.start, name: Routes.start, builder: _routeBuilders.startScreenBuilder)],
      observers: [_analyticsRepository.navigatorObserver],
    );
  }

  StatefulShellBranch _accountBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.account,
      routes: [GoRoute(path: Routes.account, name: Routes.account, builder: _routeBuilders.accountScreenBuilder)],
      observers: [_analyticsRepository.navigatorObserver],
    );
  }

  /// Only use to provide blocs to this single route.
  /// For blocs that are used on multiple screens down the hierarchy, use `routeWithInheritedBloc`.
  GoRoute routeWithBloc({
    required String path,
    required List<SingleChildWidget> providers,
    List<SingleChildWidget Function(BuildContext, GoRouterState)> providerBuilders = const [],
    required GoRouterWidgetBuilder builder,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      name: path,
      builder: (context, state) => MultiBlocProvider(
        providers: [...providers, ...providerBuilders.map((builder) => builder(context, state))],
        child: builder(context, state),
      ),
      routes: routes,
    );
  }

  /// Only use to provide blocs to all routes under this route.
  /// For blocs that are used only on a single screen, continue to provide them in the builders.
  ShellRoute routeWithInheritedBloc({
    required String path,
    required List<SingleChildWidget> providers,
    required GoRouterWidgetBuilder builder,
    required NavigatorObserver observer,
    List<RouteBase> routes = const [],
  }) {
    return ShellRoute(
      builder: (_, _, child) {
        return PopScope(
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              // Not triggered in observer
              unawaited(_analyticsRepository.logEvent(eventName: 'screen_leave', parameters: {'screen': path}));
            }
          },
          child: MultiBlocProvider(providers: providers, child: child),
        );
      },
      routes: [GoRoute(path: path, name: path, builder: builder, routes: routes)],
      observers: [observer],
    );
  }
}
