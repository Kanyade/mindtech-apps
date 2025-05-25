import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/services/http/base_http_client.dart';
import 'package:app_skeleton/core/services/remote_config/model.env.dart';
import 'package:app_skeleton/core/services/remote_config/repository.dart';

class HttpClientDiModule extends DiModule {
  const HttpClientDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingletonAsync(
      () => createHttpClient(
        getBaseUrl: () => getIt.get<IRemoteConfigRepository>().getString(RemoteConfigModel.mobileApiUrl),
      ),
      instanceName: HttpClientKeys.mobileApiClient,
    );
  }
}

abstract final class HttpClientKeys {
  static const mobileApiClient = 'mobileApiClient';
}
