part of 'bloc.dart';

sealed class TransactionsEvent implements BaseEvent {
  const TransactionsEvent();
}

class TransactionsLoadEvent extends TransactionsEvent implements RefreshEvent {
  const TransactionsLoadEvent({this.forceRefresh = false});

  @override
  final bool forceRefresh;
}
