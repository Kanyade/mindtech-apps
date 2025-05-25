part of 'bloc.dart';

sealed class UserProfileEvent implements BaseEvent {
  const UserProfileEvent();
}

class UserProfileLoadEvent extends UserProfileEvent implements RefreshEvent {
  const UserProfileLoadEvent({this.forceRefresh = false});

  @override
  final bool forceRefresh;
}
