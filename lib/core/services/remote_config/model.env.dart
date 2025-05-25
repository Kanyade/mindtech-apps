import 'package:io_mindtechapps_hw/core/resources/app_resources.dart';
import 'package:envied/envied.dart';

part 'model.env.g.dart';

@Envied(path: '.env.qa', requireEnvFile: true, name: 'GeneratedQAConfig')
sealed class _DefaultQA {
  @EnviedField(varName: 'MOBILE_API_URL', obfuscate: true)
  static final String mobileApiUrl = _GeneratedQAConfig.mobileApiUrl;
}

@Envied(path: '.env.prod', requireEnvFile: true, name: 'GeneratedPRODConfig')
sealed class _DefaultPROD {
  @EnviedField(varName: 'MOBILE_API_URL', obfuscate: true)
  static final String mobileApiUrl = _GeneratedPRODConfig.mobileApiUrl;
}

class RemoteConfigModel {
  static const String mobileApiUrl = 'MOBILE_API_URL';

  static Map<String, dynamic> defaults() => switch (AppConstants.flavor) {
    AppFlavor.qa => {RemoteConfigModel.mobileApiUrl: _DefaultQA.mobileApiUrl},
    AppFlavor.prod => {RemoteConfigModel.mobileApiUrl: _DefaultPROD.mobileApiUrl},
  };
}
