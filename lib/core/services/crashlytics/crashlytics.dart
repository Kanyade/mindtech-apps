import 'package:io_mindtechapps_hw/core/utils/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class Crashlytics implements ICrashlytics {
  const Crashlytics();

  FirebaseCrashlytics get _instance => FirebaseCrashlytics.instance;

  @override
  Future<void> setCrashlyticsCollectionEnabled({required bool enabled}) {
    if (kDebugMode) {
      MindtechAppLogger.logSuccess('Crashlytics: setCrashlyticsCollectionEnabled: $enabled');
      return Future.value();
    } else {
      return _instance.setCrashlyticsCollectionEnabled(enabled);
    }
  }

  @override
  Future<void> setUserProperties(String accountID, Map<String, dynamic> properties) async {
    if (kDebugMode) {
      MindtechAppLogger.logSuccess('Crashlytics: setUserProperties: $properties');
    } else {
      await Future.wait([_instance.setUserIdentifier(accountID), ..._setUserPropertiesBatch(properties)]);
    }
  }

  Iterable<Future<void>> _setUserPropertiesBatch(Map<String, dynamic> properties) {
    return properties.entries.map((entry) async {
      return _instance.setCustomKey(entry.key, entry.value);
    });
  }

  @override
  Future<void> log(String message) => _instance.log(message);

  @override
  Future<void> recordError({dynamic exception, StackTrace? stackTrace, String? reason, bool fatal = false}) {
    if (kDebugMode) {
      MindtechAppLogger.logError(
        'Crashlytics: recordError: $exception, stackTrace: $stackTrace, reason: $reason, fatal: $fatal',
      );
      return Future.value();
    } else {
      return _instance.recordError(exception, stackTrace, reason: reason, fatal: fatal);
    }
  }

  @override
  Future<void> recordFlutterFatalError(FlutterErrorDetails flutterError) {
    if (kDebugMode) {
      MindtechAppLogger.logError('Crashlytics: recordFlutterFatalError: ${flutterError.exceptionAsString()}');
      return Future.value();
    } else {
      return _instance.recordFlutterError(flutterError);
    }
  }
}

abstract class ICrashlytics {
  Future<void> setCrashlyticsCollectionEnabled({required bool enabled});
  Future<void> setUserProperties(String accountID, Map<String, dynamic> properties);

  Future<void> log(String message);
  Future<void> recordError({dynamic exception, StackTrace? stackTrace, String? reason, bool fatal = false});
  Future<void> recordFlutterFatalError(FlutterErrorDetails flutterError);
}
