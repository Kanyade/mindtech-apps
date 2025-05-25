part of '../authentication.dart';

sealed class AuthenticationState extends BaseState {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}

class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState();
}

class AuthenticationErrorState extends AuthenticationState implements ErrorState<AuthenticationError> {
  const AuthenticationErrorState({required this.exception});

  @override
  final AuthenticationError exception;

  @override
  List<Object> get props => [exception];
}

class AuthenticationLoadedState extends AuthenticationState {
  const AuthenticationLoadedState({required this.userAccount});

  final UserAccount userAccount;

  @override
  List<Object> get props => [userAccount];
}
