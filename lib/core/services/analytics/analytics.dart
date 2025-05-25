import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/string_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';

abstract class IAnalyticsService {
  NavigatorObserver get navigatorObserver;

  Future<void> init();
  Future<void> logEvent({required String eventName, required Map<String, Object?> parameters});
  Future<void> setUserProperties(String accountID, Map<String, dynamic> properties);
  Future<void> setCurrentScreen(String screen);
}

class AnalyticsService implements IAnalyticsService {
  AnalyticsService();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  NavigatorObserver get navigatorObserver => _NavigatorObserver(firebaseAnalyticsRepository: this);

  @override
  Future<void> init() async {
    if (kReleaseMode || AppConstants.kTestMode) {
      await _analytics.setAnalyticsCollectionEnabled(true);
    }
  }

  @override
  Future<void> logEvent({required String eventName, required Map<String, Object?> parameters}) async {
    if (kDebugMode) {
      MindtechAppLogger.logSuccess('FirebaseAnalyticsEvent: eventName: $eventName params: $parameters');
    } else {
      await _analytics.logEvent(
        name: eventName.take(39),
        parameters: parameters.map((key, value) => MapEntry(key.take(39), value.toString().snakeCase.take(99))),
      );
    }
  }

  @override
  Future<void> setUserProperties(String accountID, Map<String, dynamic> properties) async {
    if (kDebugMode) {
      MindtechAppLogger.logSuccess('FirebaseAnalyticsEvent: setUserProperties: $properties');
    } else {
      await Future.wait([
        _analytics.setDefaultEventParameters(properties),
        _analytics.setUserId(id: accountID),
        ..._setUserProperties(properties),
      ]);
    }
  }

  Iterable<Future<void>> _setUserProperties(Map<String, Object?> properties) {
    return properties.entries.map((entry) async {
      return _analytics.setUserProperty(name: entry.key, value: entry.value?.toString());
    });
  }

  @override
  Future<void> setCurrentScreen(String screen) {
    final parameters = {'screen': screen};
    if (kDebugMode) {
      MindtechAppLogger.logSuccess('FirebaseAnalyticsEvent: eventName: screen_view params: $parameters');
      return Future.value();
    } else {
      return _analytics.logScreenView(screenName: screen, parameters: parameters);
    }
  }
}

class _NavigatorObserver extends NavigatorObserver {
  final IAnalyticsService firebaseAnalyticsRepository;

  _NavigatorObserver({required this.firebaseAnalyticsRepository});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == previousRoute?.settings.name) return;
    if (route.settings.name != null) {
      unawaited(firebaseAnalyticsRepository.setCurrentScreen(_getLoggedScreenName(route)!));
    }
    if (previousRoute?.settings.name != null) {
      unawaited(
        firebaseAnalyticsRepository.logEvent(
          eventName: 'screen_leave',
          parameters: {'screen': _getLoggedScreenName(previousRoute!)!},
        ),
      );
    }
  }

  @override
  void didPop(Route<dynamic> poppedRoute, Route<dynamic>? route) {
    if (route?.settings.name == poppedRoute.settings.name) return;
    if (route?.settings.name != null) {
      unawaited(firebaseAnalyticsRepository.setCurrentScreen(_getLoggedScreenName(route!)!));
    }
    if (poppedRoute.settings.name != null) {
      unawaited(
        firebaseAnalyticsRepository.logEvent(
          eventName: 'screen_leave',
          parameters: {'screen': _getLoggedScreenName(poppedRoute)!},
        ),
      );
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name == oldRoute?.settings.name) return;
    if (newRoute?.settings.name != null) {
      unawaited(firebaseAnalyticsRepository.setCurrentScreen(_getLoggedScreenName(newRoute!)!));
    }
    if (oldRoute?.settings.name != null) {
      unawaited(
        firebaseAnalyticsRepository.logEvent(
          eventName: 'screen_leave',
          parameters: {'screen': _getLoggedScreenName(oldRoute!)!},
        ),
      );
    }
  }

  String? _getLoggedScreenName(Route<dynamic> route) {
    final settings = route.settings;
    if (settings is MaterialPage) {
      final screenKey = settings.key;
      if (screenKey is ValueKey && screenKey.value is String) {
        return screenKey.value.toString();
      }
    }
    return route.settings.name;
  }
}
