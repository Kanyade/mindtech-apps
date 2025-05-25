import 'dart:async';

import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/app/domain/transactions/models/model.jsn.dart';
import 'package:io_mindtechapps_hw/app/domain/user_settings/models/get_settings_request.jsn.dart';
import 'package:io_mindtechapps_hw/core/authentication/authentication.dart';
import 'package:io_mindtechapps_hw/core/services/crashlytics/repository.dart';
import 'package:io_mindtechapps_hw/core/services/http/dio_extensions.dart';
import 'package:io_mindtechapps_hw/core/utils/disposable_refresh_repository.dart';
import 'package:io_mindtechapps_hw/core/utils/result.dart';

enum TransactionsError { unknownError }

class TransactionsRepository implements DisposableRefreshRepository {
  TransactionsRepository({
    required Dio http,
    required AuthenticationRepository authenticationRepository,
    required CrashlyticsRepository crashlytics,
  }) : _authenticationRepository = authenticationRepository,
       _crashlytics = crashlytics,
       _http = http;

  final Dio _http;
  final AuthenticationRepository _authenticationRepository;
  final CrashlyticsRepository _crashlytics;

  List<Transaction>? _latestTransactions;
  List<Transaction>? get cachedSettings => _latestTransactions == null ? null : [..._latestTransactions!];

  Future<Result<List<Transaction>, TransactionsError>> getTransactions({bool forceRefresh = false}) async {
    if (forceRefresh || _latestTransactions == null) {
      return refreshTransactions();
    } else {
      return ResultData(_latestTransactions!);
    }
  }

  Future<Result<List<Transaction>, TransactionsError>> refreshTransactions() async {
    try {
      final userId = _authenticationRepository.cachedProfile?.id;
      if (userId == null) throw Exception('User ID is null, cannot fetch settings');
      final response = await _http.get('/transactions', queryParameters: GetSettingsRequest(userId: userId).toJson());

      if (response.isSuccessStatusCode) {
        final transactions = (response.data as List)
            .map((json) => Transaction.fromJson(json as Map<String, dynamic>))
            .toList();

        _latestTransactions = transactions;

        return ResultData(transactions);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to refresh transactions',
          message: response.statusMessage,
        );
      }
    } catch (e, st) {
      unawaited(_crashlytics.recordError(exception: e, stackTrace: st));
      return const ResultError(TransactionsError.unknownError);
    }
  }

  @override
  Future<void> refresh() => refreshTransactions();

  @override
  Future<void> onDispose() => Future.value();
}
