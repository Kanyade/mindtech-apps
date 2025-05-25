import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/services/user_preference.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
