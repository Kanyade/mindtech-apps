import 'dart:async';

import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/app/domain/user_settings/models/get_settings_request.jsn.dart';
import 'package:io_mindtechapps_hw/app/domain/user_settings/models/model.jsn.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/http/dio_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/disposable_refresh_repository.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';

enum UserSettingsError { unknownError }

class UserSettingsRepository implements DisposableRefreshRepository {
  UserSettingsRepository({
    required Dio http,
    required AuthenticationRepository authenticationRepository,
    required CrashlyticsRepository crashlytics,
  }) : _authenticationRepository = authenticationRepository,
       _crashlytics = crashlytics,
       _http = http;

  final Dio _http;
  final AuthenticationRepository _authenticationRepository;
  final CrashlyticsRepository _crashlytics;

  UserSettings? _latestUserSettings;
  UserSettings? get cachedSettings =>
      _latestUserSettings == null ? null : UserSettings.fromJson(_latestUserSettings!.toJson());

  Future<Result<UserSettings, UserSettingsError>> getLatestSettings({bool forceRefresh = false}) async {
    if (forceRefresh || _latestUserSettings == null) {
      return refreshSettings();
    } else {
      return ResultData(_latestUserSettings!);
    }
  }

  Future<Result<UserSettings, UserSettingsError>> refreshSettings() async {
    try {
      final userId = _authenticationRepository.cachedProfile?.id;
      if (userId == null) throw Exception('User ID is null, cannot fetch settings');
      final response = await _http.get('/settings', queryParameters: GetSettingsRequest(userId: userId).toJson());

      if (response.isSuccessStatusCode) {
        final settings = UserSettings.fromJson(response.data);

        _latestUserSettings = settings;

        return ResultData(settings);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to refresh settings',
          message: response.statusMessage,
        );
      }
    } catch (e, st) {
      unawaited(_crashlytics.recordError(exception: e, stackTrace: st));
      return const ResultError(UserSettingsError.unknownError);
    }
  }

  @override
  Future<void> refresh() => refreshSettings();

  @override
  Future<void> onDispose() => Future.value();
}
