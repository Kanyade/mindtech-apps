import 'package:io_mindtechapps_hw/core/di/analytics_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/authentication_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/di_module.dart';
import 'package:io_mindtechapps_hw/core/di/http_client_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/navigation_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/settings_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/transactions_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/user_interaction_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/user_preferences_di_module.dart';
import 'package:io_mindtechapps_hw/core/di/user_settings_di_module.dart';
import 'package:io_mindtechapps_hw/core/utils/logger.dart';

sealed class Bootstrapper {
  static Future<void> initialize() async {
    final stopwatch = Stopwatch()..start();

    MindtechAppLogger.logSuccess('DI modules initialization starting up...');

    const List<DiModule> modules = [
      AnalyticsDiModule(),
      UserPreferencesDiModule(),
      HttpClientDiModule(),
      AuthenticationDiModule(),
      UserInteractionDiModule(),
      SettingsDiModule(),
      UserSettingsDiModule(),
      TransactionsDiModule(),
      NavigationDiModule(),
    ];

    for (final module in modules) {
      await module.initialize();
    }

    stopwatch.stop();
    MindtechAppLogger.logSuccess('All DI modules finished bootstrapping in ${stopwatch.elapsedMilliseconds}ms');
  }

  static Future<void> restartDependencies() async {
    MindtechAppLogger.logWarning('Service locator restart start...');

    await DiModule.resetDependencies();
    await initialize();

    MindtechAppLogger.logWarning('Service locator restart end...');
  }
}
