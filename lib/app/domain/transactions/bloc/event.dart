part of 'bloc.dart';

sealed class UserSettingsEvent implements BaseEvent {
  const UserSettingsEvent();
}

class UserSettingsLoadEvent extends UserSettingsEvent implements RefreshEvent {
  const UserSettingsLoadEvent({this.forceRefresh = false});

  @override
  final bool forceRefresh;
}
