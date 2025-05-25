part of 'authentication.dart';

//
// TYPES, ENUMS AND EXTENSIONS
//

enum AuthStatus { unauthenticated, authenticated }

enum AuthenticationError {
  NotAuthorizedException('NotAuthorizedException'),
  UserNotFoundException('UserNotFoundException'),
  TooManyRequestsException('TooManyRequestsException'),
  InvalidPasswordException('InvalidPasswordException'),
  UnknownException('UnknownException');

  final String code;
  const AuthenticationError(this.code);

  factory AuthenticationError.fromCode(String? code) =>
      values.firstWhere((e) => e.code == code, orElse: () => UnknownException);
}

//
// REPOSITORY
//

class AuthenticationRepository implements DisposableRepository {
  AuthenticationRepository({
    required Dio http,
    required AnalyticsRepository analytics,
    required CrashlyticsRepository crashlyticsRepository,
    required UserPreferences userPreferences,
  }) : _http = http,
       _analytics = analytics,
       _crashlyticsRepository = crashlyticsRepository,
       _userPreferences = userPreferences;

  //
  // DEPENDENCIES
  //

  final Dio _http;
  final AnalyticsRepository _analytics;
  final CrashlyticsRepository _crashlyticsRepository;
  final UserPreferences _userPreferences;

  //
  // ACTUAL DATA
  //

  final _initialization = Completer<bool>();
  final _userAccountSubject = BehaviorSubject<UserAccount?>();
  UserAccount? get cachedProfile => _userAccountSubject.valueOrNull;

  late final ValueStream<AuthStatus> authStream = _userAccountSubject.distinct().map((account) {
    if (account == null) return AuthStatus.unauthenticated;
    return AuthStatus.authenticated;
  }).shareValue();

  //
  // FUNCTIONS
  //

  Future<void> initialize() async {
    try {
      final userJsonString = await _userPreferences.readEncrypted(key: UserPreferenceKeys.userAccount);
      if (userJsonString != null) {
        final biometrics = LocalAuthentication();
        final authenticated = await biometrics.authenticate(
          localizedReason: 'Please authenticate to show account'.hardCoded,
          options: const AuthenticationOptions(useErrorDialogs: false),
        );
        if (authenticated) {
          final userAccount = UserAccount.fromJson(jsonDecode(userJsonString));
          _userAccountSubject.add(userAccount);
        } else {
          await _userPreferences.deleteEncrypted(key: UserPreferenceKeys.userAccount);
          _userAccountSubject.add(null);
        }
      } else {
        _userAccountSubject.add(null);
      }
    } catch (e, st) {
      unawaited(_crashlyticsRepository.recordError(exception: e, stackTrace: st));
    }
    _initialization.complete(true);
  }

  Future<Result<UserAccount, AuthenticationError>> login({required String email, required String password}) async {
    try {
      final response = await _http.get('/users', queryParameters: GetAccountRequest(email: email).toJson());

      if (response.isSuccessStatusCode) {
        final List<dynamic> users = response.data;
        if (users.isEmpty) return const ResultError(AuthenticationError.UserNotFoundException);
        final profile = UserAccount.fromJson(users.first);

        await _analytics.setUserProperties(profile.id.toString(), {});
        await _crashlyticsRepository.setUserProperties(profile.id.toString(), {});

        _userAccountSubject.add(profile);
        await _userPreferences
            .writeEncrypted(key: UserPreferenceKeys.userAccount, value: jsonEncode(profile.toJson()))
            .drainErrors();

        return ResultData(profile);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch profile',
          message: response.statusMessage,
        );
      }
    } catch (e, st) {
      unawaited(_crashlyticsRepository.recordError(exception: e, stackTrace: st));
      return const ResultError(AuthenticationError.UnknownException);
    }
  }

  Future<Result<void, AuthenticationError>> logout() async {
    try {
      await _userPreferences.deleteAllUnencrypted();
      await _userPreferences.deleteAllEncrypted();
      _userAccountSubject.add(null);
      return const ResultData(null);
    } catch (e, st) {
      unawaited(_crashlyticsRepository.recordError(exception: e, stackTrace: st));
      return const ResultError(AuthenticationError.UnknownException);
    }
  }

  @override
  FutureOr onDispose() async {
    await _userAccountSubject.close();
  }
}
