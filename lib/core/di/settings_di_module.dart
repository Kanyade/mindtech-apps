import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/services/settings.dart';

class SettingsDiModule extends DiModule {
  const SettingsDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingletonAsync<Settings>(() async {
      final settings = Settings();
      await settings.init();
      return settings;
    });
  }
}
