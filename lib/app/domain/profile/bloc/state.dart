part of 'bloc.dart';

sealed class UserProfileState extends BaseState {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

final class UserProfileInitialState extends UserProfileState {
  const UserProfileInitialState();
}

final class UserProfileLoadingState extends UserProfileState {
  const UserProfileLoadingState();
}

final class UserProfileErrorState extends UserProfileState implements ErrorState<UserProfileError> {
  const UserProfileErrorState({required this.exception});

  @override
  final UserProfileError exception;

  @override
  List<Object> get props => [exception];
}

final class UserProfileLoadedState extends UserProfileState {
  const UserProfileLoadedState({required this.profile});

  final UserProfile profile;

  @override
  List<Object> get props => [profile];
}
