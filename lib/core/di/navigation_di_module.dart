import 'package:io_mindtechapps_hw/app/domain/profile/repository.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/router/router.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';

class NavigationDiModule extends DiModule {
  const NavigationDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton(RoutesBuilder(analyticsRepository: getIt.get<AnalyticsRepository>()))
      ..registerSingleton(
        MindtechAppRouter(
          getIt.get<CrashlyticsRepository>(),
          getIt.get<AnalyticsRepository>(),
          getIt.get<UserProfileRepository>(),
          getIt.get<RoutesBuilder>(),
        ),
      );
  }
}
