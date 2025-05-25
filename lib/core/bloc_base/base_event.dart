abstract interface class BaseEvent {
  const BaseEvent();
}

abstract class RefreshEvent {
  const RefreshEvent();

  bool get forceRefresh;
}
