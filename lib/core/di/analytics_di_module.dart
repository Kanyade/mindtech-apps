import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/analytics.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/crashlytics.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/remote_config/repository.dart';

class AnalyticsDiModule extends DiModule {
  const AnalyticsDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton<ICrashlytics>(const Crashlytics())
      ..registerSingleton<CrashlyticsRepository>(CrashlyticsRepository(getIt.get<ICrashlytics>()))
      ..registerSingletonAsync<IRemoteConfigRepository>(() async {
        final s = RemoteConfigRepository(getIt.get<CrashlyticsRepository>());
        await s.init();
        return s;
      })
      ..registerSingleton<IAnalyticsService>(AnalyticsService())
      ..registerSingleton<AnalyticsRepository>(AnalyticsRepository(getIt.get<IAnalyticsService>()));
  }
}
