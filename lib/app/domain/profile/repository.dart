import 'dart:async';

import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/app/domain/profile/model.jsn.dart';
import 'package:io_mindtechapps_hw/core/services/analytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/http/dio_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/disposable_refresh_repository.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';

enum UserProfileError { unknownError }

class UserProfileRepository implements DisposableRefreshRepository {
  UserProfileRepository({
    required Dio http,
    required AnalyticsRepository analytics,
    required CrashlyticsRepository crashlytics,
  }) : _analytics = analytics,
       _crashlytics = crashlytics,
       _http = http;

  final Dio _http;
  final AnalyticsRepository _analytics;
  final CrashlyticsRepository _crashlytics;

  UserProfile? _latestProfile;
  UserProfile? get cachedProfile => _latestProfile == null ? null : UserProfile.fromJson(_latestProfile!.toJson());

  Future<Result<UserProfile, UserProfileError>> getLatestProfile({bool forceRefresh = false}) async {
    if (forceRefresh || _latestProfile == null) {
      return refreshProfile();
    } else {
      return ResultData(_latestProfile!);
    }
  }

  Future<Result<UserProfile, UserProfileError>> refreshProfile() async {
    try {
      const accountID = 'TODO_GET_ACCOUNT_ID_FROM_AUTHENTICATION_REPOSITORY';
      final response = await _http.get('/profile/$accountID');

      if (response.isSuccessStatusCode) {
        final profile = UserProfile.fromJson(response.data);
        await _analytics.setUserProperties(accountID, profile.toJson());
        await _crashlytics.setUserProperties(accountID, profile.toJson());

        _latestProfile = profile;

        return ResultData(profile);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to refresh profile',
          message: response.statusMessage,
        );
      }
    } catch (e, st) {
      unawaited(_crashlytics.recordError(exception: e, stackTrace: st));
      return const ResultError(UserProfileError.unknownError);
    }
  }

  @override
  Future<void> refresh() => refreshProfile();

  @override
  Future<void> onDispose() => Future.value();
}
