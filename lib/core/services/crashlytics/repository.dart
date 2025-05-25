import 'package:io_mindtechapps_hw/core/services/crashlytics/crashlytics.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';

class CrashlyticsRepository {
  CrashlyticsRepository(this._crashlytics);
  final ICrashlytics _crashlytics;

  Future<void> initializeCrashlytics() {
    return _crashlytics.setCrashlyticsCollectionEnabled(enabled: true);
  }

  Future<void> setUserProperties(String accountID, Map<String, dynamic> properties) async {
    await _crashlytics.setUserProperties(accountID, properties);
    MindtechAppLogger.logSuccess('CrashlyticsRepository: done with setting user keys.');
  }

  Future<void> recordError({required dynamic exception, StackTrace? stackTrace, bool fatal = false}) {
    return _crashlytics.recordError(exception: exception, stackTrace: stackTrace, fatal: fatal);
  }
}
