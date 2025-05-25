import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/repository.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/di/http_client_di_module.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';

class TransactionsDiModule extends DiModule {
  const TransactionsDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingleton(
      TransactionsRepository(
        http: getIt.get<Dio>(instanceName: HttpClientKeys.mobileApiClient),
        authenticationRepository: getIt.get<AuthenticationRepository>(),
        crashlytics: getIt.get<CrashlyticsRepository>(),
      ),
    );
  }
}
