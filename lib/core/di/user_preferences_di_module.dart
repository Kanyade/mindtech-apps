import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/services/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesDiModule extends DiModule {
  const UserPreferencesDiModule();

  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingletonAsync<UserPreferences>(
      () async => UserPreferences(const FlutterSecureStorage(), await SharedPreferences.getInstance()),
    );
  }
}
