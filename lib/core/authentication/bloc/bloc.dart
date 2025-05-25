part of '../authentication.dart';

class AuthenticationBloc extends BaseBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
    : super(
        _authenticationRepository.cachedProfile == null
            ? const AuthenticationInitialState()
            : AuthenticationLoadedState(userAccount: _authenticationRepository.cachedProfile!),
      ) {
    on<AuthenticationLoginEvent>((event, emit) async {
      emit(const AuthenticationLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      final result = await _authenticationRepository.login(email: event.email, password: event.password);

      emit(switch (result) {
        final ResultData<UserAccount, AuthenticationError> data => AuthenticationLoadedState(userAccount: data.value),
        final ResultError<UserAccount, AuthenticationError> error => AuthenticationErrorState(
          exception: error.exception,
        ),
      });
    });
    on<AuthenticationLogoutEvent>((event, emit) async {
      emit(const AuthenticationLoadingState());
      final minimumDelay = Future.delayed(const Duration(seconds: 1));
      final result = await _authenticationRepository.logout();
      await minimumDelay;

      emit(switch (result) {
        final ResultData _ => const AuthenticationInitialState(),
        final ResultError<void, AuthenticationError> error => AuthenticationErrorState(exception: error.exception),
      });
    });
  }
}
