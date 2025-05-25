import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/router/router.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/settings.dart';

class NavigationDiModule extends DiModule {
  const NavigationDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton(
        RoutesBuilder(settings: getIt.get<Settings>(), analyticsRepository: getIt.get<AnalyticsRepository>()),
      )
      ..registerSingleton(
        MindtechAppRouter(
          getIt.get<CrashlyticsRepository>(),
          getIt.get<AnalyticsRepository>(),
          getIt.get<AuthenticationRepository>(),
          getIt.get<RoutesBuilder>(),
        ),
      );
  }
}
