import 'package:app_skeleton/core/di/account_di_module.dart';
import 'package:app_skeleton/core/di/analytics_di_module.dart';
import 'package:app_skeleton/core/di/di_module.dart';
import 'package:app_skeleton/core/di/http_client_di_module.dart';
import 'package:app_skeleton/core/di/navigation_di_module.dart';
import 'package:app_skeleton/core/di/settings_di_module.dart';
import 'package:app_skeleton/core/di/user_interaction_di_module.dart';
import 'package:app_skeleton/core/di/user_preferences_di_module.dart';
import 'package:app_skeleton/core/utils/logger.dart';

sealed class Bootstrapper {
  static Future<void> initialize() async {
    final stopwatch = Stopwatch()..start();

    AppSkeletonLogger.logSuccess('DI modules initialization starting up...');

    const List<DiModule> modules = [
      AnalyticsDiModule(),
      UserPreferencesDiModule(),
      HttpClientDiModule(),
      UserInteractionDiModule(),
      SettingsDiModule(),
      AccountDiModule(),
      NavigationDiModule(),
    ];

    for (final module in modules) {
      await module.initialize();
    }

    stopwatch.stop();
    AppSkeletonLogger.logSuccess('All DI modules finished bootstrapping in ${stopwatch.elapsedMilliseconds}ms');
  }

  static Future<void> restartDependencies() async {
    AppSkeletonLogger.logWarning('Service locator restart start...');

    await DiModule.resetDependencies();
    await initialize();

    AppSkeletonLogger.logWarning('Service locator restart end...');
  }
}
