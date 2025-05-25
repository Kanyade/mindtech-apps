import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/app/domain/profile/repository.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/di/http_client_di_module.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';

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
