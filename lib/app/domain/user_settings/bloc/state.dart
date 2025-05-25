part of 'bloc.dart';

sealed class UserSettingsState extends BaseState {
  const UserSettingsState();

  @override
  List<Object?> get props => [];
}

final class UserSettingsInitialState extends UserSettingsState {
  const UserSettingsInitialState();
}

final class UserSettingsLoadingState extends UserSettingsState {
  const UserSettingsLoadingState();
}

final class UserSettingsErrorState extends UserSettingsState implements ErrorState<UserSettingsError> {
  const UserSettingsErrorState({required this.exception});

  @override
  final UserSettingsError exception;

  @override
  List<Object> get props => [exception];
}

final class UserSettingsLoadedState extends UserSettingsState {
  const UserSettingsLoadedState({required this.settings});

  final UserSettings settings;

  @override
  List<Object> get props => [settings];
}
