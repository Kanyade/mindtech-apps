part of '../authentication.dart';

sealed class AuthenticationEvent implements BaseEvent {
  const AuthenticationEvent();
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  const AuthenticationLoginEvent({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthenticationLogoutEvent extends AuthenticationEvent {
  const AuthenticationLogoutEvent();
}
