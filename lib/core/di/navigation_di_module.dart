import 'package:app_skeleton/app/domain/profile/repository.dart';
import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/router/router.dart';
import 'package:app_skeleton/core/services/analytics/repository.dart';
import 'package:app_skeleton/core/services/crashlytics/repository.dart';

class NavigationDiModule extends DiModule {
  const NavigationDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton(RoutesBuilder(analyticsRepository: getIt.get<AnalyticsRepository>()))
      ..registerSingleton(
        AppSkeletonRouter(
          getIt.get<CrashlyticsRepository>(),
          getIt.get<AnalyticsRepository>(),
          getIt.get<UserProfileRepository>(),
          getIt.get<RoutesBuilder>(),
        ),
      );
  }
}
