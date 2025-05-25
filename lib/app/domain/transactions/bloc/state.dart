part of 'bloc.dart';

sealed class TransactionsState extends BaseState {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

final class TransactionsInitialState extends TransactionsState {
  const TransactionsInitialState();
}

final class TransactionsLoadingState extends TransactionsState {
  const TransactionsLoadingState();
}

final class TransactionsErrorState extends TransactionsState implements ErrorState<TransactionsError> {
  const TransactionsErrorState({required this.exception});

  @override
  final TransactionsError exception;

  @override
  List<Object> get props => [exception];
}

final class TransactionsLoadedState extends TransactionsState {
  const TransactionsLoadedState({required this.transactions});

  final List<Transaction> transactions;

  @override
  List<Object> get props => [transactions];
}
