import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/di/http_client_di_module.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/user_preference.dart';

class AuthenticationDiModule extends DiModule {
  const AuthenticationDiModule();

  @override
  Future<void> initializeModule(GetIt getIt) async {
    getIt.registerSingletonAsync<AuthenticationRepository>(() async {
      final repository = AuthenticationRepository(
        http: getIt.get<Dio>(instanceName: HttpClientKeys.mobileApiClient),
        analytics: getIt.get<AnalyticsRepository>(),
        userPreferences: getIt.get<UserPreferences>(),
        crashlyticsRepository: getIt.get<CrashlyticsRepository>(),
      );
      await repository.initialize();
      return repository;
    });
    await getIt.isReady<AuthenticationRepository>();
    getIt.registerSingleton<AuthenticationBloc>(AuthenticationBloc(getIt.get<AuthenticationRepository>()));
  }
}
