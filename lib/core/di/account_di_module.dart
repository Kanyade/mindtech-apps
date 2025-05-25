import 'package:app_skeleton/app/domain/profile/repository.dart';
import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/di/http_client_di_module.dart';
import 'package:app_skeleton/core/services/analytics/repository.dart';
import 'package:app_skeleton/core/services/crashlytics/repository.dart';
import 'package:dio/dio.dart';

class AccountDiModule extends DiModule {
  const AccountDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepository(
        http: getIt.get<Dio>(instanceName: HttpClientKeys.mobileApiClient),
        analytics: getIt.get<AnalyticsRepository>(),
        crashlytics: getIt.get<CrashlyticsRepository>(),
      ),
    );
  }
}
