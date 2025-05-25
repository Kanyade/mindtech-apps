import 'package:io_mindtechapps_hw/core/services/analytics/analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsRepository {
  AnalyticsRepository(this._analytics);

  final IAnalyticsService _analytics;

  NavigatorObserver get navigatorObserver => _analytics.navigatorObserver;

  Future<void> init() => _analytics.init();

  Future<void> logEvent({required String eventName, Map<String, Object?>? parameters}) {
    return _analytics.logEvent(eventName: eventName, parameters: parameters ?? const <String, Object?>{});
  }

  Future<void> setUserProperties(String accountID, Map<String, dynamic> properties) =>
      _analytics.setUserProperties(accountID, properties);

  Future<void> setCurrentScreen(String screenName) => _analytics.setCurrentScreen(screenName);
}
