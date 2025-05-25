import 'package:app_skeleton/core/services/crashlytics/repository.dart';
import 'package:app_skeleton/core/services/remote_config/model.env.dart';
import 'package:app_skeleton/core/utils/logger.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepository implements IRemoteConfigRepository {
  RemoteConfigRepository(this._crashlytics);

  final FirebaseRemoteConfig _remoteConfigInstance = FirebaseRemoteConfig.instance;
  final CrashlyticsRepository _crashlytics;

  @override
  Future<bool> init() async {
    await _remoteConfigInstance.setDefaults(RemoteConfigModel.defaults());

    _remoteConfigInstance.onConfigUpdated.listen((event) async {
      try {
        if (await _remoteConfigInstance.activate()) {
          AppSkeletonLogger.logInfo('FirebaseRemoteConfigRepository: Remote config updated');
        }
      } catch (e, st) {
        AppSkeletonLogger.logError('FirebaseRemoteConfigRepository: $e');

        _crashlytics
            .recordError(
              exception: 'FirebaseRemoteConfigRepository: crashed when updating in real-time with ex: ${e.toString()}',
              stackTrace: st,
            )
            .ignore();
      }
    });

    await _remoteConfigInstance.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: const Duration(hours: 1), minimumFetchInterval: const Duration(hours: 24)),
    );

    try {
      return await _remoteConfigInstance.fetchAndActivate();
    } catch (e, st) {
      AppSkeletonLogger.logError('FirebaseRemoteConfigRepository: $e');

      _crashlytics.recordError(exception: e, stackTrace: st, fatal: true).ignore();
    }

    return false;
  }

  @override
  Future<bool> getBool(String key) async {
    return _remoteConfigInstance.getBool(key);
  }

  @override
  Future<String> getString(String key) async {
    return _remoteConfigInstance.getString(key);
  }

  @override
  Future<double> getDouble(String key) async {
    return _remoteConfigInstance.getDouble(key);
  }

  @override
  Future<int> getInt(String key) async {
    return _remoteConfigInstance.getInt(key);
  }
}

abstract class IRemoteConfigRepository {
  Future<bool> init();
  Future<bool> getBool(String key);
  Future<String> getString(String key);
  Future<double> getDouble(String key);
  Future<int> getInt(String key);
}
