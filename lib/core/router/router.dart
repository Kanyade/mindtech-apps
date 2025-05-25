import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/bloc/bloc.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/repository.dart';
import 'package:io_mindtechapps_hw/app/presentation/_components/bottom_navigation_menu.dart';
import 'package:io_mindtechapps_hw/app/presentation/authenticated/settings/screen.dart';
import 'package:io_mindtechapps_hw/app/presentation/authenticated/transactions/screen.dart';
import 'package:io_mindtechapps_hw/app/presentation/login/screen.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/settings.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

part 'navigator_keys.dart';
part 'routes.dart';
part 'routes_builder.dart';

enum BottomNavigationTab { transactions, settings }

class MindtechAppRouter {
  final CrashlyticsRepository _crashlyticsRepository;
  final UserSettingsRepository _userSettingsRepository;
  final AnalyticsRepository _analyticsRepository;
  final AuthenticationRepository _authenticationRepository;
  final RoutesBuilder _routeBuilders;

  late final GoRouter _router;
  GoRouter get router => _router;

  final List<BottomNavigationTab> _mainTabs;

  MindtechAppRouter(
    this._crashlyticsRepository,
    this._userSettingsRepository,
    this._analyticsRepository,
    this._authenticationRepository,
    this._routeBuilders, [
    this._mainTabs = BottomNavigationTab.values,
  ]) {
    MindtechAppLogger.logSuccess('MindtechAppRouter: Starting...');

    final listenable = _GoRouterRefreshStreamForAuthentication(_authenticationRepository.authStream);

    _router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      observers: [_analyticsRepository.navigatorObserver],
      navigatorKey: MindtechAppNavigatorKeys.navigationKey,
      initialLocation: _authenticationRepository.cachedProfile == null ? Routes.login : Routes.transactions,
      refreshListenable: listenable,
      redirect: (context, state) {
        final currentState = listenable.latestValue;
        final isLatestHandled = listenable.isLatestHandled;
        if (!isLatestHandled) {
          listenable.setIsLatestHandled(value: true);
          if (currentState == AuthStatus.unauthenticated) {
            return Routes.login;
          } else if (currentState == AuthStatus.authenticated) {
            return Routes.transactions;
          }
        }
        return null;
      },
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
        GoRoute(name: Routes.login, path: Routes.login, builder: _routeBuilders.loginScreenBuilder),
        StatefulShellRoute.indexedStack(
          builder: (_, _, navigationShell) {
            return _routeBuilders.bottomNavigationBuilder(navigationShell, _mainTabs);
          },
          branches: _mainTabs
              .map(
                (tab) => switch (tab) {
                  BottomNavigationTab.transactions => _transactionsBranch(),
                  BottomNavigationTab.settings => _settingsBranch(),
                },
              )
              .toList(growable: false),
        ),
      ],
    );
  }

  StatefulShellBranch _transactionsBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.transactions,
      routes: [
        GoRoute(
          path: Routes.transactions,
          name: Routes.transactions,
          builder: _routeBuilders.transactionsScreenBuilder,
        ),
      ],
      observers: [_analyticsRepository.navigatorObserver],
    );
  }

  StatefulShellBranch _settingsBranch() {
    return StatefulShellBranch(
      initialLocation: Routes.settings,
      routes: [
        routeWithBloc(
          path: Routes.settings,
          providers: [
            BlocProvider<UserSettingsBloc>(
              create: (_) => UserSettingsBloc(_userSettingsRepository)..add(const UserSettingsLoadEvent()),
            ),
          ],
          builder: _routeBuilders.settingsScreenBuilder,
        ),
      ],
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

class _GoRouterRefreshStreamForAuthentication extends ChangeNotifier {
  _GoRouterRefreshStreamForAuthentication(ValueStream<AuthStatus> stream) {
    notifyListeners();
    _subscription = stream.listen((value) {
      latestValue = value;
      isLatestHandled = false;
      notifyListeners();
    });
  }
  late final StreamSubscription<AuthStatus> _subscription;

  AuthStatus? latestValue;
  bool isLatestHandled = true;

  void setIsLatestHandled({required bool value}) => isLatestHandled = value;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
