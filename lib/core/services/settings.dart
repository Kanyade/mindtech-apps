import 'package:io_mindtechapps_hw/core/utils/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Settings {
  Settings();

  String? _appVersion;
  String? get appVersion => _appVersion;

  Future<void> init() async {
    try {
      _appVersion = await getAppVersion();
    } catch (e) {
      MindtechAppLogger.logError('Settings: Could not get appVersion!');
    }
  }

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
